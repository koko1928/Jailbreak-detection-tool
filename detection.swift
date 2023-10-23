import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if isJailbroken() {
            print("Jailbreak detected")
        } else {
            print("Jailbreak not detected")
        }
    }

    func isJailbroken() -> Bool {
        if isFileExist("/Applications/Cydia.app") ||
           isFileExist("/Library/MobileSubstrate/MobileSubstrate.dylib") ||
           isFileExist("/bin/bash") ||
           isFileExist("/usr/sbin/sshd") ||
           isFileExist("/etc/apt") ||
           isFileExist("/private/var/lib/apt/") ||
           isFileExist("/Applications/iFile.app") ||
           isFileExist("/Applications/FakeCarrier.app") ||
           isFileExist("/Applications/SBSettings.app") {
            return true
        }

        if isAppRunning("Cydia") ||
           isAppRunning("MobileSubstrate") ||
           isAppRunning("sshd") ||
           isAppRunning("sbsettings") {
            return true
        }

        if isSymbolicLink("/Applications") ||
           isSymbolicLink("/usr/libexec") {
            return true
        }

        if hasEntitlement("com.apple.springboard.debug") {
            return true
        }

        return false
    }

    func isFileExist(_ path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }

    func isAppRunning(_ appName: String) -> Bool {
        if let task = ProcessInfo.processInfo.runningProcesses.first(where: { $0.lowercased() == appName.lowercased() }) {
            return true
        }
        return false
    }

    func isSymbolicLink(_ path: String) -> Bool {
        var isSymbolic: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isSymbolic)
        return exists && isSymbolic.boolValue
    }

    func hasEntitlement(_ entitlement: String) -> Bool {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: "/Library/MobileSubstrate/DynamicLibraries/" + entitlement + ".dylib")) {
            return true
        }
        return false
    }
}
