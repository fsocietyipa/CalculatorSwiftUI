//
//  MainViewModel.swift
//  CalculatorSwiftUI
//
//  Created by fsociety.1 on 1/9/20.
//  Copyright © 2020 fsociety.1. All rights reserved.
//

import Combine
import SwiftUI
import Expression


public class MainViewModel: ObservableObject {
    
    @Published var mainValue = String()
    @Published var resultValue = String()
    

    let newArr = [
        [
            ButtonParams.init(title: "AC", titleColor: .black, color: .lightGray, btnType: .clear),
            ButtonParams.init(title: "±", titleColor: .black, color: .lightGray, btnType: .plusMinus),
            ButtonParams.init(title: "%", titleColor: .black, color: .lightGray, btnType: .percent),
            ButtonParams.init(title: "/", color: .customOrange, btnType: .operation)
        ],
        [
            ButtonParams.init(title: "7"),
            ButtonParams.init(title: "8"),
            ButtonParams.init(title: "9"),
            ButtonParams.init(title: "*", color: .customOrange, btnType: .operation)
        ],
        [
            ButtonParams.init(title: "4"),
            ButtonParams.init(title: "5"),
            ButtonParams.init(title: "6"),
            ButtonParams.init(title: "-", color: .customOrange, btnType: .operation)
        ],
        [
            ButtonParams.init(title: "1"),
            ButtonParams.init(title: "2"),
            ButtonParams.init(title: "3"),
            ButtonParams.init(title: "+", color: .customOrange, btnType: .operation)
        ],
        [
            ButtonParams.init(title: "0", btnWidth: 138),
            ButtonParams.init(title: ".", btnType: .dot),
            ButtonParams.init(title: "=", color: .customOrange, btnType: .equal)
        ]
    ]
    
    var lastType = ButtonType.digit
    
    func buttonPressed(title: String, type: ButtonType) {
        switch type {
        case .digit:
            if lastType == .equal || lastType == .percent {
                mainValue = ""
                mainValue += title
            } else if lastType == .clear {
                mainValue = title
            } else {
                if mainValue == "0" && title == "0" {
                    
                } else {
                    mainValue += title
                    calculate()
                }
            }
            lastType = .digit
        case .clear:
            lastType = .clear
            mainValue  = "0"
            resultValue = ""
        case .equal:
            if resultValue != "" {
                lastType = .equal
                if resultValue.contains(".") {
                    if resultValue.split(separator: ".")[1] == "0" {
                        mainValue = String(resultValue.split(separator: ".")[0])
                    } else {
                        mainValue = resultValue
                    }
                } else {
                    mainValue = resultValue
                }
                resultValue = ""
            }
        case .operation:
            if lastType != .operation {
                lastType = .operation
                mainValue += title
            } else {
                mainValue = String(mainValue.dropLast())
                mainValue += title
            }
        case .plusMinus:
            lastType = .plusMinus
            if mainValue != "0" {
                if mainValue.first != "-" {
                    mainValue.insert("-", at: mainValue.startIndex)
                } else {
                    mainValue = String(mainValue.dropFirst())
                }
                calculate()
            }
        case .percent:
            lastType = .percent
            if resultValue == "" {
                if let doubleVal = Double(mainValue) {
                    mainValue = String(doubleVal/100)
                }
            }
        case .dot:
            if lastType == .equal || lastType == .percent {
                lastType = .dot
                mainValue = "0."
            } else {
                if !mainValue.contains(".") {
                    mainValue += "."
                }
            }
        }
 
  
    }
    
    func calculate() {
        let expression = Expression(mainValue)
          do {
              let result = try expression.evaluate()
            if let _ = Double(mainValue) {
            } else {
                if result == .infinity {
                    resultValue = "Error"
                } else {
                    resultValue = "\(result)"
                }
            }
            print(result)
          } catch (let err) {
              print(err.localizedDescription)
          }
    }
}
