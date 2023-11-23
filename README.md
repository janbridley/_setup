# _setup
Setup scripts for HPC systems. `./setup.sh` will do the following:

1. Install micromamba and configure conda-forge as the default channel.
2. Create a mamba env and activate it
3. Installs pyutils (a self-written minimodule with utility functions).
4. (optional) - Change shell to zsh. This will not work on all systems, but is useful to try
5. Add `mm` micromamba alias function to `.bashrc` or `.zshrc`
6. (optional) - Install oh-my-zsh. Not always needed, but useful for systems where zsh is allowed by default.
