//
//  MainTabbedView.swift
//  Azer
//
//  Created by Gehad Eid on 29/11/2023.
//


import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case world = 0
    case allies
    case map
    
    var title: String{
        switch self {
        case .world:
            return "World"
        case .allies:
            return "Allies"
        case .map:
            return "My Map"
        }
    }
    
    var iconName: String{
        switch self {
        case .world:
            return "wordIcon"
        case .allies:
            return "alliesIcon"
        case .map:
            return "mapIcon"
        }
    }
}

struct MainTabbedView: View {
    @State var selectedTab = 0
    
    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                WorldScreen()
                    .tag(0)
                
                AlliesScreen()
                    .tag(1)
                
                MyMapScreen()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                // To stop the swipe effect between pages
                UIScrollView.appearance().isScrollEnabled = false
            }
            
            ZStack(alignment: .bottom){
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Spacer()
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(.white)
                .cornerRadius(30) 
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 0)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainTabbedView()
}
