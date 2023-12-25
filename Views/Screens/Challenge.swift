//
//  Challenge.swift
//  AZER
//
//  Created by Gehad Eid on 01/12/2023.
//

import SwiftUI

struct Challenge: View {
    let image : String
    let challenge : String
    
    @State var timer = false
    @State var passed = false
    @State var showLoginAlert = false
    
    @EnvironmentObject var userModel : UserModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                // Background decoration
                UnevenRoundedRectangle(
                    cornerRadii: .init(bottomLeading: 120,
                                       bottomTrailing: 120)
                )
                .fill(Color("BackgoundDecoration"))
                .frame(height: 550) // width
                
                // The challenge
                VStack {
                    Image(passed ? "passed" : image)
                        .resizable()
                        .frame( maxWidth: 200,maxHeight: 300)
                        .padding(.bottom, tdefaultPadding)
                    
                    if !passed{
                        Text(challenge)
                            .bold()
                            .font(.title2)
                            .foregroundColor(Color("challengeTextColor"))
                    }
                }
            }
            
            Spacer()
            
            // Buttons
            if !timer && userModel.getCurrentUserRemainingTime()! > 600{
                HStack (spacing: 24) {
                    tcustomButton(title: "Pass", color: "primaryTextColor")
                        .overlay(RoundedRectangle(cornerRadius: tcornerRadius)
                            .stroke(.black, lineWidth: 1.5))
                        .onTapGesture {
                            showLoginAlert.toggle()
                        }
                        .alert(isPresented: $showLoginAlert) {
                            Alert(
                                title: Text("Pass the challagnge?"),
                                message: Text("Are you sure you want to pass? you'll lose today's points"),
                                primaryButton: .default(Text("Pass"), action: {
                                    dismiss()
                                }),
                                secondaryButton: .cancel()
                            )
                        }
                    
                    Spacer()
                    
                    tcustomButton(title: "Start Timer", color: "primaryButtonColor")
                        .foregroundColor(.white)
                        .onTapGesture {
                            timer = true
                        }
                }
                .padding(tdefaultPadding)
            }
            else if passed{
                Text("You Passed!")
                    .bold()
                    .font(.title2)
            }
            else{
                TimerView(passed: $passed, timeRemaining: userModel.getCurrentUserRemainingTime()! < 600 ? userModel.getCurrentUserRemainingTime()! : 10 * 60)
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .ignoresSafeArea()
    }
}

#Preview {
    Challenge(image: "", challenge: "")
}



struct TimerView: View {
    @Binding var passed: Bool
    @State var timeRemaining: Int
    
    @EnvironmentObject var userModel: UserModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(timeString(time: timeRemaining))")
            .font(.system(size: 60))
            .frame(height: 80.0)
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.black)
            .onReceive(timer) { _ in
                if self.timeRemaining > userModel.getCurrentUserRemainingTime() ?? 0 {
                    self.timeRemaining = userModel.getCurrentUserRemainingTime() ?? 0
                } else if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    userModel.setCurrentUserRemainingTime(time: self.timeRemaining)
                } else {
                    self.timer.upstream.connect().cancel()
                    passed = true
                }
            }
    }

    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
