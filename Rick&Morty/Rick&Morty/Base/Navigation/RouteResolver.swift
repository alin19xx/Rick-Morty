//
//  RouteResolver.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 14/1/25.
//

import SwiftUI

struct RouteResolver: View {
    let route: Route
    
    var body: some View {
        switch route {
        case .characterDetail(let id):
            CharacterDetailView(id: id)
        }
    }
}

#Preview {
    RouteResolver(route: .characterDetail(id: 1))
}
