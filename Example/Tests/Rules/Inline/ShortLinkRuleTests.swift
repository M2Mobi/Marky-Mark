//
//  ShortLinkRuleTests.swift
//  markymark_Tests
//
//  Created by Jim van Zummeren on 20/07/2021.
//  Copyright © 2021 M2mobi. All rights reserved.
//

import XCTest
@testable import markymark

class ShortLinkRuleTests: XCTestCase {

    var sut: ShortLinkRule!

    override func setUp() {
        super.setUp()
        sut = ShortLinkRule()
    }

    func test_WillRecognizesLines_When_CallingRecognizesLinesWithValidInput() {
        XCTAssertTrue(sut.recognizesLines(["<https://www.m2mobi.com>"]))
        XCTAssertTrue(sut.recognizesLines(["<http://www.m2mobi.nl/something/other?id=4&page=4>"]))
        XCTAssertTrue(sut.recognizesLines(["<hkia://flights>"]))
        XCTAssertTrue(sut.recognizesLines(["<google.com>"]))
    }

    func test_WillNotRecognizesLines_When_CallingRecognizesLinesWithInvalidInput() {
        XCTAssertFalse(sut.recognizesLines(["<Google>"]))
        XCTAssertFalse(sut.recognizesLines(["<$$>"]))
        XCTAssertFalse(sut.recognizesLines(["<hello>"]))
        XCTAssertFalse(sut.recognizesLines(["<hello .com>"]))
    }

    func test_GetAllMatchesReturnsZero_When_CallinGetAllMatchesWithInvalidInput() {
        // Assert
        XCTAssert(sut.getAllMatches(["(https://www.google.com)"]).isEmpty)
        XCTAssert(sut.getAllMatches(["<Google>"]).isEmpty)
        XCTAssert(sut.getAllMatches(["<M2mobi .com>"]).isEmpty)
    }

    func test_WillReturnCorrectRanges_WhenCallingGetAllMatchesWithValidInput() {
        // Arrange
        let expectedMatchesRange = NSRange(location: 0, length: 23)
        let expectedMatchesRange2 = NSRange(location: 29, length: 27)

        // Act + Assert
        XCTAssertEqual(sut.getAllMatches(["<http://www.m2mobi.com>"]), [expectedMatchesRange])
        XCTAssertEqual(
            sut.getAllMatches(["<http://www.m2mobi.com> test <http://www.contentful.com>"]),
            [expectedMatchesRange, expectedMatchesRange2]
        )
    }

    func test_WillCreateLinkMarkDownItem_When_CallingCreateWithValidInput() {
        // Act
        let markDownItem = sut.createMarkDownItemWithLines(["<http://www.google.com>"])

        // Assert
        XCTAssert(markDownItem is LinkMarkDownItem)
    }

    func test_ParsesItem_When_InputMatches() throws {
        // Arrange
        let cases: [(String, String, String, UInt)] = [
            (
                "<https://google.com>",
                "https://google.com",
                "https://google.com",
                #line
            ),
            (
                "Inside <http://m2mobi.com> sentence",
                "http://m2mobi.com",
                "http://m2mobi.com",
                #line
            ),
            (
                "Multiple <http://m2mobi.com> in one sentence <http://contentful.com>",
                "http://m2mobi.com",
                "http://m2mobi.com",
                #line
            )
        ]

        for (input, content, url, line) in cases {
            // Act
            let output = sut.createMarkDownItemWithLines([input])

            // Assert
            let linkMarkDownItem = try XCTUnwrap(output as? LinkMarkDownItem)
            XCTAssertEqual(linkMarkDownItem.content, content, line: line)
            XCTAssertEqual(linkMarkDownItem.url, url, line: line)
        }
    }
}
