//
//  AlliesScreen.swift
//  Azer
//
//  Created by Gehad Eid on 29/11/2023.
//

import SwiftUI

struct AlliesScreen: View {
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading, spacing: 20) {
                
                topBar(height: 260)
                
                // Friends
                friends()
                
                // Rooms
                currentRooms(title: "Ongoing group challenges")
//                    .foregroundColor(Color("sublinesColor"))
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    AlliesScreen()
}

