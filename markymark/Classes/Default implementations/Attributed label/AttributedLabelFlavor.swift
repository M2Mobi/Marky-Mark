//
//  AttributedLabelFlavor.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

open class AttributedLabelFlavor: Flavor {
    open var rules: [Rule] = [HeaderRule()]

    open var defaultRule: Rule = ParagraphRule()

    open var inlineRules: [InlineRule] = [
        ItalicRule(),
        BoldRule(),
        StrikeRule(),
        LinkRule(),
        ShortLinkRule()
    ]

    open var defaultInlineRule: InlineRule = InlineTextRule()
}
