//
//  RoomScreen.swift
//  AZER
//
//  Created by Gehad Eid on 05/12/2023.
//

import SwiftUI

struct RoomScreen: View {
    @Binding var room: Room?
    
    var body: some View {
        VStack {
            Text("Room Details")
                .font(.title)
                .padding()
            
            // Display room details
            Text("Name: \(room!.name)")
                .padding()
            
            Text("Description: \(room!.description)")
                .padding()
            
            // You can add more room details here as needed
            
            Spacer()
        }
    }
}



//#Preview {
//    RoomScreen(room: Room(name: "test", description: "test test", people: [], challenge: "challenge"))
//}
