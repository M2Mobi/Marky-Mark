//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class ContentfulFlavor: Flavor {

    open var rules: [Rule] = [
        HeaderRule(),
        ListRule(listTypes: [
            AlphabeticListType(),
            OrderedListType()
        ]),
        BlockQuoteRule(),
        HorizontalLineRule(),
        CodeBlockRule(),
        ImageBlockRule()
    ]

    open var defaultRule: Rule = ParagraphRule()

    open var inlineRules: [InlineRule] = [
        LinkRule(),
        ShortLinkRule(),
        BoldRule(),
        ItalicRule(),
        StrikeRule(),
        ImageRule(),
        InlineCodeRule()
    ]

    open var defaultInlineRule: InlineRule = InlineTextRule()

    public init() {

    }
}
