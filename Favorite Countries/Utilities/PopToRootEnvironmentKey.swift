//
//  PopToRootEnvironmentKey.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import SwiftUI

struct PopToRootEnvironmentKey: EnvironmentKey {
    static let defaultValue: [Binding<Bool>] = []
}

extension EnvironmentValues {
    var presentations: [Binding<Bool>] {
        get { return self[PopToRootEnvironmentKey.self] }
        set { self[PopToRootEnvironmentKey.self] = newValue }
    }
}
