//
//  Wrapper.swift
//  AZER
//
//  Created by Gehad Eid on 05/12/2023.
//

import SwiftUI

struct Wrapper: View {
    @EnvironmentObject var userModel : UserModel
    
    var body: some View {
        if userModel.authenticated {
            MainTabbedView()
        }
        else{
            LoginScreen()
        }
    }
}

#Preview {
    Wrapper()
}
