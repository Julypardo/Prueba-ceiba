//
//  HomeViewTests.swift
//  PruebaCeibaUITests
//
//  Created by July Pardo on 11/05/23.
//

import XCTest
import SwiftUI
@testable import PruebaCeiba

class HomeViewTests: XCTestCase {
    
    var sut: HomeView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSearchTextField() throws {
        // given
        let expectedSearchText = "Search text"
        
        // when
        let textField = try XCTUnwrap(sut.findTextField())
        textField.perform(NSSelectorFromString("insertText:"), with: expectedSearchText)
        
        // then
        XCTAssertEqual(sut.viewModel.search, expectedSearchText)
    }
}

extension View {
    func findTextField() throws -> UITextField {
        let textField = try XCTUnwrap(recursiveSubviews.compactMap { $0 as? UITextField }.first, "TextField not found")
        return textField
    }

    var recursiveSubviews: [UIView] {
        var subviews: [UIView] = []
        if let view = self as? UITextField {
            return [view]
        }
        let children = Mirror(reflecting: self).children
        if children.count == 0 {
            return []
        }
        for (_, value) in children {
            if let view = value as? UIView {
                subviews.append(view)
                subviews += view.recursiveSubviews
            }
        }
        return subviews
    }
}

extension UIView {
    var recursiveSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubviews }
    }
}
