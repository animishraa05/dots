#!/bin/bash

# Exit on error
set -e

# Function to check if a package is installed
pkg_installed() {
    pacman -Q "$1" &> /dev/null
}

# Install yay if not installed
if ! pkg_installed yay; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Packages from official repositories
OFFICIAL_PKGS=(
    alacarte
    alacritty
    apparmor
    base
    base-devel
    blueman
    bluez-utils
    brightnessctl
    cava
    dunst
    efibootmgr
    fastfetch
    fd
    firefox
    flameshot
    fzf
    gamemode
    git
    grub
    gst-libav
    gst-plugins-bad
    gst-plugins-good
    gst-plugins-ugly
    i3-wm
    i3blocks
    i3status
    intel-media-driver
    intel-ucode
    intellij-idea-community-edition
    iwd
    jq
    julia
    kiwix-desktop
    lazygit
    libreoffice-fresh
    libretro-mgba
    libva-intel-driver
    linux
    linux-firmware
    luarocks
    lutris
    man-db
    man-pages
    mangohud
    manuals
    markdown-oxide
    maven
    mpd
    mpv
    nano
    nautilus
    ncspot
    neovide
    neovim
    networkmanager
    npm
    ntp
    obsidian
    openssh
    otf-aurulent-nerd
    otf-codenewroman-nerd
    otf-comicshanns-nerd
    otf-commit-mono-nerd
    otf-droid-nerd
    otf-firamono-nerd
    otf-geist-mono-nerd
    otf-hasklig-nerd
    otf-hermit-nerd
    otf-monaspace-nerd
    otf-opendyslexic-nerd
    otf-overpass-nerd
    pacman-contrib
    picom
    pipewire
    pipewire-alsa
    pipewire-jack
    pipewire-pulse
    playerctl
    pnpm
    polybar
    prismlauncher
    pulseaudio-qt
    python-adblock
    python-pip
    python-pipx
    qbittorrent
    qt6-multimedia-ffmpeg
    qt6-virtualkeyboard
    qutebrowser
    reflector
    retroarch
    rofi
    rtkit
    ruby
    samba
    sddm
    sof-firmware
    speedtest-cli
    spring
    steam
    tectonic
    telegram-desktop
    thunar
    tldr
    tmux
    ttf-0xproto-nerd
    ttf-3270-nerd
    ttf-agave-nerd
    ttf-anonymouspro-nerd
    ttf-arimo-nerd
    ttf-bigblueterminal-nerd
    ttf-bitstream-vera-mono-nerd
    ttf-cascadia-code-nerd
    ttf-cascadia-mono-nerd
    ttf-cousine-nerd
    ttf-d2coding-nerd
    ttf-daddytime-mono-nerd
    ttf-dejavu-nerd
    ttf-envycoder-nerd
    ttf-fantasque-nerd
    ttf-firacode-nerd
    ttf-go-nerd
    ttf-gohu-nerd
    ttf-hack-nerd
    ttf-heavydata-nerd
    ttf-iawriter-nerd
    ttf-ibmplex-mono-nerd
    ttf-inconsolata-go-nerd
    ttf-inconsolata-lgc-nerd
    ttf-inconsolata-nerd
    ttf-intone-nerd
    ttf-iosevka-nerd
    ttf-iosevkaterm-nerd
    ttf-iosevkatermslab-nerd
    ttf-jetbrains-mono-nerd
    ttf-lekton-nerd
    ttf-liberation-mono-nerd
    ttf-lilex-nerd
    ttf-martian-mono-nerd
    ttf-meslo-nerd
    ttf-monofur-nerd
    ttf-monoid-nerd
    ttf-mononoki-nerd
    ttf-mplus-nerd
    ttf-nerd-fonts-symbols-mono
    ttf-noto-nerd
    ttf-profont-nerd
    ttf-proggyclean-nerd
    ttf-recursive-nerd
    ttf-roboto-mono-nerd
    ttf-sharetech-mono-nerd
    ttf-sourcecodepro-nerd
    ttf-space-mono-nerd
    ttf-terminus-nerd
    ttf-tinos-nerd
    ttf-ubuntu-mono-nerd
    ttf-ubuntu-nerd
    ttf-victor-mono-nerd
    ttf-zed-mono-nerd
    ueberzugpp
    unrar
    unzip
    variety
    vi
    vim
    vlc
    vlc-plugin-ffmpeg
    vulkan-intel
    vulkan-nouveau
    vulkan-radeon
    wget
    wine
    wine-gecko
    wine-mono
    winetricks
    wireplumber
    xclip
    xf86-video-amdgpu
    xf86-video-ati
    xf86-video-nouveau
    xorg-xinit
    xorg-xinput
    xterm
    yazi
    yt-dlp
    zathura
    zathura-pdf-poppler
    zoxide
    zram-generator
    zsh
)

# Packages from AUR
AUR_PKGS=(
    ani-cli
    betterlockscreen
    bluetuith
    emojify
    gtk2
    gtkmm
    i3lock-color
    nitrogen
    protontricks
    python-vdf
    ryujinx
    vesktop
    zsh-theme-powerlevel10k-git
)

# Install official packages
for pkg in "${OFFICIAL_PKGS[@]}"; do
    if ! pkg_installed "$pkg"; then
        sudo pacman -S --noconfirm "$pkg"
    else
        echo "$pkg is already installed."
    fi
done

# Install AUR packages
for pkg in "${AUR_PKGS[@]}"; do
    if ! pkg_installed "$pkg"; then
        yay -S --noconfirm "$pkg"
    else
        echo "$pkg is already installed."
    fi
done

# Directories to copy
CONFIG_DIRS=(
    alacritty
    autostart
    cava
    chromium
    configstore
    dconf
    dunst
    fastfetch
    fontconfig
    go
    google-chrome
    gtk-2.0
    gtk-3.0
    i3
    JetBrains
    lazygit
    libreoffice
    mpv
    nautilus
    ncspot
    nextjs-nodejs
    nitrogen
    nvim
    obsidian
    picom
    polybar
    pulse
    qBittorrent
    qutebrowser
    rofi
    Ryujinx
    simple-update-notifier
    systemd
    themes
    Thunar
    variety
    vesktop
    vlc
    xfce4
    yay
    yazi
    zathura
)

# Copy configuration files
for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        cp -r "$dir" ~/.config/
    else
        echo "Directory $dir does not exist, skipping."
    fi
done

echo "Installation complete!"