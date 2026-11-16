#!/usr/bin/env python3
"""Validate native application identity against AFK's Dart AppIdentity."""

from __future__ import annotations

import plistlib
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DART_CONFIG = ROOT / "lib/app/afk_example_configuration.dart"
ANDROID_MANIFEST = ROOT / "android/app/src/main/AndroidManifest.xml"
IOS_PROJECT = ROOT / "ios/Runner.xcodeproj/project.pbxproj"
IOS_INFO = ROOT / "ios/Runner/Info.plist"
ANDROID_LABEL = "{http://schemas.android.com/apk/res/android}label"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(f"Native identity validation failed: {message}")


def dart_identity() -> tuple[str, str, str]:
    source = DART_CONFIG.read_text(encoding="utf-8")
    match = re.search(r"identity:\s*const AppIdentity\((.*?)\)", source, re.S)
    require(match is not None, f"Could not find AppIdentity in {DART_CONFIG}")
    block = match.group(1)
    values: list[str] = []
    for field in ("displayName", "androidApplicationId", "iosBundleIdentifier"):
        value = re.search(rf"{field}:\s*'([^']+)'", block)
        require(value is not None, f"Could not read {field} from AppIdentity")
        values.append(value.group(1))
    return values[0], values[1], values[2]


def validate_android(display_name: str, application_id: str) -> None:
    candidates = [
        ROOT / "android/app/build.gradle.kts",
        ROOT / "android/app/build.gradle",
    ]
    gradle_files = [path for path in candidates if path.is_file()]
    require(len(gradle_files) == 1, "Expected exactly one Android app Gradle file (.gradle or .gradle.kts)")
    gradle = gradle_files[0].read_text(encoding="utf-8")
    namespace_values = re.findall(
        r"(?m)^\s*namespace\s*(?:=\s*)?['\"]([^'\"]+)['\"]", gradle
    )
    app_id_values = re.findall(
        r"(?m)^\s*applicationId\s*(?:=\s*)?['\"]([^'\"]+)['\"]", gradle
    )
    suffix_values = re.findall(
        r"(?m)^\s*applicationIdSuffix\s*(?:=\s*)?['\"]([^'\"]*)['\"]", gradle
    )
    require(namespace_values == [application_id], f"Android namespace values are {namespace_values!r}")
    require(app_id_values == [application_id], f"Android applicationId values are {app_id_values!r}")
    require(not suffix_values, f"Unexpected Android applicationIdSuffix values: {suffix_values!r}")

    manifest = ET.parse(ANDROID_MANIFEST).getroot()
    application = manifest.find("application")
    require(application is not None, "Android main manifest has no application element")
    label = application.get(ANDROID_LABEL)
    require(label == display_name, f"Android app label is {label!r}, expected {display_name!r}")


def validate_ios(display_name: str, bundle_id: str) -> None:
    project = IOS_PROJECT.read_text(encoding="utf-8")
    config_list = re.search(
        r'(?m)^\s*([A-F0-9]{24}) /\* Build configuration list for PBXNativeTarget "Runner" \*/ = \{\s*'
        r'isa = XCConfigurationList;\s*buildConfigurations = \((.*?)\);',
        project,
        re.S,
    )
    require(config_list is not None, "Could not locate Runner target build configuration list")
    configuration_refs = re.findall(
        r"([A-F0-9]{24}) /\* (Debug|Release|Profile) \*/",
        config_list.group(2),
    )
    require(
        {name for _, name in configuration_refs} == {"Debug", "Release", "Profile"},
        f"Runner target does not define Debug, Release, and Profile: {configuration_refs!r}",
    )
    for config_id, config_name in configuration_refs:
        config = re.search(
            rf"(?m)^\s*{config_id} /\* {config_name} \*/ = \{{(.*?)(?=^\s*[A-F0-9]{{24}} /\*|\Z)",
            project,
            re.S | re.M,
        )
        require(config is not None, f"Could not read iOS {config_name} build settings")
        value = re.search(r"PRODUCT_BUNDLE_IDENTIFIER\s*=\s*([^;]+);", config.group(1))
        actual = value.group(1).strip().strip('"') if value else None
        require(actual == bundle_id, f"iOS Runner {config_name} bundle ID is {actual!r}, expected {bundle_id!r}")

    with IOS_INFO.open("rb") as info_file:
        info = plistlib.load(info_file)
    actual_display_name = info.get("CFBundleDisplayName")
    require(actual_display_name == display_name, f"iOS display name is {actual_display_name!r}, expected {display_name!r}")
    configured_bundle_id = info.get("CFBundleIdentifier")
    require(
        configured_bundle_id in ("$(PRODUCT_BUNDLE_IDENTIFIER)", bundle_id),
        f"Info.plist CFBundleIdentifier is {configured_bundle_id!r}",
    )


def main() -> None:
    display_name, android_id, ios_id = dart_identity()
    validate_android(display_name, android_id)
    validate_ios(display_name, ios_id)
    print(
        "Native identity validated: "
        f"displayName={display_name!r}, "
        f"androidApplicationId={android_id!r}, "
        f"iosBundleIdentifier={ios_id!r}"
    )


if __name__ == "__main__":
    try:
        main()
    except (OSError, ET.ParseError, plistlib.InvalidFileException) as error:
        print(f"Native identity validation failed: {error}", file=sys.stderr)
        raise SystemExit(1)
