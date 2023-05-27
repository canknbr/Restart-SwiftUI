//
//  OnBoardingView.swift
//  Restart-SwiftUI
//
//  Created by Can Kanbur on 27.05.2023.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    var body: some View {
        VStack {
            Text("onboarding")
            Button {
                isOnboardingActive = false
            } label: {
                Text("Start")
            }

        }
    
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
