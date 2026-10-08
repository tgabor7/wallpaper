# WallpaperApp

SwiftUI iOS app you can build and run on an iPhone **without a Mac**. Code is
split in two parts:

- `Sources/WallpaperKit` — the app code, as a Swift Package (buildable/testable
  anywhere with a Swift toolchain)
- `App/` — the thin `@main` app target, wrapped by `project.yml` (XcodeGen)

`.github/workflows/build.yml` builds everything on a free macOS runner and
packs an unsigned `.ipa`, which [SideStore](https://sidestore.io) re-signs on
your iPhone with your own (free) Apple ID.

## Layout

```
Package.swift            Swift package: WallpaperKit library + tests
project.yml              XcodeGen manifest for the iOS app target
App/WallpaperAppMain.swift   @main entry point
Sources/WallpaperKit/    views + models
Tests/WallpaperKitTests/
.github/workflows/build.yml  CI: swift test + unsigned .ipa build
```

## One-time setup: SideStore on your iPhone

Requires an iPhone on iOS 17+, a free Apple ID, and this Linux machine.

1. Install the tooling (Arch):

   ```sh
   sudo pacman -S docker usbmuxd
   sudo systemctl enable --now docker
   ```

2. Plug in the iPhone, unlock it, tap **Trust**.

3. Run SideStore's installer (it prints the exact `./AltServer` command with
   your UDID already filled in):

   ```sh
   docker run --rm -it \
     -v "${PWD}":/mnt \
     -v /var/run/usbmuxd:/var/run/usbmuxd \
     -v /var/lib/lockdown:/tmp/lockdown \
     ghcr.io/sidestore/altcon
   ```

4. On the phone, open SideStore and sign in with your Apple ID (with 2FA you'll
   be asked for a code). Keep SideStore installed — it occupies one of your
   three free-app slots.

## Every build: push → .ipa → phone

1. Push to GitHub. The `build` workflow runs `swift test`, then builds an
   unsigned `WallpaperApp.ipa` (public repos get unlimited free macOS minutes;
   private repos get ~200 min/month).

   ```sh
   git add -A && git commit -m "update" && git push
   ```

2. Grab the `.ipa` from the workflow run's artifacts, **or** tag a release to
   get a permanent download link:

   ```sh
   git tag v0.1 && git push --tags
   ```

3. On the iPhone, download the `.ipa` (release link in Safari, or send the
   file to yourself), then in **Files** → long-press → **Share** → **SideStore**.

4. SideStore re-signs it with your Apple ID and installs it. First launch:
   **Settings → General → VPN & Device Management → trust** the developer cert.

SideStore refreshes apps in the background while charging on Wi-Fi, keeping the
7-day free-account expiry from ever hitting. If an app does expire, open
SideStore and tap refresh.

## Knobs

- **Bundle ID** — `PRODUCT_BUNDLE_IDENTIFIER` in `project.yml`. Change it if
  the install ever fails with a bundle ID conflict.
- **iOS version** — package targets iOS 17; lower `platforms` in `Package.swift`
  and `deploymentTarget` in `project.yml` together if you need older.

## Develop without pushing

No Swift toolchain is required locally — CI is the build machine. To iterate,
push a commit and read the workflow log; download the artifact to reinstall.
