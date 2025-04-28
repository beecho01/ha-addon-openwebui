<div id="top">

  <p align="center">
    <img src="https://raw.githubusercontent.com/beecho01/umbrel-web-app/refs/heads/main/docs/assets/svg/logo.svg" alt="Logo" width="15%">
  </p>

  <h1 align="center">Open WebUI Addon for Home Assistant</h1>

  <p align="center">
    <em>A Home Assistant add-on for [Open WebUI][Open WebUI] — a sleek, self-hosted AI interface designed to work with models like those served by Ollama.</em>
  </p>

  <p align="center">
    <img src="https://img.shields.io/github/languages/top/beecho01/ha-addon-openwebui?style=for-the-badge&color=18BCF2">
    <img src="https://img.shields.io/github/languages/code-size/beecho01/ha-addon-openwebui?style=for-the-badge&color=18BCF2">
    <a href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img src="https://img.shields.io/badge/license-CC--BY--NC--SA--4.0-8257e6?style=for-the-badge&logoColor=white&label=License&color=18BCF2""></a>
    <a href="https://buymeacoffee.com/beecho01"><img style="height: 28px;" src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji= &slug=beecho01&button_colour=18bcf2&font_colour=FFFFFF&font_family=Inter&outline_colour=FFFFFF&coffee_colour=FFDD00" /></a>
  </p>

</div>

<img src="https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/refs/heads/main/docs/assets/svg/line.svg" alt="line break" width="100%" height="3px">

## Quick Links

- [About](#about)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [License](#license)

<img src="https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/refs/heads/main/docs/assets/svg/line.svg" alt="line break" width="100%" height="3px">

## About

[Open WebUI][Open WebUI] is a privacy-first, open-source chat interface for local LLMs (Large Language Models). It provides a modern UI, user accounts, conversation history, and integrates with popular backend model runners like Ollama and OpenAI-compatible APIs.

This add-on lets you easily run [Open WebUI][Open WebUI] as part of your Home Assistant ecosystem using the official Open WebUI [docker image][docker].

![Open WebUI Version][openwebui-version]
![Ingress][ingres-badge]
![Supported Architectures][archs]

<img src="https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/refs/heads/main/docs/assets/svg/line.svg" alt="line break" width="100%" height="3px">

## Features

- Seamless integration into Home Assistant
- Web-based UI accessible via local network or Nabu Casa
- Persistent storage across updates
- Support for multiple CPU architectures (amd64, arm64)

<img src="https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/refs/heads/main/docs/assets/svg/line.svg" alt="line break" width="100%" height="3px">

## Requirements

- Home Assistant OS or Supervised installation
- Optionally, Ollama or another OpenAI-compatible backend running on your network

<img src="https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/refs/heads/main/docs/assets/svg/line.svg" alt="line break" width="100%" height="3px">

## Installation

The installation of this add-on is pretty straightforward and no different to installing any other Home Assistant add-on.

1. Add my [add-ons repository][addons-repo] to Home Assistant or click the button below to open my add-on repository on your Home Assistant instance.

   [![Open add-on repo on your Home Assistant instance][repo-btn]][addon]

1. Install this add-on.
1. Start the add-on.
1. Check the logs of the add-on to see if everything went well.
1. Click the `OPEN WEB UI` button to open Open WebUI.

<img src="https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/refs/heads/main/docs/assets/svg/line.svg" alt="line break" width="100%" height="3px">

## Configuration

No special configuration is needed out of the box. The add-on automatically persists data to `/data`, keeping your accounts and chat history intact between updates.

Optional environment settings can be customised by modifying `run.sh`, such as:

- `WEBUI_AUTH=false` to disable login (not recommended for shared access)
- `WEBUI_SECRET_KEY` to control session encryption (persisted automatically)

<img src="https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/refs/heads/main/docs/assets/svg/line.svg" alt="line break" width="100%" height="3px">

## License

This project is licensed under the MIT License.

Open WebUI © Open WebUI contributors. Home Assistant Add-on maintained by @beecho01.

[addon]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbeecho01%2Fha-addon-openwebui
[addons-repo]: https://github.com/beecho01/ha-addon-openwebui
[archs]: https://img.shields.io/badge/dynamic/json?color=green&style=for-the-badge&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fbeecho01%2Fha-addon-openwebui%2Fmain%2Fconfig.json
[dark]: https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/main/docs/images/screenshot-dark.png
[docker]: https://github.com/open-webui/open-webui/pkgs/container/open-webui
[openwebui-version]: https://img.shields.io/badge/dynamic/json?label=openwebui%20Version&style=for-the-badge&url=https%3A%2F%2Fraw.githubusercontent.com%2Fbeecho01%2Fha-addon-openwebui%2Fmain%2Fbuild.json&query=%24.args.openwebui_version
[Open WebUI]: https://openwebui.com
[ingres-badge]: https://img.shields.io/badge/dynamic/json?label=Ingress&query=$.ingress&style=for-the-badge&url=https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/main/config.json
[light]: https://raw.githubusercontent.com/beecho01/ha-addon-openwebui/main/docs/images/screenshot-light.png
[repo-btn]: https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg
