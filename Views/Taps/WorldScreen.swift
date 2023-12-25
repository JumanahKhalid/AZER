//
//  WorldScreen.swift
//  Azer
//
//  Created by Gehad Eid on 20/11/2023.
//

import SwiftUI

struct WorldScreen: View {
    @State private var showLoginAlert = false
    @State private var selectedChallenge: Int?
    @State private var isSheetPresented = false
    @State private var isLoginSheetPresented = false

    @State private var selectedRoom: Room?
    
    @EnvironmentObject var userModel : UserModel
    
    let challenges = [
        "Take a 10 minutes walk",
        "Sing out loud",
        "Meditate on candlelight",
        "Hug the nearest person around",
        "Pet a stray animal"
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView (showsIndicators: false) {
                ZStack(alignment: .top) {
                    topBar(height: 260)
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack (alignment: .leading, spacing: 0) {
                        if userModel.authenticated {
                            
                            // Moods
                            VStack {
                                Rectangle()
                                    .frame(height: 190)
                                    .opacity(0)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(0..<5) { index in
                                            Image("Mood\(index)")
                                                .resizable()
                                                .foregroundStyle(.white)
                                                .font(.largeTitle)
                                                .frame(width: 90, height: 90)
                                                .onTapGesture {
                                                    isSheetPresented.toggle()
                                                    selectedChallenge = index
                                                }
                                                .sheet(isPresented: $isSheetPresented){
                                                    Challenge(image: "challenge\(selectedChallenge ?? 0)", challenge: challenges[selectedChallenge ?? 0])
                                                }
                                        }
                                    }
                                }
                                .padding(.horizontal, tdefaultPadding - 10)
                            }
                            
                            // 21 days challenge
                            cardWithTitle(
                                title: "21 days challenge", height: 70,
                                content: {
                                    VStack(alignment: .leading , spacing: -5) {
                                        if let days = userModel.getCurrentUserDays() {
                                            ProgressBar(height: 20, padding: 10, completedDays: days )
                                            
                                            Text("Day \(days) / 21")
                                                .font(.footnote)
                                                .padding(.horizontal, 12)
                                                .foregroundColor(.gray)
                                        } else {
                                            ProgressBar(height: 20, padding: 20, completedDays: 0 )
                                            
                                            // A default value if days is nil
                                            Text("Day N/A / 21")
                                                .font(.footnote)
                                                .padding(.horizontal, 12)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            )
                            
                            // Mood tracker
                            cardWithTitle(
                                title: "Mood tracker", height: 120,
                                content: {
                                    VStack{
                                        Spacer()
                                        Text("Past 6 days")
                                            .font(.footnote)
                                            .padding(.bottom,10)
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 12) {
                                                ForEach(userModel.getLastSixElementsOfCurrentUserArray().suffix(6), id: \.self) { mood in
                                                    Image("Mood\(mood)")
                                                        .resizable()
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        .frame(width: 60, height: 60)
                                                }
                                            }
                                            .padding(.horizontal, tdefaultPadding - 10)
                                        }
                                        Spacer()
                                        Spacer()
                                    }
                                }
                            )
                            
                            // Rooms
                            currentRooms(title: "Allies are up to")
                            
                            //
//                            VStack(alignment: .leading, spacing: 10) {
//                                Text("Allies are up to")
//                                    .padding(.horizontal, tdefaultPadding)
//                                    .padding(.top, tdefaultPadding)
//                                    .font(.title2)
//                                
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: 12) {
//                                        ForEach(userModel.users[userModel.currentUserIndex].rooms, id: \.self) { room in
//                                            ZStack {
//                                                RoundedRectangle(cornerRadius: tcornerRadius)
//                                                    .fill(Color("roomCardColor"))
//                                                    .frame(width: 150, height: 210)
//                                                
//                                                VStack(alignment: .leading) {
//                                                    Spacer()
//                                                    Image("room\(Int.random(in: 0..<3))")
//                                                        .resizable()
//                                                        .frame(maxWidth: 120, maxHeight: 100)
//                                                    
//                                                    Spacer()
//                                                    
//                                                    Text(room.name)
//                                                        .font(.title3)
//                                                        .foregroundColor(.white)
//                                                    
//                                                    Text(room.description)
//                                                        .font(.footnote)
//                                                        .foregroundColor(.white)
//                                                    
//                                                    Spacer()
//                                                }
//                                            }
//                                            .onTapGesture {
//                                                selectedRoom = room
//                                                isSheetPresented.toggle()
//                                            }
//                                            .sheet(isPresented: $isSheetPresented){
//                                                RoomScreen(room: $selectedRoom)
//                                            }
//                                        }
//                                    }
//                                    .padding(.horizontal, tdefaultPadding)
//                                }
//                            }
                        }
                        
                        // MARK: Not Logged in
                        else {
                            //Moods
                            ScrollableMoodSelection()
                                .onTapGesture(perform: {
                                    showLoginAlert = true
                                })
                                .alert(isPresented: $showLoginAlert) {
                                    Alert(
                                        title: Text("Login Required"),
                                        message: Text("Please log in to access this content."),
                                        primaryButton: .default(Text("Log In"), action: {
                                            isLoginSheetPresented.toggle()
                                        }),
                                        secondaryButton: .cancel()
                                    )
                                }
                                .sheet(isPresented: $isLoginSheetPresented){
                                    LoginScreen()
                                }
                            
                            // 21 days challenge
                            cardWithTitle(
                                title: "21 days challenge", height: 70,
                                content: {
                                    VStack(alignment: .leading , spacing: -5) {
                                        //                                    progressBar(height: 20, width: 10, padding: 10)
                                        ProgressBar(height: 20, padding: 10, completedDays: 0 )
                                        
                                        Text("Sign in to start your journey")
                                            .font(.footnote)
                                            .padding(.horizontal,10)
                                            .foregroundColor(.gray)
                                        
                                    }
                                }
                            )
                            
                            // Mood tracker
                            cardWithTitle(
                                title: "Mood tracker", height: 100,
                                content: {
                                    VStack{
                                        Spacer()
                                        Text("Past 6 days")
                                            .font(.footnote)
                                            .padding(.bottom,10)
                                            .foregroundColor(.gray)
                                        
                                        Spacer()
                                        
                                        Text("No entry yet, sign up to track your mood ")
                                            .font(.footnote)
                                            .padding(.horizontal,10)
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                }
                            )
                            
                            // Rooms
                            cardWithTitle(
                                title: "Allies are up to", height: 100,
                                content: {
                                    Text("Sign up and add friends to enjoy group challenges")
                                        .font(.footnote)
                                        .padding(.horizontal,10)
                                        .foregroundColor(.gray)
                                }
                            )
                        }
                    }
                    //
                }
            }
        }
    }
}

//#Preview {
//    WorldScreen(selectedRoom: Room(name: "test", description: "test test", people: ["ppl 1","ppl2"], challenge: "challenge"))
//}
