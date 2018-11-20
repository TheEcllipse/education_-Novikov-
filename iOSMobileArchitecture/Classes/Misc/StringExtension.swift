//
//  StringExtension.swift
//  DrSmart
//
//  Created by Andrey Chernyshev on 04.07.2018.
//  Copyright © 2018 SimbirSoft. All rights reserved.
//

import UIKit.UIFont

extension String {
    static func choosePluralForm(byNumber: Int, one: String, two: String, many: String) -> String {
        var result = many
        let number = byNumber % 100
        
        if (number < 10 || number >= 20) {
            if (number % 10 == 1) {
                result = one
            }
            if (number % 10 > 1 && number % 10 < 5) {
                result = two
            }
        }
        return result
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var asBase64: String {
        return data(using: String.Encoding.utf8)?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) ?? ""
    }
    
    var fromBase64: String {
        let decodedData = Data(base64Encoded: self)!
        return String(data: decodedData, encoding: .utf8)!
    }
    
    func htmlToAttributeString(font: UIFont? = nil) -> NSAttributedString {
        guard let data = self.data(using: String.Encoding.utf8),
            let attr = try? NSMutableAttributedString(data: data,
                                                      options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue],
                                                      documentAttributes: nil)
        else {
            return NSAttributedString(string: self)
        }
        
        if let font = font {
            let range = attr.mutableString.range(of: attr.mutableString as String)
            attr.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
        
        return attr
    }
}
