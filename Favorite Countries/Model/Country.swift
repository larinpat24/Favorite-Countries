//
//  SearchableCountry.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import Foundation
import SwiftData

protocol Country {
    var id: UUID { get }
    var countryCode: String { get }
    var name: String { get }
    var capitalCity: String { get }
    var longitude: String { get }
    var latitude: String { get }
}
