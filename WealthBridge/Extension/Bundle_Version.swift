//
//  Bundle+Version.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-01.
//

import SwiftUI

extension Bundle {
    var appVersion: String {
        guard let version = infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "1.0.0"
        }
        return version
    }
}

