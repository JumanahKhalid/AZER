//
//  SignUpScreen.swift
//  Azer
//
//  Created by Gehad Eid on 29/11/2023.
//

import SwiftUI

struct SignUpScreen: View {
//    @State private var email  = ""
    @State private var username  = ""
    @State private var password  = ""
    @State private var confirmPassword  = ""
    
    @EnvironmentObject var userModel : UserModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack{
                // Back ground color
                bgColor()
                // the waves in the bottom
                doubleWave()
                
                VStack(alignment: .leading, spacing: 12){
                    
                    Spacer()
                    
                    // Email
//                    tcustomTextfeild(text: $email, placeholder: "Enter your email", imageName: "envelope.fill")
                    
                    // Username
                    tcustomTextfeild(text: $username, placeholder: "Enter username", imageName: "person.fill")
                    
                    // Password
                    tcustomTextfeild(text: $password, placeholder: "Enter your password", imageName: "lock.fill", isSecure: true)
                    
                    // Stingth par
                    //https://www.youtube.com/watch?v=jyOnBUxglcA (later on babe)
                    
                    // Confirm password
                    tcustomTextfeild(text: $confirmPassword, placeholder: "Confirm your password", imageName: "lock.fill", isSecure: true)
                    
                    // Button
                    
//                    NavigationLink(
//                        destination: MainTabbedView(loged: true),
                    Button{
                        userModel.addUser(username: username, password: password)
                        dismiss()
                    }
                        label:{ tcustomButton(title: "Sign Up", color: "primaryButtonColor")
                            
                        }
//                    )
                    .navigationBarHidden(true)
                    
                    // Or And Sign In With Apple Button
                    customOrAndSignInWithAppleButton()
                    
                    Spacer()
                    
                    Button{
                        dismiss()
                    }
                label:{
                    HStack {
                        Text("Already a member?")
                        //                        NavigationLink(
                        //                            destination: LoginScreen(),
                        //                            label:{
                        Text("Log in").underline()
                        //                        })
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(tdefaultPadding)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    SignUpScreen()
}
