# Custom KDE Fedora Bootc Image

Custom bootc image based on `ghcr.io/ublue-os/kinoite-main:latest` (Universal Blue KDE) with:

- **KDE Plasma** desktop (via kinoite-main, includes SDDM)
- **Hardware acceleration**, multimedia codecs, and RPM Fusion (from Universal Blue base)
- **Ghostty** terminal (replaces Konsole)
- **Google Chrome** (replaces Firefox)
- **OnlyOffice** Desktop Editors
- **Bazaar** app store (Flatpak from Flathub)
- **Homebrew** baked in (same method as Bazzite/Aurora/Bluefin)

## Build locally

```
just build
```

## Generate an install ISO

```
just build-iso
```

The ISO will be in `./output/`.

## Deploy to GitHub (recommended)

1. Fork or use `ublue-os/image-template` as a template on GitHub
2. Replace the `Containerfile` and `build_files/` with these files
3. Generate a cosign keypair: `COSIGN_PASSWORD="" cosign generate-key-pair`
4. Add `cosign.key` contents as a GitHub secret named `SIGNING_SECRET`
5. Commit `cosign.pub` to the repo root
6. Push — GitHub Actions will build and publish to GHCR

## Switch a running system to this image

```
sudo bootc switch ghcr.io/<your-username>/<your-image-name>
```
