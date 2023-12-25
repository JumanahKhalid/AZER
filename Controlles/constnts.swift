//
//  constnts.swift
//  Azer
//
//  Created by Gehad Eid on 20/11/2023.
//

import Foundation
import SwiftUI

//                      - Consts -
let tdefaultPadding : CGFloat = 20
let tcornerRadius : CGFloat = 12
let tbuttonHight : CGFloat = 50



//                      - Style -

// Wave Gradient color for splash, login and onboarding screens
let wgColor = LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(red: 0.95, green: 0.81, blue: 0.73).opacity(0.8), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.95, green: 0.43, blue: 0.47).opacity(0.8), location: 1.00),
                ]),
                startPoint: UnitPoint(x: 0.5, y: 1.04),
                endPoint: UnitPoint(x: 0.5, y: 0.11)
            )



// Background Gradient color for login and onboarding screens
struct bgColor: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.62, green: 0.81, blue: 0.76), location: 0.00),
                Gradient.Stop(color: Color(red: 0, green: 0.13, blue: 0.19), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 1.19),
            endPoint: UnitPoint(x: 0.5, y: 0.15)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

// Custom tab item modifier
extension MainTabbedView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        VStack(spacing: 10){
//            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? Color("primaryButtonColor") : .black)
                .frame(width: 20, height: 20)
//            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? Color("primaryButtonColor") : .black)
//            }
//            Spacer()
        }
        .frame(width: 60, height: 60)
//        .frame(width: 60, height: 60) //isActive ? .infinity :
//        .background(Color("primaryButtonColor").opacity(0.4) /*: .clear*/) //isActive ?
//        .cornerRadius(30) //tcornerRadius
    }
}
