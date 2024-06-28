//
//  Item.swift
//  Favorite Countries
//
//  Created by Niral Patel on 6/28/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
