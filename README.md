[README.md](https://github.com/user-attachments/files/25826498/README.md)
# Podcast Knowledge Extraction Skill

Transform Apple Podcasts episodes into beautiful, interactive knowledge extraction webpages powered by AnyGen.

## ✨ Features

- 🎯 **Deep Content Analysis**: Extracts core themes, key viewpoints, hard information, thinking frameworks, actionable advice, and supplementary knowledge
- 🎨 **Premium UI Design**: Modern SaaS-style interface (Linear/Vercel/Notion inspired) with light/dark mode
- 🗺️ **Morandi Color Mind Maps**: Elegant, low-saturation mind maps using Mermaid.js
- 📑 **Interactive Components**: Tabs, accordions, and checkable task lists
- 🔗 **Source Attribution**: Direct link to original podcast episode
- 🌐 **Fully Responsive**: Works seamlessly across all devices

## 🎬 Demo

Check out these example outputs:
- [How the Unconscious Mind Shapes Choices (and How to Influence It)](https://www.anygen.io/share/5vLtzgkSQHhvtL6QsN5HP8?share_id=7586609367986802401)
- [The Psychology of Whimsy: Why Play Is So Powerful](https://www.anygen.io/share/3OnNkc1UZ3mWmRfiKvqe8P?share_id=7586609367986802401)
- [The Secret of Charisma: Why Clarity in Uncertainty Can Enchant—and Mislead](https://www.anygen.io/share/5nYjGLMhU7h2G7l4OUmVhN?share_id=7586609367986802401)

## 📋 Prerequisites

- [OpenClaw](https://github.com/anthropics/openclaw) installed
- AnyGen API Key (get one at [anygen.io](https://www.anygen.io/integration/openclaw))

## 🚀 Installation

1. Clone this repository or download the skill folder:
```bash
git clone https://github.com/YOUR_USERNAME/podcast-knowledge-skill.git
```

2. Copy the skill to your OpenClaw skills directory:
```bash
cp -r podcast-knowledge-skill ~/.openclaw/skills/podcast-knowledge
```

3. Set up your AnyGen API Key:
```bash
export ANYGEN_API_KEY="sk-ag-your-key-here"
```

Or the skill will prompt you to enter it on first use and save it automatically.

## 💡 Usage

Simply send an Apple Podcasts link to OpenClaw:

```
https://podcasts.apple.com/cn/podcast/episode-name/id123456789?i=1000123456789
```

The skill will automatically:
1. ✅ Detect the Apple Podcasts link
2. ✅ Create an AnyGen task with the optimized prompt
3. ✅ Poll for completion (typically 8-10 minutes)
4. ✅ Return a fully interactive webpage

## 📊 Output Structure

The generated webpage includes 6 key sections:

1. **🎯 Core Themes**: One-sentence summary + keywords + mind map
2. **💡 Key Viewpoints**: Counter-intuitive insights and core arguments
3. **📊 Hard Information**: Specific data, facts, cases, and research
4. **🔄 Thinking Angles**: Frameworks and mental models used
5. **🛠️ Actionable Advice**: Practical steps you can apply immediately
6. **🔗 Supplementary Knowledge**: Background on terms, theories, books, and figures

## 🎨 Design Highlights

- **Light Mode**: Premium light gray background (#F9FAFB) with pure white cards
- **Dark Mode**: Deep blue-gray background (#0F172A) with elevated dark cards
- **Typography**: Enhanced contrast, generous line height, ample whitespace
- **Mind Maps**: Morandi color palette (dusty blue, sage green, beige) for visual harmony

## 🛠️ Technical Details

- **Language**: English prompt for optimal AnyGen performance
- **Operation**: Website generation via AnyGen API
- **Polling**: Smart status checking every 15 seconds
- **Timeout**: 15-minute maximum wait time

## 📝 Files

```
podcast-knowledge/
├── SKILL.md                 # Skill definition and workflow
├── create_task.sh           # Task creation script
├── prompt_template_en.txt   # English prompt template
└── README.md               # This file
```

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Share your generated examples

## 📄 License

MIT License - feel free to use and modify as needed.

## 🙏 Acknowledgments

- Built for [OpenClaw](https://github.com/anthropics/openclaw)
- Powered by [AnyGen](https://www.anygen.io)
- Inspired by modern SaaS design principles

## 📮 Contact

Questions or feedback? Open an issue or reach out on X/Twitter.

---

**Note**: This skill currently supports Apple Podcasts only. The generated content quality depends on the podcast's audio clarity and content depth.
