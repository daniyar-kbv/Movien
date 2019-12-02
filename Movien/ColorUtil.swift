//
//  ColorUtil.swift
//  Movien
//
//  Created by Nursultan Ayazov on 12/2/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import Foundation
import UIKit

let colorPrimary: UIColor = UIColorFromHex(rgbValue: 0x383B4A)
let colorSecondary: UIColor = UIColorFromHex(rgbValue: 0x9392B2)
let colorAccentRed: UIColor = UIColorFromHex(rgbValue: 0xA65159)
let colorAccentYellow: UIColor = UIColorFromHex(rgbValue: 0xE0B453)

private func UIColorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8) / 256.0
    let blue = CGFloat(rgbValue & 0xFF) / 256.0
    return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
}
