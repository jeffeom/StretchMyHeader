//
//  NewsItem.swift
//  StretchMyHeader
//
//  Created by Jeff Eom on 2016-08-02.
//  Copyright © 2016 Jeff Eom. All rights reserved.
//

import UIKit

struct NewsItem {
    enum Categories: String {
        case World = "World", Americas = "Americas", Europe = "Europe", MiddleEast = "Middle East", Africa = "Africa", AsiaPacific = "Asia Pacific"
        func Color() -> UIColor {
            switch self {
            case World:
                return UIColor.redColor()
            case Americas:
                return UIColor.blueColor()
            case Europe:
                return UIColor.greenColor()
            case MiddleEast:
                return UIColor.yellowColor()
            case Africa:
                return UIColor.orangeColor()
            case AsiaPacific:
                return UIColor.purpleColor()
            }
        }
    }
    
    var category: Categories?
    var headline: String?
}

