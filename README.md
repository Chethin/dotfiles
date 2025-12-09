# My Dotfiles

This repository contains my personal dotfiles, mainly including window management, status and editor configurations. The repository has two branches, `mac` and `arch` which house platform-specific configurations.

## Structure

- `mac/` — Dotfiles and configs tailored for macOS.
- `arch/` — Dotfiles and configs tailored for Arch Linux.

## Installation and Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Chethin/dotfiles.git
   cd dotfiles
   ```

2. **Checkout the appropriate branch:**

   ```bash
   # For macOS
   git checkout mac

   # For Arch Linux
   git checkout arch
   ```

3. **Use GNU Stow to create symlinks in your home directory:**

   ```bash
   stow -t ~ .
   ```

   This will symlink all configuration directories into your home directory.

   Make sure you have [GNU Stow](https://www.gnu.org/software/stow/) installed:

   ```bash
   sudo pacman -S stow   # Arch Linux
   brew install stow     # macOS
   ```

> **Note:**  
> If you have existing configuration files in your home directory (e.g., `.zshrc`, `.config/nvim`), GNU Stow may fail to create symlinks due to conflicts.  
> Before running `stow`, back up or remove any conflicting files:
>
> ```bash
> mv ~/.zshrc ~/.zshrc.backup
> mv ~/.config/nvim ~/.config/nvim.backup
> ```
>
> Then rerun the `stow -t ~ .` command.

4. **Final steps and notices:**

   Everything should be set up now!
   - Make sure all required system packages and dependencies for your configurations are installed (e.g., Hyprland, Waybar, Ghostty, Zsh, etc.).
   - For Neovim, you may need to run `:checkhealth` to ensure all plugins and dependencies are correctly installed.
   - Some configurations may require further customization or manual steps depending on your environment.

   Refer to the documentation or comments within each config file for more details.

## Configurations

- **Window manager configuration:**
  - Arch: `~/.config/hypr` (Hyprland)
  - Mac: `~/.config/yabai`
- **Status bar configuration:**
  - Arch: `~/.config/waybar`
  - Mac: `~/.config/sketchybar`
- **Editor configuration:**
  - Neovim: `~/.config/nvim`
- **Terminal configuration (Ghostty):**
  - Ghostty: `~/.config/ghostty`
    - Contains custom keybindings, color schemes, and font settings.
    - Refer to the Ghostty documentation for usage and customization: [Ghostty documentation](https://github.com/ghostty-org/ghostty).
- **Shell configuration:**
  - Zsh: `.zshrc` in the root of the repository
    - Includes aliases, environment variables, and prompt customizations.

## Contributing

These dotfiles are personal, but suggestions or improvements are welcome via pull requests or issues.

## License

MIT License
