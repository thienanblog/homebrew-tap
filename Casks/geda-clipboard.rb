cask "geda-clipboard" do
  version "0.6.1"
  sha256 "c00d9e38e93b7ddd211fcbc946a792831c4a1739f717c846859c08979bbb8b7c"

  url "https://github.com/thienanblog/geda-clipboard/releases/download/v#{version}/geda-clipboard-#{version}-macos-universal.zip"
  name "Geda Clipboard"
  desc "Menu bar clipboard manager with copy and paste notifications"
  homepage "https://github.com/thienanblog/geda-clipboard"

  # The Sparkle feed the app itself polls, so Homebrew learns about a release
  # from the same place, at the same moment, as an already-installed copy.
  livecheck do
    url "https://thienanblog.github.io/geda-clipboard/appcast.xml"
    strategy :sparkle
  end

  # Sparkle updates the app in place. Without this, Homebrew would consider a
  # self-updated copy to be a broken install and reinstall the pinned version
  # over the top of it, quietly walking users backwards.
  auto_updates true
  # Ventura is macOS 13, the LSMinimumSystemVersion in the bundle. The bare
  # symbol is the minimum; Homebrew 6 deprecated the ">= :ventura" string form
  # that used to be needed to say so.
  depends_on macos: :ventura

  app "Geda Clipboard.app"

  # It has no window and no Dock tile, so a running copy would otherwise sit
  # there holding the old bundle open while the new one is written underneath.
  uninstall quit: "com.geda.clipboard"

  # The app is sandboxed, so its real data lives under Containers. The
  # Application Support path is what an unsandboxed build writes, and copies
  # built from source before the sandbox landed left one behind.
  zap trash: [
    "~/Library/Application Support/geda-clipboard",
    "~/Library/Caches/com.geda.clipboard",
    "~/Library/Containers/com.geda.clipboard",
    "~/Library/HTTPStorages/com.geda.clipboard",
    "~/Library/Preferences/com.geda.clipboard.plist",
    "~/Library/Saved Application State/com.geda.clipboard.savedState",
  ]
end
