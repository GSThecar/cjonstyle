# cjonstyle

🚀 A Tuist-based iOS project for collaborative and reproducible development.

## Requirements

- macOS Ventura (13.7.6 or higher)
- Xcode 15.1 or higher
- Swift 5.9.2
- Tuist 4.42.0 (installed via [mise](https://mise.jdx.dev/))

## Getting Started

```bash
# Install tuist (if not yet installed)
mise install tuist@4.43.0
mise use -g tuist@4.43.0

# Generate Xcode project
tuist generate

# Set Path (if not found tuist)
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc

# Open the project
open cjonstyle.xcodeproj
```

```
# Swift Package Manager
"https://github.com/onevcat/Kingfisher.git"
"https://github.com/devxoul/Then.git",
"https://github.com/ReactiveX/RxSwift.git"
"https://github.com/RxSwiftCommunity/RxDataSources.git"
"https://github.com/SnapKit/SnapKit.git"
```


## Structure

- `App/` - Main application code
- `Tuist/` - Tuist configuration
- `Project.swift` - Defines targets and dependencies

## License

MIT
