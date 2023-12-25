//
//  MyMapScreen.swift
//  Azer
//
//  Created by Gehad Eid on 29/11/2023.
//

import SwiftUI

struct MyMapScreen: View {
    @EnvironmentObject var userModel : UserModel
    
    @State private var isLoginSheetPresented = false

    var body: some View {
        
            ScrollView (showsIndicators: false) {
                
                    ZStack (alignment: .top){
                        VStack {
                            Rectangle()
                                .frame(height: 160) //width: .infinity,
                                .opacity(0)
                            
                            Image("Map")
                                .resizable()
                                .frame(maxWidth: .infinity,maxHeight:800)
                        }
                        
                        ZStack {
                            Rectangle()
                                .fill(Color("BackgoundDecoration"))
                                .frame( height: 170) //width: .infinity,
                            
                            HStack{
                                Image("Logo")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                                
                                Spacer()
                                
                                VStack(alignment: .leading) {
                                    if userModel.authenticated {
                                        if let username = userModel.getCurrentUsername() {
                                            Text("Hi \(username)!")
                                                .font(.title)
                                                .foregroundColor(Color("HeadlineColor"))
                                        }
                                        else {
                                            Text("Hi there!")
                                                .font(.title)
                                                .foregroundColor(Color("HeadlineColor"))
                                        }
                                    }else {
                                        Text("Hi there!")
                                            .font(.title)
                                            .foregroundColor(Color("HeadlineColor"))
                                    }
                                }
                                
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                if userModel.authenticated {
                                    Button{
                                        userModel.logOut()
                                    }
                                label:{
                                    
                                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                        .foregroundColor(.black)
                                }
                                    
                                }
                                else{
                                    Button{
                                        isLoginSheetPresented.toggle()
                                    }
                                label:{
                                    Image(systemName: "person.badge.key.fill")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                        .foregroundColor(.black)
                                }
                                .sheet(isPresented: $isLoginSheetPresented){
                                    LoginScreen()
                                }
                                }
                            }
                            .padding(tdefaultPadding)
                        }
                        .edgesIgnoringSafeArea(.top)
                    }
                
            }
            .edgesIgnoringSafeArea(.top)
        
    }
}

#Preview {
    MyMapScreen()
}
