//
//  SettingsScreen.swift
//  AZER
//
//  Created by Gehad Eid on 05/12/2023.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var email  = ""
    @State private var password  = ""
    @State private var username  = ""

//    @State var finishLogin = false

    var body: some View {
        //        NavigationStack {
//        if !finishLogin {
            ZStack{
                // Back ground color
                bgColor()
                
                // the waves in the bottom
                doubleWave()
                
                VStack(alignment: .center, spacing: 12){
//                    Spacer()
//                    Text("Welcome!")
//                        .font(.largeTitle)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                    Spacer()
                    
                    // Email
                    tcustomTextfeild(text: $email, placeholder: "bahaa.1@gamil.com", imageName: "envelope.fill")
                    
                    // Username
                    tcustomTextfeild(text: $username, placeholder: "Bahaa.1", imageName: "person.fill")
                    
                    // Password
                    tcustomTextfeild(text: $password, placeholder: "bahaa1234", imageName: "lock.fill", isSecure: true)
                    
//                    HStack {
//                        NavigationLink(
//                            destination: ForgotPasswordScreen(),
//                            label:{ Text("Forgot password?").underline().font(.footnote)
//                            })
//                        
//                        Spacer()
//                        
//                        NavigationLink(
//                            destination: SignUpScreen(),
//                            label:{ Text("Not a member?").underline().font(.footnote)
//                            })
//                    }
//                    
                    Spacer()
                    
                    // Button
                    tcustomButton(title: "Update", color: "primaryButtonColor")
//                        .onTapGesture {
//                            finishLogin = true
//                        }
//                    
                    
//                    // Or And Sign In With Apple Button
//                    customOrAndSignInWithAppleButton()
                    
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(tdefaultPadding)
            }
            .foregroundColor(.white)
//        }
//        else{
//            LoginScreen()
//        }
    }
}

#Preview {
    SettingsScreen()
}
