//
//  HomeView.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 13/1/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = CharactersViewModel()
    
    @State private var navigationPath: [Route] = []
    
    @State private var selectedStatus: Status = .any
    @State private var selectedGender: Gender = .any
    @State private var searchText: String = ""
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            homeContent
                .navigationTitle("Rick&Morty")
                .toolbar { toolbarContent }
                .searchable(text: $searchText, prompt: "Search by name")
                .onSubmit(of: .search, { applyFilters() })
                .onChange(of: selectedGender, { applyFilters() })
                .onChange(of: selectedStatus, { applyFilters() })
                .onChange(of: searchText, {
                    if searchText.isEmpty {
                        applyFilters()
                    }
                })
                .navigationDestination(for: Route.self) { route in
                    RouteResolver(route: route)
                }
        }
    }
}
 

// MARK: - Accessory Views

extension HomeView {
    
    private var homeContent: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.characters) { character in
                    CharacterCellView(character: character, onSelect: {
                        navigationPath.append(.characterDetail(id: character.id))
                    })
                    .onAppear { prefetchIfNeeded(for: character) }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private var toolbarContent: some View {
        Menu {
            Picker("Status", selection: $selectedStatus) {
                ForEach(Status.allCases, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            
            Picker("Gender", selection: $selectedGender) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    Text(gender.rawValue).tag(gender)
                }
            }
        } label: {
            Image(systemName: "line.horizontal.3.decrease.circle")
        }
    }
}


// MARK: - Private Methods

extension HomeView {
    
    private func prefetchIfNeeded(for character: CharacterCardModel) {
        guard let index = viewModel.characters.firstIndex(where: { $0.id == character.id }) else { return }
        
        let indexForTrigger = viewModel.characters.index(viewModel.characters.endIndex, offsetBy: -5)
        if index == indexForTrigger {
            Task.detached {
                await viewModel.fetchCharacters()
            }
        }
    }
    
    private func applyFilters() {
        var params = CharactersUseCaseParameters()
        
        if selectedStatus != .any {
            params.status = selectedStatus.rawValue.lowercased()
        }
        
        if selectedGender != .any {
            params.gender = selectedGender.rawValue.lowercased()
        }
        
        if !searchText.isEmpty {
            params.name = searchText
        }
        
        viewModel.applyFilters(params)
    }
}

#Preview {
    HomeView()
}
