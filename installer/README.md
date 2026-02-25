# Installer

Minimal installer for VS Code agents, prompts, and skills based on `install.json`.

## Usage

Dry run:

```bash
python3 installer/installer.py install --target vscode --dry-run
```

Install:

```bash
python3 installer/installer.py install --target vscode
```

Uninstall:

```bash
python3 installer/installer.py uninstall --target vscode
```

## Global install

Use a user profile folder as the global root. Example:

```bash
python3 installer/installer.py install --target vscode --scope global --global-root "<VS_CODE_PROFILE_DIR>"
python3 installer/installer.py uninstall --target vscode --scope global --global-root "<VS_CODE_PROFILE_DIR>"
```

## Manifest

`install.json` defines which sources to install for a target.
