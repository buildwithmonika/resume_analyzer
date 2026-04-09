# 📄 Resume AI Analyzer

A one‑page web app that analyzes your resume (PDF/DOCX) using AI and gives you an ATS score, strengths, weaknesses and actionable suggestions/improvements. Built with **Rails 8**, **Hotwire**, and **OpenAI**.

No database, no sign‑up, no storage – just upload and get instant feedback.

## ✨ Features

- Upload a **PDF** or **DOCX** resume
- **AI‑powered analysis** (OpenAI gpt-5-nano)
- Returns:
  - ATS score (0–100)
  - Strengths & weaknesses
  - Improvement suggestions
- Results appear **without page reload** (Turbo Streams)
- **No database** – everything processed in memory
- UI with Tailwind CSS

## 🛠️ Tech Stack

- Ruby on Rails 8
- Hotwire (Turbo Frames / Streams)
- Tailwind CSS
- OpenAI API (`ruby-openai`)
- PDF & DOCX extraction (`pdf-reader`, `docx`)

## 🚀 Getting Started

### Prerequisites

- Ruby 3.3+
- Rails 8
- OpenAI API key ([Get one here](https://platform.openai.com/api-keys))

### Installation

```bash
git clone https://github.com/buildwithmonika/resume_analyzer.git
cd resume-ai-analyzer
bundle install
```

### Environment Variables

Create a `.env` file in the root directory:

```
OPENAI_ACCESS_TOKEN=your_openai_api_key_here
```

### Run the App

```bash
bin/dev
```

Open http://localhost:3000 in your browser.

---

## 📖 How to Use

1. Click the file input and select a PDF or DOCX resume.
2. Click “Analyze”.
3. Wait a few seconds – the AI analysis will appear below the form.
4. Review your ATS score, strengths, weaknesses and suggestions.
---

## 📁 Project Structure (Key Files)

```
app/
├── controllers/home_controller.rb
├── views/home/
│   ├── index.html.erb
│   └── _result.html.erb
├── services/resume_analyzer.rb
config/routes.rb
```

No models, no migrations, no database.

