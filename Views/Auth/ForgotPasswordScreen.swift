////
////  ForgotPasswordScreen.swift
////  Azer
////
////  Created by Gehad Eid on 29/11/2023.
////
//
//import SwiftUI
//
//struct ForgotPasswordScreen: View {
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        Text("yo, Forgot Password Screen!")
//        Button{
//            dismiss()
//        }
//    label:{
//        HStack {
//            Text("Already a member?")
//            Text("Log in").underline()
//        }
//        .frame(maxWidth: .infinity, alignment: .center)
//    }
//    }
//}
//
//#Preview {
//    ForgotPasswordScreen()
//}




//
//  ForgotPasswordScreen.swift
//  AZER
//
//  Created by jumanah khalid albisher on 22/05/1445 AH.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @State private var email = ""
    @State private var isEmailSent = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            // Back ground color
            bgColor()
            
            // the waves in the bottom
            doubleWave()
            VStack {
                if isEmailSent {
                    Text("Password reset email has been sent.")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                } else {
                    Text("Forgot Password")
                        .font(.title)
                        .padding()
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button{
//                        userModel.authenticate(username: username, password: password)
                        dismiss()
                    }
                label: {
                        tcustomButton(title: "Reset Password", color: "primaryButtonColor")
                    }
                    .disabled(email.isEmpty)
                    .padding()
                }
            }
            //        .navigationBarTitle("Forgot Password", displayMode: .inline)
            .padding()
        }
    }
    
    private func sendResetPasswordEmail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isEmailSent = true
        }
    }
}

struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen()
    }
}

#Preview {
    ForgotPasswordScreen()
}
