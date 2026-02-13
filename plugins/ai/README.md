# ai — AI chat via Ollama

Chat with AI models (default: deepseek-r1:14b), list models, and pull new models. Uses [Ollama](https://ollama.ai). Source CBASH to get aliases.

## Commands

| Command | Description |
|---------|-------------|
| `cbash ai` / `help` | Show help |
| `cbash ai aliases` | List aliases |
| `cbash ai chat [model]` | Start interactive chat (default model: deepseek-r1:14b) |
| `cbash ai deepseek` | Same as chat (default model) |
| `cbash ai list` | List installed Ollama models |
| `cbash ai pull <model>` | Pull a model (e.g. llama3, deepseek-r1:14b) |

## Aliases

| Alias | Command |
|-------|--------|
| `chat [model]` | ai chat |
| `aichat [model]` | ai chat |
| `ailist` | ai list |
| `aipull <model>` | ai pull |

## Prerequisites

- [Ollama](https://ollama.ai) installed and running

## Examples

```bash
chat                # chat with default model
aichat llama3
ailist
aipull deepseek-r1:14b
cbash ai aliases
```
