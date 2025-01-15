//
//  ErrorAlertModifier.swift
//  Rick&Morty
//
//  Created by Alex Lin Segarra on 15/1/25.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var error: NetworkError?
    var onDismiss: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: .constant(error != nil)) {
                Alert(
                    title: Text("Rick&Morty"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK")) {
                        error = nil
                        onDismiss?()
                    }
                )
            }
    }
    
    private var errorMessage: String {
        guard let error else { return "" }
        
        switch error {
        case .httpError(statusCode: let statusCode):
            if statusCode == 404 {
                return "No results found"
            }
            return "Something went wrong."
           default:
            return "Something went wrong."
        }
    }
}

extension View {
    func errorAlert(error: Binding<NetworkError?>,
                    onDismiss: (() -> Void)? = nil) -> some View {
        self.modifier(ErrorAlertModifier(error: error, onDismiss: onDismiss))
    }
}
