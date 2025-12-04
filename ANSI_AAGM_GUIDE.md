# Guide: Using AI-Scientist to Develop ANSI:AAGM Theory

## Overview

This guide explains how to use the AI-Scientist framework to help develop and formulate your **ANSI:AAGM** (ANSI Algorithmic Art Generation Model) based on the Continuous Thought Machines (CTM) paper.

## What is ANSI:AAGM?

ANSI:AAGM is an algorithmic art generation model based on concepts from the 2025 paper "Continuous Thought Machines" (arxiv:2505.05522v4), which introduces:

- **Neuron-level temporal processing** - Each neuron has unique weight parameters
- **Neural synchronization** - Used as latent representation
- **Adaptive computation time** - Allows iterative refinement
- **Complex sequential reasoning** - Demonstrated on various tasks

## Quick Start

### 1. Set Up Your API Key

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env and add your OpenAI API key
# Replace 'your-openai-api-key-here' with your actual key
nano .env  # or use your preferred editor
```

### 2. Run AI-Scientist

Use the convenient runner script:

```bash
# Basic run (uses default settings)
./run_ai_scientist.sh

# Custom run with different parameters
MODEL=gpt-4o EXPERIMENT=2d_diffusion NUM_IDEAS=5 ./run_ai_scientist.sh

# Or use the Python script directly
conda activate ai_scientist
python launch_scientist.py --model "gpt-4o-2024-08-06" --experiment nanoGPT_lite --num-ideas 2
```

## Available Experiments

Choose an experiment template that aligns with your ANSI:AAGM concepts:

### Core Templates

1. **nanoGPT / nanoGPT_lite** - Language modeling, good for sequential processing
   - Similar to CTM's sequential reasoning capabilities
   - Text generation and character-level modeling

2. **2d_diffusion** - Generative modeling, good for art generation
   - Most relevant for algorithmic art generation
   - Diffusion-based image generation

3. **grokking** - Learning dynamics, good for understanding emergence
   - Explores sudden learning transitions
   - Could relate to CTM's adaptive computation

### Setup Requirements for Templates

#### For 2D Diffusion (Recommended for Art Generation)
```bash
# Install NPEET dependency
git clone https://github.com/gregversteeg/NPEET.git
cd NPEET && pip install . && cd ..

# Create baseline
cd templates/2d_diffusion
python experiment.py --out_dir run_0
python plot.py
cd ../..
```

#### For nanoGPT (Language Models)
```bash
# Prepare datasets
python data/enwik8/prepare.py
python data/shakespeare_char/prepare.py
python data/text8/prepare.py

# Create baseline
cd templates/nanoGPT_lite
python experiment.py --out_dir run_0
python plot.py
cd ../..
```

#### For Grokking (Learning Dynamics)
```bash
# Install dependency
pip install einops

# Create baseline
cd templates/grokking
python experiment.py --out_dir run_0
python plot.py
cd ../..
```

## How AI-Scientist Helps Your Theory Development

The AI-Scientist automates the research process:

1. **Idea Generation** - Generates novel research ideas based on CTM concepts
   - Can propose variations and extensions to your ANSI:AAGM theory
   - Uses literature search to ensure novelty

2. **Experiments** - Automatically implements and runs experiments
   - Tests hypotheses about neuron-level processing
   - Explores neural synchronization mechanisms
   - Validates adaptive computation approaches

3. **Paper Writing** - Generates LaTeX papers documenting findings
   - Creates formal documentation of your theory
   - Includes citations and proper academic formatting

4. **Review** - Provides automated peer review
   - Identifies strengths and weaknesses
   - Suggests improvements

## Recommended Workflow for ANSI:AAGM Development

### Phase 1: Initial Exploration (2D Diffusion)
Use the diffusion template to explore art generation concepts:

```bash
# Generate ideas for algorithmic art using diffusion models
python launch_scientist.py \
    --model "gpt-4o-2024-08-06" \
    --experiment 2d_diffusion \
    --num-ideas 5
```

**What to look for:**
- Novel sampling strategies
- Conditional generation techniques
- Neural architecture variations that could incorporate CTM concepts

### Phase 2: Sequential Processing (nanoGPT)
Use the language model template to explore sequential reasoning:

```bash
# Generate ideas for sequential processing
python launch_scientist.py \
    --model "gpt-4o-2024-08-06" \
    --experiment nanoGPT_lite \
    --num-ideas 3
```

**What to look for:**
- Temporal dynamics in neural processing
- Attention mechanisms that could relate to synchronization
- Adaptive computation strategies

### Phase 3: Create Custom Template
Based on insights from Phases 1-2, create a custom template specifically for ANSI:AAGM:

1. Copy an existing template:
```bash
cp -r templates/2d_diffusion templates/ansi_aagm
```

2. Modify `prompt.json` to describe ANSI:AAGM concepts
3. Update `experiment.py` to implement CTM-inspired architecture
4. Create seed ideas in `seed_ideas.json` based on your theory
5. Generate baseline results

Then run:
```bash
python launch_scientist.py \
    --model "gpt-4o-2024-08-06" \
    --experiment ansi_aagm \
    --num-ideas 5
```

## Key CTM Concepts to Incorporate

When developing ideas, consider these CTM principles:

1. **Neuron-Level Models (NLMs)**
   - Per-neuron MLPs processing activation histories
   - Each neuron has private parameters θ_d

2. **Neural Synchronization**
   - Computed as: S^t = Z^t · (Z^t)^T
   - Used as alternative to standard activations

3. **Internal Ticks**
   - Decoupled time dimension for iterative refinement
   - Allows adaptive computation based on task difficulty

4. **Training Objectives**
   - Minimize loss at minimum loss point
   - Maximize certainty at maximum certainty point

## Model Selection

For ANSI:AAGM development, consider:

- **GPT-4o** - Best for general research and paper quality
- **GPT-4o-mini** - Faster and cheaper for initial exploration
- **o1/o3-mini** - Advanced reasoning for complex theory development

```bash
# For deep theoretical exploration (recommended)
MODEL=o3-mini-2025-01-31 ./run_ai_scientist.sh

# For fast iteration
MODEL=gpt-4o-mini ./run_ai_scientist.sh

# For best paper quality
MODEL=gpt-4o-2024-08-06 ./run_ai_scientist.sh
```

## Output Structure

After running, you'll find:

```
templates/[experiment]/
├── ideas.json              # Generated research ideas
├── run_0/                  # Baseline results
├── run_1/, run_2/, ...     # Experiment results
└── [idea_name]/
    ├── experiment.py       # Modified code
    ├── notes.txt          # Experiment log
    ├── plot.py            # Visualization
    ├── latex/
    │   └── template.pdf   # Generated paper
    └── review.txt         # Automated review
```

## Tips for Best Results

1. **Start Small** - Begin with 2-3 ideas to understand the process
2. **Review Papers** - Read generated papers to extract insights
3. **Iterate** - Use `--skip-idea-generation` to rerun experiments
4. **Document Insights** - Keep notes on which ideas align with ANSI:AAGM
5. **Combine Approaches** - Synthesize ideas from multiple templates

## Troubleshooting

### API Key Issues
```bash
# Verify your API key is set
echo $OPENAI_API_KEY

# Re-source your .env file
export $(grep -v '^#' .env | xargs)
```

### GPU/CUDA Issues
The framework requires CUDA for running experiments. Ensure:
- NVIDIA GPU is available
- CUDA and PyTorch are properly installed
- Check with: `python -c "import torch; print(torch.cuda.is_available())"`

### Experiment Failures
- Check `notes.txt` in the experiment directory for error logs
- Verify baseline run_0 exists for your template
- Ensure all dependencies are installed

## Next Steps

1. **Generate Initial Ideas** - Run AI-Scientist on relevant templates
2. **Extract Insights** - Review generated papers and identify promising directions
3. **Refine Theory** - Use findings to refine ANSI:AAGM concepts
4. **Create Custom Template** - Build a template specific to your theory
5. **Iterate** - Continuously refine based on experimental results

## Additional Resources

- Main README: `/README.md`
- CTM Paper: `/continuous_development_machines/2505.05522v4.pdf`
- Template Examples: `/templates/`
- Example Papers: `/example_papers/`

## Support

If you encounter issues:
1. Check the main README.md for general troubleshooting
2. Review the AI-Scientist GitHub issues: https://github.com/anthropics/claude-code/issues
3. Verify all dependencies are installed: `pip list`

---

**Remember:** AI-Scientist is a tool to accelerate your research. It generates ideas and conducts experiments, but you bring the creative vision and theoretical insights for ANSI:AAGM!
