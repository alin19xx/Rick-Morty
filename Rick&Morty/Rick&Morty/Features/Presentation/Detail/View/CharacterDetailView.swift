//
//  CharacterDetailView.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    init(id: Int) {
        _viewModel = .init(wrappedValue: .init(id: id))
    }
    
    var body: some View {
        ZStack {
            contentView
        }
        .errorAlert(error: $viewModel.error, onDismiss: {
            dismiss()
        })
        .task { await viewModel.fetchCharacter() }
    }
}


// MARK: - Accessory Views

extension CharacterDetailView {
    
    @ViewBuilder
    private var contentView: some View {
        if let character = viewModel.character {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack {
                        CachedAsyncImage(url: character.imageUrl) {
                            VStack {
                                ProgressView()
                                    .frame(minWidth: 200, minHeight: 200)
                            }
                        } content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        gradientView
                    }
                    detailsInfoView(character: character)
                }
            }
        }
    }
    
    private func detailsInfoView(character: CharacterModel) -> some View {
        let details = [
            ("Name", character.name),
            ("Last known location", character.locationName),
            ("First seen in", character.originName),
            ("Status", character.status),
            ("Species", character.species),
            ("Gender", character.gender)
        ]
        
        return ForEach(details, id: \.0) { detail in
            VStack(alignment: .leading, spacing: 8) {
                Text("\(detail.0): \n \(detail.1)")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
    
    private var gradientView: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .top,
                endPoint: .center
            )
        )
    }
    
    private var gradientColors: [Color] {
        colorScheme == .dark ? [.black, .black.opacity(0.5), .clear] : [.white, .white.opacity(0.5), .clear]
    }
}

#Preview {
    NavigationView {
        CharacterDetailView(id: 1)
    }
}
