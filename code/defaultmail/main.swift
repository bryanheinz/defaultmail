//
//  main.swift
//  defaultmail
//
//  Created by Bryan Heinz on 2/10/21.
//

import AppKit
import Foundation
import ArgumentParser

let __version__ = "1.0.1"

struct SetDefault: ParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(
        abstract: "Sets the default mail client for mailto: links."
    )
    
    @Flag(help: "Show the default mailto: bundle id.")
    var get = false
    
    @Flag(help: "Sets Apple Mail as the default mailto:.")
    var reset = false
    
    @Flag(help: "Sets Microsoft Outlook as the default mailto:.")
    var outlook = false
    
    @Option(name: .shortAndLong, help: ArgumentHelp(
            "Sets the default mailto: to the provided bundle ID.",
            valueName: "bundle-id"
    ))
    var set: String?
    
    @Flag(name: .shortAndLong, help: "Show the version number.")
    var version = false
    
    
    func validate() throws {
        if reset == true && outlook == true {
            throw ValidationError("Please choose to either reset OR set Outlook.")
        }
        
        if get == false && reset == false && outlook == false && set == nil && version == false {
            throw ValidationError("Please use either --get, --reset, --outlook, or --set.")
        }
    }
    
    func run() {
        if version {
            print("Version: \(__version__)")
            return
        }
        
        if get {
            let mailScheme = URL(string: "mailto:")!
            if let mailtoApp = NSWorkspace.shared.urlForApplication(toOpen: mailScheme) {
                if let mailBundleID = Bundle.init(url: mailtoApp)?.bundleIdentifier {
                    print(mailBundleID)
                } else {
                    print("Error: couldn't find the bundle ID for the default mailto: application.")
                }
            } else {
                print("Error: couldn't find the default application for mailto: links.")
            }
        } else if reset {
            LSSetDefaultHandlerForURLScheme("mailto" as CFString, "com.apple.mail" as CFString)
        } else if outlook {
            LSSetDefaultHandlerForURLScheme("mailto" as CFString, "com.microsoft.outlook" as CFString)
        } else {
            if let bundleID = set {
                LSSetDefaultHandlerForURLScheme("mailto" as CFString, bundleID as CFString)
            } else {
                print("Missing application bundle ID for --set option.")
                return
            }
        }
    }
}

SetDefault.main()
