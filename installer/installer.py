#!/usr/bin/env python3
"""Workspace installer for VS Code agents, prompts, and skills."""

from __future__ import annotations

import argparse
import json
import shutil
from pathlib import Path

DEFAULT_MANIFEST = "install.json"
DEFAULT_TARGET = "vscode"
DEFAULT_SCOPE = "project"


def _load_manifest(path: Path) -> dict:
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def _ensure_dir(path: Path, dry_run: bool) -> None:
    if dry_run:
        return
    path.mkdir(parents=True, exist_ok=True)


def _copy_file(src: Path, dest: Path, dry_run: bool) -> None:
    _ensure_dir(dest.parent, dry_run)
    if dry_run:
        return
    shutil.copy2(src, dest)


def _remove_file(path: Path, dry_run: bool) -> None:
    if not path.exists():
        return
    if dry_run:
        return
    path.unlink()


def _collect_agents(src_root: Path) -> list[Path]:
    return list(src_root.rglob("*.agent.md"))


def _collect_prompts(src_root: Path) -> list[Path]:
    return list(src_root.rglob("*.prompt.md"))


def _collect_skills(src_root: Path) -> list[Path]:
    return list(src_root.rglob("SKILL.md"))


def _targets_for_type(target: str, scope: str) -> dict[str, str]:
    if target != DEFAULT_TARGET:
        raise ValueError(f"Unsupported target: {target}")
    if scope == "project":
        return {
            "agents": ".github/agents",
            "prompts": ".github/prompts",
            "skills": ".github/skills",
        }
    if scope == "global":
        return {
            "agents": "agents",
            "prompts": "prompts",
            "skills": "skills",
        }
    raise ValueError(f"Unsupported scope: {scope}")


def _install_agents(src_root: Path, dest_root: Path, dry_run: bool) -> int:
    count = 0
    for src in _collect_agents(src_root):
        dest = dest_root / src.name
        _copy_file(src, dest, dry_run)
        print(f"INSTALL agent: {src} -> {dest}")
        count += 1
    return count


def _install_prompts(src_root: Path, dest_root: Path, dry_run: bool) -> int:
    count = 0
    for src in _collect_prompts(src_root):
        dest = dest_root / src.name
        _copy_file(src, dest, dry_run)
        print(f"INSTALL prompt: {src} -> {dest}")
        count += 1
    return count


def _install_skills(src_root: Path, dest_root: Path, dry_run: bool) -> int:
    count = 0
    for src in _collect_skills(src_root):
        rel = src.relative_to(src_root)
        dest = dest_root / rel
        _copy_file(src, dest, dry_run)
        print(f"INSTALL skill: {src} -> {dest}")
        count += 1
    return count


def _uninstall_agents(src_root: Path, dest_root: Path, dry_run: bool) -> int:
    count = 0
    for src in _collect_agents(src_root):
        dest = dest_root / src.name
        _remove_file(dest, dry_run)
        print(f"REMOVE agent: {dest}")
        count += 1
    return count


def _uninstall_prompts(src_root: Path, dest_root: Path, dry_run: bool) -> int:
    count = 0
    for src in _collect_prompts(src_root):
        dest = dest_root / src.name
        _remove_file(dest, dry_run)
        print(f"REMOVE prompt: {dest}")
        count += 1
    return count


def _uninstall_skills(src_root: Path, dest_root: Path, dry_run: bool) -> int:
    count = 0
    for src in _collect_skills(src_root):
        rel = src.relative_to(src_root)
        dest = dest_root / rel
        _remove_file(dest, dry_run)
        print(f"REMOVE skill: {dest}")
        count += 1
    return count


def _run(
    action: str,
    manifest_path: Path,
    root: Path,
    target: str,
    scope: str,
    global_root: Path | None,
    dry_run: bool,
) -> None:
    manifest = _load_manifest(manifest_path)
    items = manifest.get("items", [])
    target_map = _targets_for_type(target, scope)
    install_root = root
    if scope == "global":
        if global_root is None:
            raise ValueError("--global-root is required when scope is global")
        install_root = global_root

    total = 0
    for item in items:
        item_type = item.get("type")
        src = root / item.get("source", "")
        if item_type not in target_map:
            raise ValueError(f"Unsupported item type: {item_type}")
        if not src.exists():
            raise FileNotFoundError(f"Source not found: {src}")
        dest = install_root / target_map[item_type]

        if action == "install":
            if item_type == "agents":
                total += _install_agents(src, dest, dry_run)
            elif item_type == "prompts":
                total += _install_prompts(src, dest, dry_run)
            elif item_type == "skills":
                total += _install_skills(src, dest, dry_run)
        elif action == "uninstall":
            if item_type == "agents":
                total += _uninstall_agents(src, dest, dry_run)
            elif item_type == "prompts":
                total += _uninstall_prompts(src, dest, dry_run)
            elif item_type == "skills":
                total += _uninstall_skills(src, dest, dry_run)
        else:
            raise ValueError(f"Unsupported action: {action}")

    verb = "Would process" if dry_run else "Processed"
    print(f"{verb} {total} files.")


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Install agents, prompts, and skills for VS Code.")
    parser.add_argument("action", choices=["install", "uninstall"])
    parser.add_argument("--manifest", default=DEFAULT_MANIFEST)
    parser.add_argument("--target", default=DEFAULT_TARGET)
    parser.add_argument("--scope", default=DEFAULT_SCOPE, choices=["project", "global"])
    parser.add_argument("--global-root", default=None)
    parser.add_argument("--root", default=".")
    parser.add_argument("--dry-run", action="store_true")
    return parser.parse_args()


def main() -> None:
    args = _parse_args()
    manifest_path = Path(args.manifest).resolve()
    root = Path(args.root).resolve()
    global_root = Path(args.global_root).expanduser().resolve() if args.global_root else None
    _run(args.action, manifest_path, root, args.target, args.scope, global_root, args.dry_run)


if __name__ == "__main__":
    main()
