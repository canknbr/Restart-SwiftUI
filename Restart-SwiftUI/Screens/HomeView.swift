//
//  HomeView.swift
//  Restart-SwiftUI
//
//  Created by Can Kanbur on 27.05.2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingActive: Bool = false
    var body: some View {
        VStack {
            Text("home")
            Button {
                isOnboardingActive = true
            } label: {
                Text("Restart")
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
