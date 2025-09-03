//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by Hugues BOUSSELET on 03/09/2025.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
    
    let clientsList: [Client] = ModelData.chargement("Source.json")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitClientTest() throws {
        // when
        let client = Client(nom: "Merland",
                            email: "pierre@merland.com",
                            dateCreationString: "2025-09-03T14:07:00Z")
        
        XCTAssert(client.nom == "Merland")
        XCTAssert(client.email == "pierre@merland.com")
        XCTAssert(client.dateCreation == Date.dateFromString("2025-09-03T14:07:00Z"))
    }
    
    func testCreateNewClientTest() throws {
        let newClient = Client.creerNouveauClient(nom: "Dupont", email: "paul.dupont@gmail.com")
        
        XCTAssert(newClient.nom == "Dupont")
        XCTAssert(newClient.email == "paul.dupont@gmail.com")
//        XCTAssert(newClient.dateCreation == Date.now) ne marche pas, il doit se jouer une seconde ou quelques ms
        // ou bien rajouter un interval ?
    }
    
    func testIsNewClient() throws {
        let client = Client(nom: "Merland",
                            email: "pierre@merland.com",
                            dateCreationString: Date.stringGoodFormatFromDate(Date.now)!)
        
        XCTAssert(client.estNouveauClient())
    }
    
    func testIsNotANewClient() throws {
        let client = Client(nom: "Merland",
                            email: "pierre@merland.com",
                            dateCreationString: Date.stringGoodFormatFromDate(Date.now - 3600 * 24)!)
        XCTAssertFalse(client.estNouveauClient())
    }
    
    func testClientIsInTheList() throws {
        let client = clientsList.first!
        XCTAssert(client.clientExiste(clientsList: clientsList))
    }
    
    func testClientNotInTheList() throws {
        var client = clientsList.first!
        client.nom = "Jean Moulin"
        XCTAssertFalse(client.clientExiste(clientsList: clientsList))
    }
    
    func testClientFormatDateToString() throws {
        let client = clientsList.first!
        
        XCTAssert(client.formatDateVersString() == "15-01-2024")
    }
    
    func testClientFormatDateToStringWithWrongDate() throws {
        let client = Client(nom: "Merland",
                            email: "pierre@merland.com",
                            dateCreationString: "")
        XCTAssert(client.formatDateVersString() == Date.stringFromDate(Date.now))
    }
    

}
