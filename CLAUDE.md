# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The AI Scientist is an automated system for fully autonomous scientific discovery. It uses LLMs to generate research ideas, conduct experiments, write papers, and review results. The system requires NVIDIA GPUs with CUDA and PyTorch on Linux.

## Essential Commands

### Environment Setup
```bash
conda create -n ai_scientist python=3.11
conda activate ai_scientist
sudo apt-get install texlive-full  # Required for LaTeX paper generation
pip install -r requirements.txt
```

### Running Paper Generation
```bash
# Basic run with a specific model and template
python launch_scientist.py --model "claude-3-5-sonnet-20241022" --experiment nanoGPT_lite --num-ideas 2

# Parallel execution across GPUs
python launch_scientist.py --model "gpt-4o-2024-05-13" --experiment 2d_diffusion --num-ideas 5 --parallel 4

# Skip idea generation (use existing ideas.json)
python launch_scientist.py --experiment grokking --skip-idea-generation

# Skip novelty check
python launch_scientist.py --experiment nanoGPT --skip-novelty-check
```

### Template Setup (Required Before First Run)
Each template needs baseline runs created before use:
```bash
# NanoGPT - requires data preparation first
python data/enwik8/prepare.py
python data/shakespeare_char/prepare.py
python data/text8/prepare.py
cd templates/nanoGPT && python experiment.py --out_dir run_0 && python plot.py

# 2D Diffusion - requires NPEET
git clone https://github.com/gregversteeg/NPEET.git && cd NPEET && pip install .
cd templates/2d_diffusion && python experiment.py --out_dir run_0 && python plot.py

# Grokking
pip install einops
cd templates/grokking && python experiment.py --out_dir run_0 && python plot.py
```

### Standalone Review Generation
```bash
cd review_iclr_bench
python iclr_analysis.py --num_reviews 500 --batch_size 100 --num_fs_examples 1 --num_reflections 5
```

## Architecture

### Core Pipeline (`launch_scientist.py`)
The main orchestrator that runs the full pipeline:
1. **Idea Generation** (`ai_scientist/generate_ideas.py`) - LLM generates novel research ideas, checks against literature via Semantic Scholar/OpenAlex API
2. **Experiments** (`ai_scientist/perform_experiments.py`) - Aider modifies `experiment.py`, runs up to 5 experiments with `--out_dir=run_N`
3. **Writeup** (`ai_scientist/perform_writeup.py`) - Generates LaTeX paper section-by-section, adds citations, compiles PDF
4. **Review** (`ai_scientist/perform_review.py`) - LLM reviews the generated paper using NeurIPS-style criteria

### LLM Integration (`ai_scientist/llm.py`)
- Supports: OpenAI (GPT-4o, o1, o3-mini), Anthropic (Claude), DeepSeek, Gemini, Llama via OpenRouter
- Bedrock and Vertex AI support for Claude models
- Key functions: `create_client()`, `get_response_from_llm()`, `get_batch_responses_from_llm()`

### Template Structure
Each template in `templates/` contains:
- `experiment.py` - Main experiment script (must accept `--out_dir` argument)
- `plot.py` - Generates plots from run folders
- `prompt.json` - Task description and system prompt
- `seed_ideas.json` - Example ideas for few-shot prompting
- `latex/template.tex` - Paper template with pre-loaded citations
- `run_0/` - Baseline results (machine-specific, must be generated locally)

### Key Constants
- `MAX_RUNS = 5` - Maximum experiment iterations per idea
- `MAX_ITERS = 4` - Maximum retries per experiment
- `MAX_NUM_TOKENS = 4096` - LLM response token limit
- Experiment timeout: 7200 seconds (2 hours)

## Environment Variables

Required API keys (set based on model used):
- `OPENAI_API_KEY` - GPT models
- `ANTHROPIC_API_KEY` - Claude models
- `DEEPSEEK_API_KEY` - DeepSeek models
- `OPENROUTER_API_KEY` - Llama models
- `GEMINI_API_KEY` - Gemini models
- `S2_API_KEY` - Semantic Scholar (optional, for literature search)
- `OPENALEX_MAIL_ADDRESS` - OpenAlex (alternative to Semantic Scholar)

For cloud Claude access:
- AWS: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION_NAME`
- Vertex AI: `CLOUD_ML_REGION`, `ANTHROPIC_VERTEX_PROJECT_ID`, `VERTEXAI_LOCATION`, `VERTEXAI_PROJECT`

## Available Templates

Core templates: `nanoGPT`, `nanoGPT_lite`, `2d_diffusion`, `grokking`

Community templates: `MACE`, `earthquake-prediction`, `mobilenetV3`, `probes`, `seir`, `sketch_rnn`, `tensorf`
