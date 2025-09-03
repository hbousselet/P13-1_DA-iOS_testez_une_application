//
//  RelayanceApp.swift
//  Relayance
//
//  Created by Amandine Cousin on 08/07/2024.
//

import SwiftUI

@main
struct RelayanceApp: App {
    @State private var clientsViewModel = ClientsViewModel(clients: ModelData.chargement("Source.json"))
    var body: some Scene {
        WindowGroup {
            ListClientsView()
                .environment(clientsViewModel)
        }
    }
}
