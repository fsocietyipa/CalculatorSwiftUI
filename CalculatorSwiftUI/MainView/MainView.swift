//
//  MainView.swift
//  CalculatorSwiftUI
//
//  Created by fsociety.1 on 1/9/20.
//  Copyright © 2020 fsociety.1. All rights reserved.
//

import SwiftUI
import UIKit
struct MainView: View {
    @ObservedObject var vm = MainViewModel()

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(vm.mainValue)
                    .font(Font.system(size: 60))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.trailing)
            }
//            Text(vm.resultValue)
            ForEach(vm.newArr, id: \.self) { (stringArr) in
                HStack {
                    ForEach(stringArr, id: \.self) { key in
                        Button(action: {self.vm.buttonPressed(title: key.title, type: key.btnType)}) {
                            Text(key.title)
                                .frame(width: key.btnWidth, height: 60)
                                .background(key.color)
                                .cornerRadius(30)
                                .foregroundColor(key.titleColor)
                                .font(Font.system(size: 25).bold())
                                .padding(.all, 5)
                        }
                    }

                }
            }
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
