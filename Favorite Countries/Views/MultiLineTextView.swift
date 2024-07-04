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
                .lineLimit(Constants.textFieldLineLimit, reservesSpace: true)
                .padding()
        }
    }
}

extension MultiLineTextView {
    private enum Constants {
        static let textFieldLineLimit: Int = 4
        static let textFieldCornerRadius: CGSize = CGSize(width: 16, height: 16)
    }
}
