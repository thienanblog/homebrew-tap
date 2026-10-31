# Homebrew cask for ScreenTale.
#
# This file is the source of truth; the release workflow copies it into the tap repository
# (thienanblog/homebrew-tap) with `version` and `sha256` filled in from release.json. Keeping
# it here means a change to how the app is installed lands in the same review as the change
# that caused it.
#
#     brew tap thienanblog/tap
#     brew install --cask screentale
cask "screentale" do
  version "1.18.5"
  sha256 "f286dff9b021cb2af04faf945d3ea4d20fb1f673650c4ba7705944beb1d6b2b9"

  url "https://github.com/thienanblog/screentale-releases/releases/download/v#{version}/ScreenTale-#{version}.dmg"
  name "ScreenTale"
  desc "Screen recorder with cursor-following zoom"
  homepage "https://github.com/thienanblog/screentale-releases"

  # Retained compatibility feed for Swift migration clients and Homebrew release discovery.
  # The primary Rust app uses the signed Tauri feed for its own update checks.
  livecheck do
    url "https://thienanblog.github.io/screentale-releases/appcast.xml"
    strategy :sparkle
  end

  # The app updates itself, so Homebrew must not treat a self-updated copy
  # as a corrupted install and must not try to "downgrade" it back to the pinned version.
  auto_updates true

  # Sequoia is macOS 15, the LSMinimumSystemVersion in the bundle. The bare symbol already
  # means "this or newer"; Homebrew 6 deprecated the ">= :sequoia" string form.
  depends_on macos: :sequoia
  # The app is built arm64-only, so an Intel Mac would install it and then fail to launch.
  depends_on arch: :arm64

  app "ScreenTale.app"

  uninstall quit: "com.screentale.app"

  # Recordings are deliberately **not** in this list. `brew uninstall --zap` is meant to
  # remove what the app left behind, not the user's own footage — and ~/Movies/ScreenTale
  # holds work that can be hours long and exists nowhere else.
  zap trash: [
    "~/Library/Application Support/ScreenTale",
    "~/Library/Caches/com.screentale.app",
    "~/Library/HTTPStorages/com.screentale.app",
    "~/Library/Logs/ScreenTale",
    "~/Library/Preferences/com.screentale.app.plist",
    "~/Library/Saved Application State/com.screentale.app.savedState",
  ]

  caveats <<~EOS
    Homebrew installs the same Production build as the direct download. An active trial or
    lifetime license is required for clean exports and automatic updates; without one,
    ScreenTale remains available in Free mode with watermarked visual exports.

    ScreenTale needs Screen Recording and Accessibility permission before it can record.
    macOS cannot grant either from a dialog — open the app and follow the prompts, which
    lead to the right pane of System Settings.
  EOS
end
