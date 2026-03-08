---
name: podcast-knowledge
description: Transform Apple Podcasts links into interactive knowledge extraction webpages. Automatically calls AnyGen to generate structured HTML knowledge pages with premium UI design.
user-invocable: true
metadata: {"openclaw": {"primaryEnv": "ANYGEN_API_KEY"}}
---

## Trigger

When the user sends an Apple Podcasts link (podcasts.apple.com), execute this skill.

## Workflow

You are an automation agent. Follow these steps exactly:

### Step 0: Check API Key

First, check if the `ANYGEN_API_KEY` environment variable is set:

```bash
echo $ANYGEN_API_KEY
```

If the output is empty or the variable is not set:
1. Ask the user: "This skill requires an AnyGen API Key to run. Please provide your AnyGen API Key (format: sk-ag-...):"
2. Wait for the user to provide the key.
3. Once received, save it to the OpenClaw config file by running:

```bash
CONFIG_FILE="$HOME/.openclaw/openclaw.json"

# Read existing config or create new one
if [ -f "$CONFIG_FILE" ]; then
  EXISTING_CONFIG=$(cat "$CONFIG_FILE")
else
  EXISTING_CONFIG='{}'
fi

# Use jq to merge the new API key into the config
echo "$EXISTING_CONFIG" | jq '.skills.entries["podcast-knowledge"].enabled = true | .skills.entries["podcast-knowledge"].env.ANYGEN_API_KEY = "<USER_PROVIDED_KEY>"' > "$CONFIG_FILE"
```

Replace `<USER_PROVIDED_KEY>` with the actual key the user provided.

4. Tell the user: "API Key saved to ~/.openclaw/openclaw.json. You won't need to enter it again next time. Please resend the podcast link to continue."
5. Stop here. The user needs to restart the session or re-trigger the skill for the env var to be loaded.

If `ANYGEN_API_KEY` is already set, proceed to Step 1.

### Step 1: Create AnyGen Task

The user will provide an Apple Podcasts link like `https://podcasts.apple.com/...`

Use the exec tool to call the helper script that creates the AnyGen task:

```bash
bash {baseDir}/create_task.sh "<user_provided_url>"
```

This script will:
- Read the English prompt template with premium UI design requirements
- Replace the share link placeholder with the actual URL
- Call the AnyGen API with operation=website
- Return the task creation response

Parse the response JSON. Extract `task_id` and `task_url`. If `success` is not `true`, tell the user the error.

### Step 2: Poll Task Status Until Fully Completed

IMPORTANT: Do NOT send the task_url to the user until the task status is `completed`. The user must receive a fully generated page, not a still-loading one.

Use a polling loop with the exec tool. Poll every 15 seconds, for up to 15 minutes:

```bash
curl -sS "https://www.anygen.io/v1/openapi/tasks/<task_id>" \
  -H "Authorization: Bearer $ANYGEN_API_KEY"
```

Check the `status` field in the response:
- If `status` is `completed` → proceed to Step 3.
- If `status` is `failed` → tell the user: "Task failed: <error message>" and stop.
- Otherwise (pending / processing) → wait 15 seconds and poll again.

While waiting, give the user a brief status update every ~45 seconds:
- "AnyGen is generating, please wait..."
- If `progress` field is available, include it: "Generating... (progress: XX%)"

Do NOT reveal the task_url during polling. Keep the user informed but patient.

### Step 3: Return Result (Only After Completion)

ONLY when `status` == `completed`:
- Send the user: "Knowledge extraction complete! Visit: <task_url>"
- `task_url` is the value returned from the create task response (e.g. `https://www.anygen.io/task/xxx`)
- If `output.file_url` also exists, include it as an additional download link.

If polling exceeds 15 minutes and the task is still not completed:
- Tell the user: "Generation is taking longer than usual. Here's the link — it will be available once complete: <task_url>"
- This is the ONLY scenario where you may send the link before completion.

## Important Notes

- Pass the Apple Podcasts link directly to AnyGen with English prompt and premium UI design (Linear/Vercel/Notion style).
- The generated page includes: Morandi color scheme mind map, original podcast hyperlink, light/dark mode toggle, and interactive features (tabs, accordion, checklist).
- The `ANYGEN_API_KEY` is managed by Step 0. If not set, the skill will ask the user for it and save it automatically.
- Do not ask the user for confirmation before proceeding — just execute the full pipeline automatically once a valid Apple Podcasts link is detected (after API key is confirmed).
