import Foundation
import PackagePlugin

@main
struct LintCommand: CommandPlugin {
    func performCommand(context: PluginContext, targets: [Target], arguments: [String]) throws {
        let swiftLintTool = try context.tool(named: "swiftlint")
        let swiftLintPath = URL(fileURLWithPath: swiftLintTool.path.string)
        
        for target in targets {
            let swiftLintArgs = [
                "lint",
                "--path", "\(target.directory)",
            ]
            
            let task = try Process.run(swiftLintPath, arguments: swiftLintArgs)
            task.waitUntilExit()
            
            if task.terminationStatus == 0 {
                print("Linted the source code in \(target.directory).")
            } else {
                Diagnostics.error("swiftlint invocation failed: exitStatus=\(task.terminationStatus)")
            }
        }
    }
}

enum Shell {
    static func getExitStatus(
        _ command: String,
        _ pipe: Pipe? = nil
    ) -> Int {
        let task = createProcess(command, pipe)
        
        task.launch()
        task.waitUntilExit()
        return Int(task.terminationStatus)
    }
    
    private static func createProcess(_ command: String, _ pipe: Pipe?) -> Process {
        let task = Process()
        if let pipe = pipe {
            task.standardOutput = pipe
            task.standardError = pipe
        }
        
        task.arguments = ["-c", "\(command)"]
        task.launchPath = "/bin/sh"
        
        return task
    }
}

extension URL {
    var escapedPath: String {
        return self.path.replacingOccurrences(of: " ", with: "\\ ")
    }
}
