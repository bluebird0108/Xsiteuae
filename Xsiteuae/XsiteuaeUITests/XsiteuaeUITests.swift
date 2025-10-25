//
//  XsiteuaeUITests.swift
//  XsiteuaeUITests
//
//  Created by Faraz on 23/10/2025.
//

#if canImport(XCTest)
import XCTest

final class XsiteuaeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
#endif
