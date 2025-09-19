//
//  ClientsViewModelTests.swift
//  RelayanceTests
//
//  Created by Hugues BOUSSELET on 04/09/2025.
//

import XCTest
@testable import Relayance

final class ClientsViewModelTests: XCTestCase {
    var clients: [Client] = []
    
    override func setUpWithError() throws {
        do {
            guard let data = dummyJsonClients.data(using: .utf8) else {
                XCTFail("not able to decode dummy json mate")
                return }
            clients = try JSONDecoder().decode([Client].self, from: data)
        } catch {
            XCTFail("not able to decode dummy json mate")
        }
    }

    override func tearDownWithError() throws {
        clients = []
    }
    
    func testAddClientSuccessfull() {
        // Given
        let viewModel = ClientsViewModel(clients: clients)
        
        //When
        let result = viewModel.addClient(name: "Hugues", email: "hugues.bousselet@gmail.com")
        
        // Then
        XCTAssert(viewModel.clients.last?.email == "hugues.bousselet@gmail.com")
        XCTAssert(result)
    }
    
    func testAddClientNoNameNOK() {
        // Given
        let viewModel = ClientsViewModel(clients: clients)
        
        //When
        let result = viewModel.addClient(name: "", email: "hugues.bousselet@gmail.com")
        
        // Then
        XCTAssertFalse(viewModel.clients.contains(where: {$0.email == "hugues.bousselet@gmail.com" }))
        XCTAssertFalse(result)
    }
    
    func testAddClientNotValidEmailNOK() {
        // Given
        let viewModel = ClientsViewModel(clients: clients)
        
        //When
        let result = viewModel.addClient(name: "", email: "hugues.bousselet.gmail.com")
        
        // Then
        XCTAssertFalse(viewModel.clients.contains(where: {$0.email == "hugues.bousselet@gmail.com" }))
        XCTAssertFalse(result)
    }
    
    func testRemoveClientSuccessfull() {
        // Given
        let viewModel = ClientsViewModel(clients: clients)
        let client = viewModel.clients.first! /*frida.kahlo@example.com*/
        
        //When
        let result = viewModel.delete(client)
        
        // Then
        XCTAssertFalse(viewModel.clients.contains(where: {$0.email == "frida.kahlo@example.com" }))
        XCTAssert(result)
    }
    
    func testRemoveClientSuccessfu() {
        // Given
        let viewModel = ClientsViewModel(clients: clients)
        let client = Client(nom: "Merland",
                            email: "pierre@merland.com",
                            dateCreationString: "2025-09-03T14:07:00Z")
        
        //When
        let result = viewModel.delete(client)
        
        // Then
        XCTAssertFalse(viewModel.clients.contains(where: {$0.email == "pierre@merland.com" }))
        XCTAssertFalse(result)
    }
    
    
    
    
    
    
    
    
    
    
    var dummyJsonClients = """
    [
        {
            "nom": "Frida Kahlo",
            "email": "frida.kahlo@example.com",
            "date_creation": "2024-01-15T08:30:00Z"
        },
        {
            "nom": "Mahatma Gandhi",
            "email": "mahatma.gandhi@example.com",
            "date_creation": "2023-02-20T09:15:00Z"
        },
        {
            "nom": "Malala Yousafzai",
            "email": "malala.yousafzai@example.com",
            "date_creation": "2022-03-10T10:45:00Z"
        }
        ]
"""
}
