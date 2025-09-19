//
//  DateTests.swift
//  RelayanceTests
//
//  Created by Hugues BOUSSELET on 19/09/2025.
//

import XCTest
@testable import Relayance
import Foundation

class DateExtensionTests: XCTestCase {
        
    func testDateFromStringValidISOStringReturnsDate() {
        // Given
        let validISOString = "2023-12-25"
        
        // When
        let result = Date.dateFromString(validISOString)
        
        // Then
        XCTAssertNotNil(result, "Should return a valid date for valid ISO string")
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: result!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.day, 25)
    }
    
    func testDateFromStringInvalidStringReturnsNil() {
        // Given
        let invalidStrings = [
            "invalid-date",
            "2023-13-45",
            ""
        ]
        
        // When & Then
        for invalidString in invalidStrings {
            let result = Date.dateFromString(invalidString)
            XCTAssertNil(result, "Should return nil for invalid string: \(invalidString)")
        }
    }
    
    func testDateFromStringEdgeCases() {
        // Given
        let edgeCases = [
            "1900-01-01",
            "2100-12-31",
            "2000-02-29"
        ]
        
        // When & Then
        for dateString in edgeCases {
            let result = Date.dateFromString(dateString)
            XCTAssertNotNil(result, "Should handle edge case: \(dateString)")
        }
    }
    
    
    func testStringGoodFormatFromDateValidDateReturnsFormattedString() {
        // Given
        let date = Date(timeIntervalSince1970: 1703462400)
        
        // When
        let result = Date.stringGoodFormatFromDate(date)
        
        // Then
        XCTAssertNotNil(result, "Should return formatted string for valid date")
        XCTAssertTrue(result!.contains("2023-12-25T"), "Should contain correct date part")
        XCTAssertTrue(result!.hasSuffix("Z"), "Should end with Z for UTC")
        XCTAssertTrue(result!.contains("."), "Should contain milliseconds")
    }
    
    func testStringGoodFormatFromDateDifferentDates() {
        // Given
        let dates = [
            Date(timeIntervalSince1970: 0),
            Date(timeIntervalSince1970: 946684800),
            Date() // Date actuelle
        ]
        
        // When & Then
        for date in dates {
            let result = Date.stringGoodFormatFromDate(date)
            XCTAssertNotNil(result, "Should format any valid date")
            XCTAssertTrue(result!.matches("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}Z"),
                         "Should match expected format pattern")
        }
    }
    
    func testStringFromDateValidDateAfter2000ReturnsFormattedString() {
        // Given
        let validDate = Date(timeIntervalSince1970: 1703462400)
        
        // When
        let result = Date.stringFromDate(validDate)
        
        // Then
        XCTAssertNotNil(result, "Should return formatted string for valid date after 2000")
        XCTAssertEqual(result, "25-12-2023", "Should return correct format dd-MM-yyyy")
    }
    
    func testStringFromDateDateBefore2000ReturnsNil() {
        // Given
        let dateBefore2000 = Date(timeIntervalSince1970: 946684799)
        
        // When
        let result = Date.stringFromDate(dateBefore2000)
        
        // Then
        XCTAssertNil(result, "Should return nil for dates before January 1, 2000")
    }
    
    func testStringFromDateExactlyJanuary2000ReturnsString() {
        // Given
        let exactDate = Date(timeIntervalSince1970: 946684800)
        
        // When
        let result = Date.stringFromDate(exactDate)
        
        // Then
        XCTAssertNotNil(result, "Should return formatted string for exactly January 1, 2000")
        XCTAssertEqual(result, "01-01-2000", "Should format January 1, 2000 correctly")
    }
    
    func testStringFromDateVariousDatesAfter2000() {
        // Given
        let testCases: [(Date, String)] = [
            (Date(timeIntervalSince1970: 946684800), "01-01-2000"),
            (Date(timeIntervalSince1970: 1577836800), "01-01-2020"),
            (Date(timeIntervalSince1970: 1703462400), "25-12-2023")
        ]
        
        // When & Then
        for (date, expectedString) in testCases {
            let result = Date.stringFromDate(date)
            XCTAssertEqual(result, expectedString, "Date \(date) should format to \(expectedString)")
        }
    }
        
    func testGetDayVariousDatesReturnsCorrectDay() {
        // Given
        let testCases: [(Date, Int)] = [
            (Date(timeIntervalSince1970: 1703462400), 25),
            (Date(timeIntervalSince1970: 946684800), 1),
            (Date(timeIntervalSince1970: 1577836800), 1)
        ]
        
        // When & Then
        for (date, expectedDay) in testCases {
            let result = date.getDay()
            XCTAssertEqual(result, expectedDay, "Day should be \(expectedDay) for date \(date)")
        }
    }
    
    // MARK: - Tests pour getMonth
    
    func testGetMonthVariousDatesReturnsCorrectMonth() {
        // Given
        let testCases: [(Date, Int)] = [
            (Date(timeIntervalSince1970: 1703462400), 12), // 2023-12-25 (December)
            (Date(timeIntervalSince1970: 946684800), 1),   // 2000-01-01 (January)
            (Date(timeIntervalSince1970: 1590969600), 6)   // 2020-06-01 (June)
        ]
        
        // When & Then
        for (date, expectedMonth) in testCases {
            let result = date.getMonth()
            XCTAssertEqual(result, expectedMonth, "Month should be \(expectedMonth) for date \(date)")
        }
    }
        
    func testGetYearVariousDatesReturnsCorrectYear() {
        // Given
        let testCases: [(Date, Int)] = [
            (Date(timeIntervalSince1970: 1703462400), 2023),
            (Date(timeIntervalSince1970: 946684800), 2000),
            (Date(timeIntervalSince1970: 0), 1970)
        ]
        
        // When & Then
        for (date, expectedYear) in testCases {
            let result = date.getYear()
            XCTAssertEqual(result, expectedYear, "Year should be \(expectedYear) for date \(date)")
        }
    }
        
    func testDateConversionRoundTrip() {
        // Given
        let originalString = "2023-06-15"
        
        // When
        guard let date = Date.dateFromString(originalString) else {
            XCTFail("Failed to create date from string")
            return
        }
        
        let day = date.getDay()
        let month = date.getMonth()
        let year = date.getYear()
        
        // Then
        XCTAssertEqual(day, 15, "Day should be preserved")
        XCTAssertEqual(month, 6, "Month should be preserved")
        XCTAssertEqual(year, 2023, "Year should be preserved")
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
