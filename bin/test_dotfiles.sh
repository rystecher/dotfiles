#!/usr/bin/env bash

# Test script for dotfiles
# Run this in a clean environment to test your setup

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

test_pass() {
    echo -e "${GREEN}✓ $1${NC}"
}

test_fail() {
    echo -e "${RED}✗ $1${NC}"
    exit 1
}

test_warn() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

echo "Testing dotfiles setup..."

# Test 1: Check if dotfiles directory exists
if [ -d "$HOME/dotfiles" ]; then
    test_pass "Dotfiles directory exists"
else
    test_fail "Dotfiles directory not found"
fi

# Test 2: Check if rcup is installed
if command -v rcup >/dev/null 2>&1; then
    test_pass "rcup is installed"
else
    test_fail "rcup is not installed"
fi

# Test 3: Check if mise is installed
if command -v mise >/dev/null 2>&1; then
    test_pass "mise is installed"
else
    test_fail "mise is not installed"
fi

# Test 4: Check if mise.toml is symlinked
if [ -L "$HOME/.mise.toml" ]; then
    test_pass ".mise.toml is symlinked"
else
    test_warn ".mise.toml symlink not found"
fi

# Test 5: Check if programming languages are installed
echo "Checking installed tools..."
if mise list | grep -q ruby; then
    test_pass "Ruby is installed via mise"
else
    test_warn "Ruby not found in mise"
fi

if mise list | grep -q node; then
    test_pass "Node.js is installed via mise"
else
    test_warn "Node.js not found in mise"
fi

if mise list | grep -q python; then
    test_pass "Python is installed via mise"
else
    test_warn "Python not found in mise"
fi

# Test 6: Check if Neovim config is linked
if [ -L "$HOME/.config/nvim" ]; then
    test_pass "Neovim config is symlinked"
else
    test_warn "Neovim config symlink not found"
fi

# Test 7: Check if other dotfiles are symlinked
dotfiles_to_check=(".zshrc" ".gitconfig" ".tmux.conf")
for dotfile in "${dotfiles_to_check[@]}"; do
    if [ -L "$HOME/$dotfile" ]; then
        test_pass "$dotfile is symlinked"
    else
        test_warn "$dotfile symlink not found"
    fi
done

# Test 8: Test that tools actually work
echo "Testing tool functionality..."

if command -v ruby >/dev/null 2>&1; then
    ruby_version=$(ruby --version)
    test_pass "Ruby works: $ruby_version"
else
    test_warn "Ruby command not found"
fi

if command -v node >/dev/null 2>&1; then
    node_version=$(node --version)
    test_pass "Node.js works: $node_version"
else
    test_warn "Node.js command not found"
fi

if command -v python >/dev/null 2>&1; then
    python_version=$(python --version 2>&1)
    test_pass "Python works: $python_version"
else
    test_warn "Python command not found"
fi

if command -v nvim >/dev/null 2>&1; then
    nvim_version=$(nvim --version | head -n1)
    test_pass "Neovim works: $nvim_version"
else
    test_warn "Neovim command not found"
fi

# Test 9: Check Neovim plugins (if kickstart.nvim)
if [ -d "$HOME/.config/nvim" ]; then
    if nvim --headless -c "checkhealth" -c "qa" 2>/dev/null; then
        test_pass "Neovim health check passed"
    else
        test_warn "Neovim health check issues (run :checkhealth in nvim)"
    fi
fi

echo -e "\n${GREEN}Dotfiles testing complete!${NC}"
echo "Run this script after setting up dotfiles on a new machine to verify everything works."
