//
//  CharacterCardView.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import SwiftUI

struct CharacterCellView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let character: CharacterCardModel
    let onSelect: () -> Void
    
    var body: some View {
        ZStack {
            cardImage
            overlay
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 8)
    }
}


// MARK: - Accessory Views

extension CharacterCellView {
    
    private var cardImage: some View {
        CachedAsyncImage(url: character.imageUrl,
                         placeholder: {
            ProgressView()
        }, content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        })
    }
    
    private var overlay: some View {
        VStack {
            Spacer()
            Text(character.name)
                .font(.headline)
                .lineLimit(3)
                .padding(.bottom, 8)
                .padding(.horizontal, 6)
            
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .bottom,
                endPoint: .center
            )
        )
        .onTapGesture { onSelect() }
    }
    
    private var gradientColors: [Color] {
        colorScheme == .dark ? [.black, .clear] : [.white, .clear]
    }
}

#Preview {
    CharacterCellView(
        character: .init(
            id: 1,
            name: "Morty Smith",
            imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        ),
        onSelect: {
        })
        .frame(width: 150, height: 200)
}
