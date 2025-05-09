# Changelog

---

## [0.6.7] - 2025-05-07
### Added
- 🌐 **Custom Azure TTS API URL Support Added**: You can now define a custom Azure Text-to-Speech endpoint—enabling flexibility for enterprise deployments and regional compliance.
- ⚙️ **TOOL_SERVER_CONNECTIONS**: Environment Variable Suppor: Easily configure and deploy tool servers via environment variables, streamlining setup and enabling faster enterprise provisioning.
- 👥 **Enhanced OAuth Group Handling as String or List**: OAuth group data can now be passed as either a list or a comma-separated string, improving compatibility with varied identity provider formats and reducing onboarding friction.

### Fixed
- 🧠 **Embedding with Ollama Proxy Endpoints Restored**: Fixed an issue where missing API config broke embedding for proxied Ollama models—ensuring consistent performance and compatibility.
- 🔐 **OIDC OAuth Login Issue Resolved**: Users can once again sign in seamlessly using OpenID Connect-based OAuth, eliminating login interruptions and improving reliability.
- 📝 **Notes Feature Access Fixed for Non-Admins**: Fixed an issue preventing non-admin users from accessing the Notes feature, restoring full cross-role collaboration capabilities.
- 🖼️ **Tika Loader Image Extraction Problem Resolved**: Ensured TikaLoader now processes 'extract_images' parameter correctly, restoring complete file extraction functionality in document workflows.
- 🎨 **Automatic1111 Image Model Setting Applied Properly**: Fixed an issue where switching to a specific image model via the UI wasn’t reflected in generation, re-enabling full visual creativity control.
- 🏷️ **Multiple XML Tags in Messages Now Parsed Correctly**: Fixed parsing issues when messages included multiple XML-style tags, ensuring clean and unbroken rendering of rich content in chats.
- 🖌️ **OpenAI Image Generation Issues Resolved**: Resolved broken image output when using OpenAI’s image generation, ensuring fully functional visual creation workflows.
- 🔎 **Tool Server Settings UI Privacy Restored**: Prevented restricted users from accessing tool server settings via search—restoring tight permissions control and safeguarding sensitive configurations.
- 🎧 **WebM Audio Transcription Now Supported**: Fixed an issue where WebM files failed during audio transcription—these formats are now fully supported, ensuring smoother voice note workflows and broader file compatibility.

### Packaging (Home‑Assistant‑specific)
- Set `environment.PORT = 3000` and `ingress_port = 3000` for a cleaner Ingress URL.
- Host‑side port mapping disabled (`"3000/tcp": null`)—UI is reachable only through Supervisor’s Ingress proxy.