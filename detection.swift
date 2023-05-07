import UIKit

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
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/private/var/lib/apt/") ||
            fileManager.fileExists(atPath: "/Applications/blackra1n.app") ||
            fileManager.fileExists(atPath: "/Applications/RockApp.app") ||
            fileManager.fileExists(atPath: "/Applications/SBSettings.app") ||
            fileManager.fileExists(atPath: "/Applications/FakeCarrier.app") ||
            fileManager.fileExists(atPath: "/Applications/WinterBoard.app") {
            return true
        }
        return false
    }
}
