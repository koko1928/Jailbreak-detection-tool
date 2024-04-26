import UIKit
import Foundation
import Darwin

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if jailbreakCheck() {
            print("Jailbreak detected")
        } else {
            print("Jailbreak not detected")
        }
    }
    
    func jailbreakCheck() -> Bool {
        let jailbreakFilePaths = ["/Applications/Cydia.app",
                                  "/Library/MobileSubstrate/MobileSubstrate.dylib",
                                  "/bin/bash",
                                  "/usr/sbin/sshd",
                                  "/etc/apt",
                                  "/private/var/lib/apt/",
                                  "/Applications/blackra1n.app",
                                  "/Applications/RockApp.app",
                                  "/Applications/SBSettings.app",
                                  "/Applications/FakeCarrier.app",
                                  "/Applications/WinterBoard.app"]
        for path in jailbreakFilePaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        if let cydiaURL = URL(string: "cydia://package/com.example.package"), UIApplication.shared.canOpenURL(cydiaURL) {
            return true
        }
        
        var targetTask: Int32 = 0
        var kr = task_for_pid(mach_task_self_, Int32(ProcessInfo.processInfo.processIdentifier), &targetTask)
        if kr != KERN_SUCCESS {
            return true
        }
        
        let jailbreakBinaryNames = ["ssh", "sshd", "dropbear", "sftp-server"]
        for name in jailbreakBinaryNames {
            let path = "/bin/\(name)"
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        let systemDirs = ["/bin", "/sbin", "/usr/bin", "/usr/sbin", "/usr/libexec"]
        for dir in systemDirs {
            if FileManager.default.isWritableFile(atPath: dir) {
                return true
            }
        }
        
        return false
    }
}
