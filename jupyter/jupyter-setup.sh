#!/bin/bash

# Jupyter Environment Setup Script with UV
# Usage: new-jupyter <project-name>

set -e  # Exit on any error

if [ -z "$1" ]; then
    echo "❌ Error: Please provide a project name"
    echo "Usage: new-jupyter <project-name>"
    exit 1
fi

PROJECT_NAME="$1"

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "❌ Error: uv is not installed. Please install it first:"
    echo "curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

# Create project directory
if [ -d "$PROJECT_NAME" ]; then
    echo "❌ Error: Directory '$PROJECT_NAME' already exists"
    exit 1
fi

mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

echo "📁 Created directory: $PROJECT_NAME"

# Initialize git repository
git init
echo "🔧 Initialized git repository"

# Create Python project with uv
uv init --python 3.11
echo "🐍 Initialized Python project with uv"

# Delete main.py
rm hello.py

# Install data science packages
echo "📦 Installing data science packages..."
uv add jupyter \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    scikit-learn \
    plotly \
    requests \
    openpyxl \
    xlsxwriter \
    scipy \
    statsmodels \
    ipywidgets \
    tqdm

echo "✅ Installed core data analysis packages"

# Create data directory
mkdir -p data/{raw,processed}
echo "📊 Created data directory structure"

# Copy custom toolbox
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -d "$SCRIPT_DIR/tys-toolbox" ]; then
    cp -r "$SCRIPT_DIR/tys-toolbox" ./
    echo "🧰 Copied custom toolbox"
else
    echo "⚠️  Warning: tys-toolbox not found in $SCRIPT_DIR"
fi

# Create .gitignore
cat > .gitignore << 'EOF'
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Jupyter Notebook
.ipynb_checkpoints

# Environment variables
.env

# Data files (uncomment if you want to ignore data)
# data/

# Virtual environment
.venv/
venv/

# IDE
.vscode/
.idea/
*.swp
*.swo

# macOS
.DS_Store

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# PyInstaller
*.manifest
*.spec

# Unit test / coverage reports
htmlcov/
.tox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/
EOF

echo "🚫 Created .gitignore file"

# Create main.ipynb with boilerplate
cat > main.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Project Analysis\n",
    "\n",
    "## Overview\n",
    "Brief description of the project and objectives.\n",
    "\n",
    "## Data Sources\n",
    "- Source 1: Description\n",
    "- Source 2: Description\n",
    "\n",
    "## Key Findings\n",
    "- Finding 1\n",
    "- Finding 2"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Setup and Imports"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Core libraries\n",
    "import pandas as pd\n",
    "import numpy as np\n",
    "import matplotlib.pyplot as plt\n",
    "import seaborn as sns\n",
    "import plotly.express as px\n",
    "import plotly.graph_objects as go\n",
    "\n",
    "# Custom toolbox imports\n",
    "from tys_toolbox import *\n",
    "\n",
    "# Utilities\n",
    "import os\n",
    "import sys\n",
    "from pathlib import Path\n",
    "import requests\n",
    "from tqdm import tqdm\n",
    "\n",
    "# Configure plotting\n",
    "plt.style.use('default')\n",
    "sns.set_palette(\"husl\")\n",
    "%matplotlib inline\n",
    "\n",
    "# Display options\n",
    "pd.set_option('display.max_columns', None)\n",
    "pd.set_option('display.max_rows', 100)\n",
    "pd.set_option('display.width', None)\n",
    "\n",
    "print(\"📊 Environment setup complete!\")\n",
    "print(f\"🐍 Python version: {sys.version.split()[0]}\")\n",
    "print(f\"🐼 Pandas version: {pd.__version__}\")\n",
    "print(f\"🔢 NumPy version: {np.__version__}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Data Loading"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Define data paths\n",
    "DATA_DIR = Path('./data')\n",
    "RAW_DATA_DIR = DATA_DIR / 'raw'\n",
    "PROCESSED_DATA_DIR = DATA_DIR / 'processed'\n",
    "\n",
    "# Load your data here\n",
    "# df = pd.read_csv(RAW_DATA_DIR / 'your_file.csv')\n",
    "\n",
    "print(f\"📁 Data directories available:\")\n",
    "print(f\"   Raw: {RAW_DATA_DIR}\")\n",
    "print(f\"   Processed: {PROCESSED_DATA_DIR}\")\n",
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Exploratory Data Analysis"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF

echo "📓 Created main.ipynb with boilerplate"
# Create README.md
cat > README.md << EOF
# $PROJECT_NAME

## Setup

This project uses [uv](https://github.com/astral-sh/uv) for fast Python package management.

### Installation

1. Install dependencies:
   \`\`\`bash
   uv sync
   \`\`\`

2. Start Jupyter:
   \`\`\`bash
   uv run jupyter lab
   \`\`\`

## Project Structure

\`\`\`
$PROJECT_NAME/
├── data/
│   ├── raw/          # Original, immutable data
│   ├── processed/    # Cleaned and transformed data
├── main.ipynb        # Main analysis notebook
├── pyproject.toml    # Project dependencies
└── README.md         # This file
\`\`\`

## Data Directory Usage

- **raw/**: Store original data files here
- **processed/**: Save cleaned and processed datasets

## Getting Started

1. Add your raw data to \`data/raw/\`
2. Open \`main.ipynb\`
3. Start analyzing!
EOF

echo "📖 Created README.md"

# Initial git commit
git add .
git commit -m "Initial commit: Setup Jupyter environment with uv"
echo "📝 Made initial git commit"

# Success message
echo ""
echo "🎉 SUCCESS! Jupyter environment '$PROJECT_NAME' is ready!"
echo ""
echo "🚀 Next steps:"
echo "   cd $PROJECT_NAME"
echo "   uv run jupyter lab"
echo ""
echo "📁 Project structure created:"
echo "   ├── main.ipynb (ready to use!)"
echo "   ├── data/ (with raw, processed, external subdirs)"
echo "   ├── README.md"
echo "   ├── .gitignore"
echo "   └── pyproject.toml (with data science packages)"
echo ""