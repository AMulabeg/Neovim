# Neovim Configuration

Welcome to my Neovim configuration repository! This repository houses my personalized setup for Neovim, tailored to enhance my productivity and streamline my workflow. Whether you're a seasoned Neovim user or just getting started, feel free to explore and adapt elements of this configuration to suit your own needs.

## Table of Contents

- [About Neovim](#about-neovim)
- [Installation](#installation)
- [Plugins](#plugins)
- [Languages](#languages)
- [Customization](#customization)
- [Feedback and Contributions](#feedback-and-contributions)
- [License](#license)
## Appearance
<img width="1920" alt="image" src="https://github.com/AMulabeg/Neovim/assets/114394694/22d043c8-b005-4cde-a726-65cfc59aa42b">

## About Neovim

[Neovim](https://neovim.io/) is a highly configurable, extensible text editor that is based on Vim. It seeks to aggressively refactor Vim in order to simplify maintenance and encourage contributions.

## Installation

To use this configuration, follow these steps:

1. Ensure you have Neovim installed on your system.
2. Clone this repository to your local machine:

```bash
git clone https://github.com/AMulabeg/Neovim.git ~/.config/nvim
```
3. Install the folowing tools:
  - [Rip Grep](https://github.com/BurntSushi/ripgrep) :
    - With macOS:
     ```bash
     brew install ripgrep
     ```
    - With Arch-based Distros:
     ```
     yay -S ripgrep
     ```
    - With Debian-based Distros:
     ```
     sudo apt-get install ripgrep
     ```
    - With RedHad-based Distros:
     ```
     sudo dnf install ripgrep
     ```
  - [A NerdFont](https://www.nerdfonts.com/)
  - [Clang (If you wish to use C/C++)](https://clang.llvm.org/)
  - [Anaconda (If you wish to use Python)](https://www.anaconda.com/)
  - [GHC (If you wish to use Haskell)](https://www.haskell.org/ghc/)
     
3. Launch Neovim.
4. Enjoy using Neovim with this personalized configuration!


## Plugins

This configuration utilizes various plugins to enhance Neovim's functionality. Some notable plugins include:

- [Lualine](https://github.com/nvim-lualine/lualine.nvim): A lean and mean status/tabline for Neovim.
- [LSPConfig](https://github.com/neovim/nvim-lspconfig): Intellisense engine for Neovim.
- [NvimTree](https://github.com/nvim-tree/nvim-tree.lua): A tree explorer plugin for Neovim.
- [Telescope](https://github.com/nvim-telescope/telescope.nvim): Fuzzy file finder for Neovim.

## Languages

This configuration supports: C/C++, Python and Haskell

## Customization

Feel free to customize this configuration to better suit your needs. You can tweak key mappings, adjust plugin settings, or even add/remove plugins according to your preferences. The configuration files are thoroughly commented to guide you through the customization process.

## Feedback and Contributions

Feedback and contributions are always welcome! If you have any suggestions for improvement or encounter any issues with this configuration, please don't hesitate to open an issue or submit a pull request. Your input is greatly appreciated. And of cource if you enjoy the config, give it a Star, it means a lot to me

## License

This Neovim configuration is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute it as you see fit.
