//
//  MultiLineTextView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import SwiftUI

struct MultiLineTextView: View {
    @Binding var description: String
    let placeHolder: String
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $description, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(4, reservesSpace: true)
                .padding()
        }
    }
}

private enum Constants {
    static let textFieldLineLimit: Int = 8
    static let textFieldHeight: CGFloat = 250
    static let textFieldCornerRadius: CGSize = CGSize(width: 16, height: 16)
    static let textFieldBorderOpacity: CGFloat = 0.2
    static let textFieldBorderWidth: CGFloat = 4
}
