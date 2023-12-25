//
//  OnboardingScreen.swift
//  Azer
//
//  Created by Gehad Eid on 20/11/2023.
//


import SwiftUI

struct OnboardingScreen: View {
    @State var finishOnboarding = false
    
    var body: some View {
            if !finishOnboarding {
                ZStack{
                    //Background
                    bgColor()
                    TabView{
                        OnboardingView(finishOnboarding: $finishOnboarding, imageName: "Understand", title: "Understand", description: "yourself on a deeper level")
                        
                        OnboardingView(finishOnboarding: $finishOnboarding, imageName: "Challenge", title: "Challenge", description: "yourself for a better you")
                        
                        OnboardingView(finishOnboarding: $finishOnboarding, imageName: "Protect", title: "Protect", description: "your inner peace", isFinal: true)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
    //                .onAppear {
    //                    setupAppearance()
    //                }
                }
            }
        else{
//            LoginScreen()
            MainTabbedView()
//            Wrapper()
        }
//        }
    }
}


//                              - Methods -

// Change the color of the current page indecator
//func setupAppearance() {
//      UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("filter&selected"))
//    }



// - Onboarding single View -
struct OnboardingView: View {
    @Binding var finishOnboarding: Bool
    
    let imageName : String
    let title : String
    let description : String
    var isFinal = false
    
    var body: some View {
        VStack (spacing: 20){
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300,height: 300)
//                .foregroundColor(.teal) // change color
            Text(title)
                .font(.title.bold())
                .foregroundColor(Color("BackgoundDecoration"))
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            if isFinal{
//                NavigationLink(destination: LoginScreen(), label:{
                    tcustomButton(title: "Get Started",color:"primaryButtonColor")
                    .onTapGesture {
                        finishOnboarding = true
                    }
                
//                })
            }
        }
        .padding(.horizontal,tdefaultPadding)
    }
}


#Preview {
    OnboardingScreen()
}
