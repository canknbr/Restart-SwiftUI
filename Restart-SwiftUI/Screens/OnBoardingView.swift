//
//  OnBoardingView.swift
//  Restart-SwiftUI
//
//  Created by Can Kanbur on 27.05.2023.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var imageOffset: CGSize = .zero
    @State private var isAnimated = false
    @State private var indicatorOpacity : Double = 1.0
    @State private var title : String = "Share."
    
    let feedback =  UINotificationFeedbackGenerator()
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                // MARK: Header

                Spacer()

                VStack(spacing: 0) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .transition(.opacity)
                        .id(title)
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                } // Header
                .opacity(isAnimated ? 1 : 0)
                .offset(y: isAnimated ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimated)

                // MARK: Center

                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimated ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimated)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width  / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            title = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        title = "Share."
                                    }
                                })
                        ).animation(.easeOut(duration: 1), value: imageOffset)
                } // Center
                .overlay(
                
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44,weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y : 20)
                    .opacity(isAnimated ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimated)
                    .opacity(indicatorOpacity)
                ,alignment: .bottom
                )

                Spacer()

                // MARK: Footer

                ZStack {
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2)).padding(8)
                    Text("Get Started")
                        .foregroundColor(.white)
                        .font(.system(.title3, design: .rounded, weight: .bold))
                        .offset(x: 20)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)

                        Spacer()
                    }

                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.2)).padding(8)
                            Image(systemName: "chevron.right.2").font(.system(size: 24, weight: .bold))
                        }
                        .frame(width: 80, height: 80, alignment: .center)
                        .foregroundColor(.white)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffset < buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in

                                    withAnimation(Animation.easeIn(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            feedback.notificationOccurred(.success)
                                            playSound(soundName: "chimeup", soundType: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingActive = false
                                        
                                        } else {
                                            feedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                })
                        )
                        Spacer()
                    } // hstack

                }.frame(width: buttonWidth, height: 80)
                    .padding()
                    .opacity(isAnimated ? 1 : 0)
                    .offset(y: isAnimated ? 0 : 40)
                    .animation(.easeOut(duration: 1), value: isAnimated)
                // footer
            } // VSTACK
        } // ZSTACK
        .onAppear {
            isAnimated = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
