{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "than";
  home.homeDirectory = "/Users/than";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neofetch    
    btop
    glow
    eza
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/than/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Programs supported as `programs` options.
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      "ll" = "eza -l";
      "la" = "eza -la";
    };
  };
  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  programs.git = {
    enable = true;
    userName = "ThanHenderson";
    userEmail = "nathan.t.henderson@outlook.com";
    extraConfig = { safe.directory = "/workspace"; };
  };
  programs.gh.enable = true;
  programs.mercurial = {
    enable = true;
    userName = "ThanHenderson";
    userEmail = "nathan.t.henderson@outlook.com";
  };
  programs.alacritty.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = ''
# Remap prefix from 'C-b' to 'C-a'
      unbind C-b
      set -g prefix C-a
      bind-key C-a send-prefix

# Enable colours
      set -g default-terminal "alacritty"
      set -ag terminal-overrides ",alacritty:RGB"

# Increase scroll back buffer size
      set -g history-limit 100000

# Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

# Switch panes Vim-like
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

# Start at index 1
      set -g base-index 1

# Automatically re-number windows after one of them is closed
      set -g renumber-windows on

# Split and Creating keeping the current directory
      bind '|' split-window -h -c '#{pane_current_path}'
      bind '-' split-window -v -c '#{pane_current_path}'
      bind c new-window -c '#{pane_current_path}'

# Prefix + r -> Reload config file
      unbind r
      bind r source-file ~/.tmux.conf

# Mouse mode (tmux 2.1 and above)
      set -g mouse on

# Default shell to be zsh
# set -g default-command /bin/zsh

# Scipt bindings
      bind-key -r i run-shell "tmux neww ~/.dotfiles/ch.sh"

# Time for escape listening, for hx this is needed.
      set -sg escape-time 0

      set -g @plugin 'catppuccin/tmux'
      set -g @plugin 'tmux-plugins/tpm'
      set -g @catppuccin_flavour 'doomonedark'
# # show user and host
      set -g @catppuccin_user "on"
      set -g @catppuccin_host "on"
      set -g @catppuccin_date_time "%Y-%m-%d %H:%M"
#
# # List of plugins
      set -g @plugin 'tmux-plugins/tmux-sensible'

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  }; 
  programs.emacs.enable = true;
  programs.bat.enable = true;
  programs.gpg.enable = true;
  programs.htop.enable = true;
  programs.ripgrep.enable = true;
  programs.thefuck.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  # Languages
  programs.opam.enable = true;
  programs.go.enable = true;
}
