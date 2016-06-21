/*
 
 HexColorTransformer.swift
 
 CotEditor
 https://coteditor.com
 
 Created by 1024jp on 2014-09-12.
 
 ------------------------------------------------------------------------------
 
 © 2014-2016 1024jp
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 */

import Foundation
import AppKit.NSColor

class HexColorTransformer: ValueTransformer {
    
    // MARK: Value Transformer Methods
    
    /// Class of transformed value
    override class func transformedValueClass() -> AnyClass {
        
        return NSString.self
    }
    
    
    /// Can reverse transformeation?
    override class func allowsReverseTransformation() -> Bool {
        
        return true
    }
    
    
    /// From color code hex to NSColor (String -> NSColor)
    override func transformedValue(_ value: AnyObject?) -> AnyObject? {
        
        guard let code = value as? String else {
            return nil
        }
        
        var type: WFColorCodeType = .invalid
        let color = NSColor(colorCode: code, codeType: &type)
        
        guard type == .hex || type == .shortHex else { return nil }
        
        return color
    }
    
    
    /// From NSColor to hex color code string (NSColor -> String)
    override func reverseTransformedValue(_ value: AnyObject?) -> AnyObject? {
        
        guard let color = value as? NSColor else { return "#000000" }
        
        let sanitizedColor = color.usingColorSpaceName(NSCalibratedRGBColorSpace)
        
        return sanitizedColor?.colorCode(with: .hex)
    }
    
}
