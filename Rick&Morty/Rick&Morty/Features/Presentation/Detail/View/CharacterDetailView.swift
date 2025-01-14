//
//  CharacterDetailView.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    init(id: Int) {
        _viewModel = .init(wrappedValue: .init(id: id))
    }
    
    var body: some View {
        VStack {
            if let character = viewModel.character {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        CachedAsyncImage(url: character.imageUrl) {
                            ProgressView()
                        } content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        Group {
                            Text(character.name)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("Status: \(character.status)")
                                .font(.title3)
                                .foregroundColor(.gray)
                            
                            Text("Species: \(character.species)")
                                .font(.title3)
                                .foregroundColor(.gray)
                            
                            Text("Gender: \(character.gender)")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                    }
                }
            } else if viewModel.isLoading {
                ProgressView("Loading character...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .ignoresSafeArea(.all)
        .task {
            await viewModel.fetchCharacter()
        }
    }
}

#Preview {
    CharacterDetailView(id: 1)
}
