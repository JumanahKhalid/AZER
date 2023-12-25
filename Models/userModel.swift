//
//  userModel.swift
//  AZER
//
//  Created by Gehad Eid on 05/12/2023.

import SwiftUI
import Foundation

//struct Room: Codable, Hashable {
//    var name: String
//    var description: String
//    var people: [String]
//    var challenge: String
//    var time: TimeInterval
//
//    private var timer: Timer?
//
//    mutating func startTimer() {
//        guard timer == nil else {
//            return // Timer already running
//        }
//
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak room = self] timer in
//            guard let room = room else {
//                timer.invalidate()
//                return
//            }
//
//            if room.time <= 0 {
//                timer.invalidate()
//            } else {
//                // Access the local variable 'room' to modify 'time'
//                var updatedRoom = room
//                updatedRoom.time -= 1
//                self = updatedRoom
//            }
//        }
//    }
//
//    mutating func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    func remainingTime() -> TimeInterval {
//        return time
//    }
//}


struct Room: Codable, Hashable {
    var name: String
    var description: String
    var people: [String]
    var challenge: String
}

struct User: Codable, Identifiable {
    var id = UUID()
    var username: String
    var password: String
    var days: Int
    var moods: [Int]
    var rooms: [Room]
    var friends: [String]
    var timeRemaining: Int
}

class UserModel: ObservableObject {
    @AppStorage("currentUserIndex") var currentUserIndex = 0
    @AppStorage("AUTH_KEY") var authenticated = false {
            willSet { objectWillChange.send() }
        }
    @AppStorage("users") var usersData: Data?
    @Published var users: [User] = [] {
        didSet {
            saveUsers()
        }
    }

    init() {
        loadUsers()
        if users.isEmpty {
            let sampleUser = User(
                username: "SampleUser",
                password: "password",
                days: 11,
                moods: [1, 2, 3, 4, 5, 0, 4],
                rooms: [
                    Room(name: "Room1", description: "Room 1 Description", people: [], challenge: "Challenge 1"),
                    Room(name: "Room2", description: "Room 2 Description", people: [], challenge: "Challenge 2")
                ],
                friends: ["Friend1", "Friend2"],
                timeRemaining: 5 * 60
            )
            users.append(sampleUser)
        }
        
        print("Loaded users: \(users)")
        print("Users count: \(users.count)")
    }

    func saveUsers() {
        do {
            let encoder = JSONEncoder()
            let encodedUsers = try encoder.encode(users)
            usersData = encodedUsers
        } catch {
            print("Error encoding users data: \(error)")
        }
    }

    func loadUsers() {
        guard let data = usersData else { return }
        do {
            let decoder = JSONDecoder()
            let decodedUsers = try decoder.decode([User].self, from: data)
            users = decodedUsers
        } catch {
            print("Error decoding users data: \(error)")
        }
    }

    func addUser(username: String, password: String) {
        let newUser = User(username: username, password: password, days: 0, moods: [], rooms: [], friends: [], timeRemaining: 1000)
        users.append(newUser)
    }
    
    func authenticate(username: String, password: String) {
        guard let user = users.first(where: { $0.username.lowercased() == username.lowercased() }) else {
            print("Invalid username")
            return
        }
        
        if password == user.password {
            if let index = users.firstIndex(where: { $0.username.lowercased() == username.lowercased() }) {
                currentUserIndex = index
                authenticated = true
            }
        } else {
            print("Invalid password")
            return
        }
    }
    
    
    // Function to get the username of the current user
    func getCurrentUsername() -> String? {
        guard currentUserIndex >= 0, currentUserIndex < users.count else {
            // Return nil if the current user index is out of bounds
            return nil
        }
        
        let currentUsername = users[currentUserIndex].username
        return currentUsername
    }
    
    // Function to get the last 6 elements of the userArray of the current user
    func getLastSixElementsOfCurrentUserArray() -> [Int] {
        guard currentUserIndex >= 0, currentUserIndex < users.count else {
            // Return an empty array if the current user index is out of bounds
            return []
        }
        
        let currentArray = users[currentUserIndex].moods
        
        if currentArray.count >= 6 {
            // Return the last 6 elements if available
            return Array(currentArray.suffix(6))
        } else {
            // Return all elements if there are less than 6
            return currentArray
        }
    }
    
    // Function to get the days of the current user
    func getCurrentUserDays() -> Int? {
        guard currentUserIndex >= 0, currentUserIndex < users.count else {
            // Return nil if the current user index is out of bounds
            return nil
        }
        
        let currentUserDays = users[currentUserIndex].days
        return currentUserDays
    }
    
    // Function to get the remaining time of the current user
    func getCurrentUserRemainingTime() -> Int? {
        guard currentUserIndex >= 0, currentUserIndex < users.count else {
            // Return nil if the current user index is out of bounds
            return nil
        }
        
        let remainingTime = users[currentUserIndex].timeRemaining
        return remainingTime
    }
    
    // Function to set the remaining time for the current user
    func setCurrentUserRemainingTime(time: Int) {
        guard currentUserIndex >= 0, currentUserIndex < users.count else {
            // Return if the current user index is out of bounds
            return
        }
        
        users[currentUserIndex].timeRemaining = time
        saveUsers() // Save the updated users array to UserDefaults after setting the time
    }


    func logOut() {
        authenticated = false
    }
}
