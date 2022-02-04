import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        return [
            .prebuildCommand(
                displayName: "Swift Lint",
                executable: try context.tool(named: "swiftlint").path,
                arguments: ["--path", target.directory.string],
                outputFilesDirectory: context.pluginWorkDirectory.appending("SwiftLint")
            )
        ]
    }
}
