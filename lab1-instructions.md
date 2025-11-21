# Lab 1: Setting Up Google ADK Agent with uv and Nix

## Overview
This lab phase focuses on initializing a Google ADK AI Agent project using the hybrid Nix + uv workflow for reproducibility. We'll create a virtual environment, install dependencies, set up the API key, scaffold the agent, and prepare for deployment.

## Prerequisites
- Ensure `flake.nix` is configured for your architecture (e.g., `aarch64-darwin` for Apple Silicon).
- Nix and uv are installed and working.

## Steps

### 1. Initialize Environment
Create a new project folder and navigate into it (if not already done).

```bash
mkdir Gemini-3-Pro-AI-agent
cd Gemini-3-Pro-AI-agent
```

### 2. Enter Nix Environment
Run `nix develop` to load the reproducible infrastructure.

```bash
nix develop
```

### 3. Create Virtual Environment
Link uv to the Nix-provided Python.

```bash
uv venv --python $(which python)
```

### 4. Activate Environment
Activate the virtual environment.

```bash
source .venv/bin/activate
```

### 5. Install Dependencies
Install the required Google ADK and Google GenAI libraries.

```bash
uv pip install google-adk google-genai
```

### 6. Set API Key
Export your Google AI Studio API key as an environment variable. Replace `'your-api-key'` with your actual key.

**Reminder**: For best practices, store your API key in the `.env` file instead of exporting it directly in the terminal. This keeps secrets secure. Ensure `.env` is added to `.gitignore` to prevent accidental commits to public repositories.

```bash
export GEMINI_API_KEY='your-api-key'
```

Alternatively, add to `.env`:
```
GEMINI_API_KEY=your-api-key
```

### 7. Create Agent Scaffolding
Use the ADK tool to create the agent's file structure and boilerplate code. Choose a model when prompted (e.g., gemini-2.5-flash or other).

```bash
adk create my-gemini-agent
```

This will generate:
- `.env`
- `__init__.py`
- `agent.py`

### 8. Deploy Agent (Optional)
Deploy the finished agent to the ADK web interface for testing.

```bash
adk deploy --web
```

## File Structure After Completion
```
Gemini-3-Pro-AI-agent/
├── .gitignore             # Git ignore file (includes .env and .venv)
├── .venv/                 # Virtual environment (ephemeral)
├── flake.nix              # Nix configuration
├── uv.lock                # Python dependencies lockfile
├── my-gemini-agent/       # Agent scaffold
│   ├── .env
│   ├── __init__.py
│   └── agent.py
└── instructions.md        # This file
```

## Troubleshooting
- If `adk create` fails, ensure the API key is set correctly.
- For model configuration, refer to the ADK docs: https://google.github.io/adk-docs/agents/models
- If packages fail to install, verify you're in the activated venv and Nix environment.

## Next Steps
Once the agent is scaffolded, you can edit `agent.py` to customize the agent's behavior and proceed to testing or further development.