# Escape Room (GS-Verse)

VR escape room built on the [GS-Verse](https://github.com/Anastasiya999/GS-Verse) Gaussian Splatting engine.
Unity **2022.3.47f1**, OpenXR + XR Interaction Toolkit.

## Engine dependency

The engine is **not** vendored here, it's pulled as a UPM git package in
[`Packages/manifest.json`](Packages/manifest.json):

```
"org.nesnausk.gaussian-splatting": "https://github.com/denysk0/GS-Verse.git?path=/package#escape-room-v1"
```

This points at a fork pinned to tag `escape-room-v1`, which carries a few engine
changes the room needs (see [PR #18](https://github.com/Anastasiya999/GS-Verse/pull/18)).
Once that PR is merged, switch the URL to
`https://github.com/Anastasiya999/GS-Verse.git?path=/package#<tag>`.

## Build

Builds run in CI ([`.github/workflows/build-windows.yml`](.github/workflows/build-windows.yml)):
pushing a `v*` tag produces a Windows build, wraps it into a single Inno Setup
installer ([`installer.iss`](installer.iss)) with an uninstaller, and attaches
`EscapeRoom-Setup-*.exe` to the GitHub Release.

CI needs Unity license secrets: `UNITY_EMAIL`, `UNITY_PASSWORD`, `UNITY_LICENSE`.

> Requires a VR headset (OpenXR: SteamVR / Oculus / WMR).

## License

This project builds on the [GS-Verse](https://github.com/Anastasiya999/GS-Verse)
engine - for licensing terms, see the
[LICENSE in the original engine repository](https://github.com/Anastasiya999/GS-Verse/blob/main/LICENSE.md).
