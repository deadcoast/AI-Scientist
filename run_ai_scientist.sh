#!/bin/bash
# AI-Scientist Runner Script
# This script makes it easy to run the AI-Scientist framework

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "   AI-Scientist Framework Runner"
echo "========================================="
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo -e "${RED}Error: .env file not found!${NC}"
    echo "Please create a .env file with your API keys."
    echo ""
    echo "Copy .env.example to .env and fill in your keys:"
    echo -e "${GREEN}cp .env.example .env${NC}"
    echo ""
    echo "Then edit .env and add your OPENAI_API_KEY"
    exit 1
fi

# Load environment variables from .env
export $(grep -v '^#' .env | xargs)

# Check if OPENAI_API_KEY is set
if [ -z "$OPENAI_API_KEY" ]; then
    echo -e "${RED}Error: OPENAI_API_KEY not set in .env file!${NC}"
    echo "Please edit .env and add your OpenAI API key."
    exit 1
fi

echo -e "${GREEN}✓ Environment configured${NC}"
echo ""

# Activate conda environment
echo "Activating ai_scientist conda environment..."
eval "$(conda shell.bash hook)"
conda activate ai_scientist

echo -e "${GREEN}✓ Environment activated${NC}"
echo ""

# Default parameters
MODEL=${MODEL:-"gpt-4o-2024-08-06"}
EXPERIMENT=${EXPERIMENT:-"nanoGPT_lite"}
NUM_IDEAS=${NUM_IDEAS:-2}

echo "Running AI-Scientist with:"
echo "  Model: $MODEL"
echo "  Experiment: $EXPERIMENT"
echo "  Number of Ideas: $NUM_IDEAS"
echo ""
echo "To customize, set environment variables before running:"
echo "  MODEL=gpt-4o EXPERIMENT=2d_diffusion NUM_IDEAS=5 ./run_ai_scientist.sh"
echo ""

# Run the AI-Scientist
python launch_scientist.py \
    --model "$MODEL" \
    --experiment "$EXPERIMENT" \
    --num-ideas "$NUM_IDEAS" \
    "$@"
