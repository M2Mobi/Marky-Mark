//
//  ShortLinkRule.swift
//  markymark
//
//  Created by Jim van Zummeren on 20/07/2021.
//  Copyright © 2021 M2mobi. All rights reserved.
//

import Foundation

open class ShortLinkRule: InlineRule {
    
    /// Example: <http://www.google.com>
    open var expression = NSRegularExpression.expressionWithPattern(
        #"<(.+?)>"#
    )
        
    public func getAllMatches(_ lines: [String]) -> [NSRange] {
        guard let line = lines.first else { return [] }
        return getResults(line).map { $0.range }
    }

    // MARK: Rule

    public func recognizesLines(_ lines: [String]) -> Bool {
        guard let line = lines.first else { return false }
        return getResults(line).count > 0
    }

    public func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        let url: String? = lines.first?.subStringWithExpression(expression, ofGroup: 1)

        return LinkMarkDownItem(
            lines: lines,
            content: url ?? "",
            url: url ?? ""
        )
    }
}

private extension ShortLinkRule {

    private func getResults(_ string: String) -> [NSTextCheckingResult] {
        let range = NSRange(location: 0, length: string.length())
        let results = expression.matches(in: string, options: [], range: range)
        
        let validResults = results.filter {
            isValidURLString(string.subString($0.range(at: 1)))
        }
        
        return validResults
    }
    
    private func isValidURLString(_ string: String) -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == string.utf16.count
        } else {
            return false
        }
    }
}
