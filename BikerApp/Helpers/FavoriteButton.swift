//
//  FavoriteButton.swift
//  BaTest
//
//  Created by Safa Şık on 03.02.24.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    var action: () -> Void

    var body: some View {
        Button {
            isSet.toggle()
            action()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

/*#Preview {
    FavoriteButton(isSet: .constant(true))
}*/
