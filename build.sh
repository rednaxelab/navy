#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# 1. Ghostty (replaces Konsole)
# ============================================================
dnf install -y 'dnf-command(copr)'
dnf copr enable -y pgdev/ghostty
dnf install -y ghostty
dnf remove -y konsole konsole-part || true

# ============================================================
# 2. Google Chrome (replaces Firefox)
# ============================================================
# /opt needs to be a real directory for Chrome, not a symlink to /var/opt
rm -f /opt 2>/dev/null || true
mkdir -p /opt

cat > /etc/yum.repos.d/google-chrome.repo <<'EOF'
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

dnf install -y google-chrome-stable

# Remove Firefox if present
dnf remove -y firefox || true

# ============================================================
# 3. OnlyOffice Desktop Editors
# ============================================================
cat > /etc/yum.repos.d/onlyoffice.repo <<'EOF'
[onlyoffice]
name=onlyoffice
baseurl=https://download.onlyoffice.com/repo/centos/main/noarch/
gpgcheck=1
gpgkey=https://download.onlyoffice.com/GPG-KEY-ONLYOFFICE
enabled=1
EOF

dnf install -y onlyoffice-desktopeditors

# ============================================================
# 4. Bazaar (Flatpak app store from Flathub)
# ============================================================
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub io.github.kolunmi.Bazaar

# ============================================================
# Cleanup
# ============================================================
dnf clean all
