//
//  SecurityControl.swift
//  NMBaseApp
//
//  Created by MnzfM on 12.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation
import UIKit

public class SecurityControl {
    
    public static let shared = SecurityControl()
    
    public func isReliableDevice () {
        
        if TARGET_IPHONE_SIMULATOR != 1
        {
            
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") // Check 1 : existence of files that are common for jailbroken devices
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/bin/ssh")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!)
                    {
                    UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
            }
           
            let stringToWrite = "Jailbreak Test"  // Check 2 : Reading and writing in system directories (sandbox violation)
            do
            {
                try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)   //Device is jailbroken
              
                UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)

            }catch
            {
                return
            }
            
        }else
        {
            return
        }
    }
    
}

