//
//  PopToRootEnviornmentKey.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import SwiftUI

struct PopToRootEnviornmentKey: EnvironmentKey {
    static let defaultValue: [Binding<Bool>] = []
}

extension EnvironmentValues {
    var presentations: [Binding<Bool>] {
        get { return self[PopToRootEnviornmentKey.self] }
        set { self[PopToRootEnviornmentKey.self] = newValue }
    }
}
