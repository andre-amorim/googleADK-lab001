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

1.  **Choose a dev shell (multi-system)**: This repository now provides pre-configured Nix development shells for multiple platforms (e.g., `aarch64-linux` and `aarch64-darwin`) so you don't need to edit `flake.nix` to switch targets.

        - Show available dev shells:
            ```bash
            nix flake show
            ```

        - Start the Linux ARM64 dev shell:
            ```bash
            nix develop .#devShells.aarch64-linux.default
            ```

        - Start the macOS Apple Silicon dev shell (on macOS hosts only):
            ```bash
            nix develop .#devShells.aarch64-darwin.default
            ```

        - Run commands directly without entering a full shell:
            ```bash
            nix develop .#devShells.aarch64-linux.default --command python --version
            ```

        - Note: On a Linux host, attempting to enter an `aarch64-darwin` shell will fail (expected) unless you are using macOS.

2.  **Enter Nix Environment**:
    ```bash
    # Pick the devShell for the desired system, for example aarch64-linux
    nix develop .#devShells.aarch64-linux.default

    # Or use the convenience script that also prepares a uv venv for you:
    # - Creates a `.venv` (if missing)
    # - Activates the `.venv` and opens an interactive shell
    # - Supports `--run` to execute a one-off command and exit
    ```bash
    # Start an interactive shell (script auto-detects the host system and shell):
    ./scripts/dev

    # You can also specify the system or shell explicitly
    ./scripts/dev --system x86_64-linux --shell zsh

    # Run a command without entering the interactive shell
    ./scripts/dev --run 'python --version; uv --version'

    # Use help to see available flags
    ./scripts/dev --help
    ```
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
