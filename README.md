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

### Why Windows-only / self-hosted

The Gaussian Splatting shaders are compiled with DXC, and Unity can only target
D3D with DXC **from the Windows editor** — a Linux CI runner produces broken
splats. A free Unity **Personal** license also can't be activated on GitHub's
hosted Windows runners (it's machine/user-bound). So builds run on a **self-hosted
Windows runner** with Unity already installed and the Personal license activated.

### Releases (CI)

Pushing a `v*` tag (e.g. `v1.0.0`) runs
[`.github/workflows/build-windows.yml`](.github/workflows/build-windows.yml) on the
self-hosted runner: it builds the Windows player, wraps it into a single Inno Setup
installer ([`installer.iss`](installer.iss)) with an uninstaller, and attaches
`EscapeRoom-Setup-*.exe` to the GitHub Release. `workflow_dispatch` does the same
but uploads the installer as a run artifact instead of releasing.

The runner needs no license secrets — it uses the Unity license already activated
on that machine.

### Build it yourself (locally on Windows)

Prerequisites:
- **Unity 2022.3.47f1** (changeset `88c277b85d21`), installed via Unity Hub with
  the **Windows Build Support** module.
- A Unity account with an activated **Personal** license (Hub → Preferences →
  Licenses → *Add* → *Get a free personal license*).
- [**Inno Setup 6**](https://jrsoftware.org/isdl.php) (for the installer step).

Steps:

1. Clone this repo and open it in Unity once. The engine package is pulled
   automatically from the git URL in `Packages/manifest.json` (first import takes
   a while).
2. Build the Windows player — either from the editor (*File → Build Settings →
   Windows → Build*) or headless:

   ```powershell
   & "C:\Program Files\Unity\Hub\Editor\2022.3.47f1\Editor\Unity.exe" `
     -batchmode -nographics -quit `
     -projectPath . -buildTarget Win64 `
     -executeMethod CIBuild.BuildWindows `
     -logFile build.log
   ```

   This writes the player to `build\` (`EscapeRoom.exe` + `EscapeRoom_Data\` + DLLs).
3. Wrap it into the installer:

   ```powershell
   ISCC.exe /DSourceDir=build installer.iss
   ```

   The single-file installer lands in `Output\EscapeRoom-Setup-1.0.0.exe`.

> The raw `build\` folder is not a standalone `.exe` — Unity always ships
> `EscapeRoom.exe` alongside `EscapeRoom_Data\` and `UnityPlayer.dll`. Ship the
> installer, not the loose files.

> Requires a VR headset (OpenXR: SteamVR / Oculus / WMR) to play.

## License

This project builds on the [GS-Verse](https://github.com/Anastasiya999/GS-Verse)
engine - for licensing terms, see the
[LICENSE in the original engine repository](https://github.com/Anastasiya999/GS-Verse/blob/main/LICENSE.md).
