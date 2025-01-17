//
//  BaseViewModel.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 17/1/25.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var error: NetworkError?
    
    func setLoading(_ isLoading: Bool) {
        Task { @MainActor [weak self] in
            self?.isLoading = isLoading
        }
    }
    
    func setError(_ error: NetworkError?) {
        Task { @MainActor [weak self] in
            self?.error = error
        }
    }
}
