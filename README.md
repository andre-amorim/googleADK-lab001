# Gemini AI Agent

This repository contains the source code for a Google ADK AI Agent, configured to use the Gemini model.

## Purpose

The purpose of this agent is to serve as a helpful assistant for user questions. It is built using the Google ADK framework and utilizes Google's Generative AI models.

## Prerequisites

This project uses a reproducible environment managed by **Nix** and **uv**.

*   **Nix**: For system-level dependencies.
*   **uv**: For Python package management.

Ensure you have Nix installed on your system.

## Setup

Follow these steps to set up your development environment:

1.  **Configure Architecture**: Open `flake.nix` and ensure the system variable in the `[USER CONFIGURATION]` block matches your machine's architecture (e.g., `aarch64-darwin` for Apple Silicon, `x86_64-linux` for Linux).

2.  **Enter Nix Environment**:
    ```bash
    nix develop
    ```

3.  **Create Virtual Environment**:
    Link `uv` to the Nix-provided Python:
    ```bash
    uv venv --python $(which python)
    ```

4.  **Activate Environment**:
    ```bash
    source .venv/bin/activate
    ```

5.  **Install Dependencies**:
    ```bash
    uv pip install google-adk google-genai
    ```

6.  **Set API Key**:
    You need a Google AI Studio API key. Set it as an environment variable:
    ```bash
    export GEMINI_API_KEY='your-api-key'
    ```
    Or create a `.env` file in `my-gemini-agent/` (make sure it's git-ignored).

## Configuration

The agent definition is located in `my-gemini-agent/agent.py`.

*   **Model**: You must update the `model` parameter in `agent.py` to a valid model name (e.g., `gemini-1.5-pro`). Replace `<FILL_IN_MODEL>`.

## Usage

To deploy the agent locally and test it via the web interface:

```bash
adk deploy --web
```

## Directory Structure

*   `my-gemini-agent/`: Contains the agent source code.
    *   `agent.py`: Defines the `root_agent`.
    *   `__init__.py`: Package initialization.
*   `flake.nix`: Nix configuration for system dependencies.
*   `flake.lock`: Lock file for Nix dependencies.
