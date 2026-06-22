using System.Linq;
using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEngine;

// Build entry point invoked from CI:
//   Unity -batchmode -nographics -quit -executeMethod CIBuild.BuildWindows
public static class CIBuild
{
    public static void BuildWindows()
    {
        var scenes = EditorBuildSettings.scenes
            .Where(s => s.enabled)
            .Select(s => s.path)
            .ToArray();

        var options = new BuildPlayerOptions
        {
            scenes = scenes,
            locationPathName = "build/EscapeRoom.exe",
            target = BuildTarget.StandaloneWindows64,
            options = BuildOptions.None,
        };

        BuildReport report = BuildPipeline.BuildPlayer(options);
        BuildSummary summary = report.summary;

        Debug.Log($"Build {summary.result}: {summary.totalSize} bytes, {summary.totalErrors} errors");

        if (summary.result != BuildResult.Succeeded)
            EditorApplication.Exit(1);
    }
}
