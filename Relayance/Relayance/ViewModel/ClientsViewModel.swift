//
//  ClientsViewModel.swift
//  Relayance
//
//  Created by Hugues BOUSSELET on 03/09/2025.
//

import Foundation
import SwiftUI

@Observable class ClientsViewModel {
    var clients: [Client]
    
    init(clients: [Client]) {
        self.clients = clients
    }
    
    func addClient(name: String, email: String) -> Bool {
        if !isEmpty(name) && isValid(email) {
            self.clients.append(Client.creerNouveauClient(nom: name, email: email))
            return true
        } else {
            return false
        }
    }
    
    private func isEmpty(_ name: String) -> Bool {
        return name.isEmpty
    }
    
    private func isValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
