//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public class BlockQuoteRule : RegExRule {

    /// Example: > Quote
    public var expression = NSRegularExpression.expressionWithPattern("(^>{1,}) (.*?)$")

    //MARK: Rule

    public func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        let content = lines.first?.subStringWithExpression(expression, ofGroup: 2)
        return QuoteMarkDownItem(lines: lines, content: content ?? "")
    }
}