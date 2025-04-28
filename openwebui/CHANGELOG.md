# Changelog
All notable changes to this project will be documented in this file.  
The format is based on [Keep a Changelog] and this project adheres to [Semantic Versioning].

---

## [0.6.5] ‑ 2025‑04‑14
### Added
- 🛂 **Granular Voice Feature Permissions Per User Group**: Admins can now separately manage access to Speech-to-Text (record voice), Text-to-Speech (read aloud), and Tool Calls for each user group—giving teams tighter control over voice features and enhanced governance across roles.
- 🗣️ **Toggle Voice Activity Detection (VAD) for Whisper STT**: New environment variable lets you enable/disable VAD filtering with built-in Whisper speech-to-text, giving you flexibility to optimize for different audio quality and response accuracy levels.
- 📋 **Copy Formatted Response Mode**: You can now enable “Copy Formatted” in Settings > Interface to copy AI responses exactly as styled (with rich formatting, links, and structure preserved), making it faster and cleaner to paste into documents, emails, or reports.
- ⚙️ **Backend Stability and Performance Enhancements**: General backend refactoring improves system resilience, consistency, and overall reliability—offering smoother performance across workflows whether chatting, generating media, or using external tools.
- 🌎 **Translation Refinements Across Multiple Languages**: Updated translations deliver smoother language localization, clearer labels, and improved international usability throughout the UI—ensuring a better experience for non-English speakers.

### Changed
- ⚙️ **Backend performance & stability** improvements from upstream refactors.

### Fixed
- **LDAP log‑in reliability** issues caused by attribute parsing errors.
- **Image generation now works in temporary chats**.

### Packaging (Home‑Assistant‑specific)
- Switched add‑on to pull the official multi‑arch image **`ghcr.io/open-webui/open-webui:v0.6.5@sha256:fe7a6870…`**; local build removed.
- Set `environment.PORT = 3000` and `ingress_port = 3000` for a cleaner Ingress URL.
- Host‑side port mapping disabled (`"3000/tcp": null`)—UI is reachable only through Supervisor’s Ingress proxy.
