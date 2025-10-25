//
//  XsiteuaeUITestsLaunchTests.swift
//  XsiteuaeUITests
//
//  Created by Faraz on 23/10/2025.
//

#if canImport(XCTest)
import XCTest

final class XsiteuaeUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
#endif
