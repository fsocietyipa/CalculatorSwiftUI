//
//  ButtonParams.swift
//  CalculatorSwiftUI
//
//  Created by fsociety.1 on 1/9/20.
//  Copyright © 2020 fsociety.1. All rights reserved.
//

import SwiftUI

struct ButtonParams: Hashable {
    var title: String
    var titleColor: Color
    var color: Color
    var btnHeight: CGFloat
    var btnWidth: CGFloat
    var btnType: ButtonType
    
    init(title: String, titleColor: Color = Color.white, color: Color = .customDarkGray , btnHeight: CGFloat = 60, btnWidth: CGFloat = 60, btnType: ButtonType = .digit) {
        self.title = title
        self.titleColor = titleColor
        self.color = color
        self.btnHeight = btnHeight
        self.btnWidth = btnWidth
        self.btnType = btnType
    }
}
