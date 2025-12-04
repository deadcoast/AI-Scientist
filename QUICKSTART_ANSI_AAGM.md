# Quick Start: AI-Scientist for ANSI:AAGM Development

## Prerequisites ✓

- ✓ Python 3.11 conda environment (`ai_scientist`)
- ✓ All dependencies installed
- ✓ LaTeX installed (`texlive-full`)
- ✓ CUDA/PyTorch for GPU acceleration

## Setup (5 minutes)

### 1. Add Your OpenAI API Key

Edit the `.env` file in this directory:

```bash
nano .env
```

Replace `your-openai-api-key-here` with your actual OpenAI API key.

### 2. Choose and Prepare a Template

For **algorithmic art generation** (recommended for ANSI:AAGM):

```bash
# Install NPEET dependency
git clone https://github.com/gregversteeg/NPEET.git
cd NPEET && pip install . && cd ..

# Create baseline run
conda activate ai_scientist
cd templates/2d_diffusion
python experiment.py --out_dir run_0
python plot.py
cd ../..
```

For **language models** (sequential processing):

```bash
# Prepare data
python data/enwik8/prepare.py
python data/shakespeare_char/prepare.py
python data/text8/prepare.py

# Create baseline
conda activate ai_scientist
cd templates/nanoGPT_lite
python experiment.py --out_dir run_0
python plot.py
cd ../..
```

### 3. Run AI-Scientist

**Option A: Use the helper script (easiest)**

```bash
# Basic run
./run_ai_scientist.sh

# Custom parameters
MODEL=gpt-4o EXPERIMENT=2d_diffusion NUM_IDEAS=5 ./run_ai_scientist.sh
```

**Option B: Use Python directly**

```bash
conda activate ai_scientist

# Basic run with nanoGPT_lite (lightest, fastest)
python launch_scientist.py \
    --model "gpt-4o-2024-08-06" \
    --experiment nanoGPT_lite \
    --num-ideas 2

# For art generation (2D diffusion)
python launch_scientist.py \
    --model "gpt-4o-2024-08-06" \
    --experiment 2d_diffusion \
    --num-ideas 3
```

## Expected Output

After running, you'll find generated papers in:

```
templates/[experiment]/[idea_name]/latex/template.pdf
```

Each idea folder contains:

- `experiment.py` - Modified code
- `notes.txt` - Execution log
- `latex/template.pdf` - Research paper
- `review.txt` - Automated review

## Common Commands

```bash
# Generate 5 ideas with GPT-4o
python launch_scientist.py --model "gpt-4o-2024-08-06" --experiment nanoGPT_lite --num-ideas 5

# Skip idea generation, reuse existing ideas
python launch_scientist.py --experiment nanoGPT_lite --skip-idea-generation

# Skip novelty check (faster)
python launch_scientist.py --experiment nanoGPT_lite --skip-novelty-check

# Run with o3-mini for advanced reasoning
python launch_scientist.py --model "o3-mini-2025-01-31" --experiment 2d_diffusion --num-ideas 3

# Parallel execution across 4 GPUs
python launch_scientist.py --model "gpt-4o-2024-08-06" --experiment nanoGPT_lite --parallel 4 --gpus "0,1,2,3"
```

## Troubleshooting

**"OpenAI API key not found"**

- Ensure `.env` file exists and contains `OPENAI_API_KEY=sk-...`
- Export it: `export $(grep -v '^#' .env | xargs)`

**"No such file or directory: run_0"**

- You need to create a baseline run first (see Step 2 above)
- Each template needs its own baseline

**"CUDA out of memory"**

- Reduce batch size in `experiment.py`
- Use `--gpus` flag to specify which GPU to use
- Try a lighter model or template

**"Module not found"**

- Activate conda environment: `conda activate ai_scientist`
- Install missing dependency: `pip install [package]`

## Next Steps

1. **Review Generated Papers** - Check `templates/[experiment]/[idea_name]/latex/template.pdf`
2. **Extract Insights** - Read papers to identify relevant concepts for ANSI:AAGM
3. **Iterate** - Run more experiments with different templates
4. **Refine Theory** - Use findings to develop ANSI:AAGM framework
5. **Create Custom Template** - Build ANSI:AAGM-specific template

## Full Documentation

- **ANSI:AAGM Guide**: `ANSI_AAGM_GUIDE.md` - Comprehensive guide for theory development
- **Main README**: `README.md` - Full AI-Scientist documentation
- **CTM Paper**: `continuous_development_machines/2505.05522v4.pdf` - Theoretical foundation

## Cost Estimates

Approximate OpenAI API costs per run:

- **nanoGPT_lite** (2 ideas): ~$10-20
- **2d_diffusion** (3 ideas): ~$15-30
- **Full run** (5 ideas, multiple templates): ~$50-100

Costs depend on:

- Model used (GPT-4o vs GPT-4o-mini)
- Number of ideas
- Experiment complexity
- Number of iterations

## Support

For issues specific to your ANSI:AAGM development:

- Review `ANSI_AAGM_GUIDE.md` for detailed workflows
- Check experiment logs in `notes.txt` files
- Verify baseline runs exist for your chosen template

---

**You're ready to start!** 🚀

The AI-Scientist framework is configured and ready to help you develop your ANSI:AAGM theory based on Continuous Thought Machines concepts.
