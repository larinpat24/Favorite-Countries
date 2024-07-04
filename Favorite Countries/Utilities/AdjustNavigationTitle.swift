//
//  AdjustNavigationTitle.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import SwiftUI

extension View {
    /// Allows the navigation title to adjust its size based on screen size
    func adjustNavigationTitleToFitScreen() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}
