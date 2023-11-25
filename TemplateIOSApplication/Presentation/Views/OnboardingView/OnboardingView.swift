//
//  OnboardingView.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 12/11/2023.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var vm: AnimalsViewVM
    
    @State var isAnimated: Bool = false
    @State var displayName: String = ""
    @State var sunTapped: Bool = false
    @State var favoriteScale: CGFloat = 1
    @State var textfieldFocus: Bool = false
    @State var placeholderColor: Color = .gray.opacity(0.5)
    
    var body: some View {
        ZStack(alignment: .center) {
            SunView()
                .frame(width: 120)
                .onTapGesture {
                    favoriteScale = 1.3
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        favoriteScale = 1
                    }
                    
                    if !displayName.isEmpty {
                        hideKeyboard()
                        sunTapped = true
                        placeholderColor = .gray.opacity(0.5)
                    } else {
                        placeholderColor = .red.opacity(0.85)
                    }
                }
                .scaleEffect(favoriteScale)
                .offset(x: UIScreen.width / 4, y: -UIScreen.height * 2 / 5)
                .animation(.easeInOut, value: favoriteScale)
            
            wave(heightWave: 80,
                 deepWave: 80)
                .foregroundColor(.blue.opacity(0.8))
                .offset(x: isAnimated ? -UIScreen.width : 0,
                        y: 0)
                .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: isAnimated)
            
            wave(baseline: UIScreen.height / 2 - 40,
                 heightWave: 100,
                 deepWave: 100)
                .foregroundColor(.blue.opacity(0.2))
                .offset(x: isAnimated ? -UIScreen.width : 0,
                        y: 0)
                .animation(.linear(duration: 10).repeatForever(autoreverses: false), value: isAnimated)
                .scaleEffect(1.5)
            
            wave(baseline: UIScreen.height / 2 - 20,
                 heightWave: 120,
                 deepWave: 120)
                .foregroundColor(.blue.opacity(0.6))
                .offset(x: isAnimated ? -UIScreen.width : 0,
                        y: 0)
                .animation(.linear(duration: 6).repeatForever(autoreverses: false), value: isAnimated)
                .scaleEffect(1.2)
            
            
            HStack(alignment: .top) {
                Text("Welcome")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                UnderlineTextField(text: $displayName, 
                                   focus: $textfieldFocus,
                                   placeholderColor: $placeholderColor)
            }
            .padding()
            .padding(.top, 100)
            .offset(x: !textfieldFocus && !displayName.isEmpty ? 0 : -146)
            .animation(.easeInOut, value: textfieldFocus)
            
            AnimalsView(vm: _vm, onLogout: {
                displayName = .init()
                sunTapped = false
            })
                .offset(y: sunTapped ? 0 : 900)
                .animation(.easeInOut, value: sunTapped)
            
        }
        .onAppear(perform: {
            isAnimated = true
        })
    }
    
    func wave(baseline: CGFloat = UIScreen.height / 2,
              amplitude: CGFloat = UIScreen.width * 2 / 5,
              heightWave: CGFloat = 100,
              deepWave: CGFloat = 140) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: baseline))
            path.addCurve(to: CGPoint(x: UIScreen.width, y: baseline),
                          control1: CGPoint(x: amplitude,
                                            y: baseline - heightWave),
                          control2: CGPoint(x: UIScreen.width * 5 / 7,
                                            y: baseline + deepWave))
            
            path.addCurve(to: CGPoint(x: 2 * UIScreen.width,
                                      y: baseline),
                          control1: CGPoint(x: amplitude + UIScreen.width,
                                            y: baseline - heightWave),
                          control2: CGPoint(x: UIScreen.width * 12 / 7,
                                            y: baseline + deepWave))
            
            path.addLine(to: CGPoint(x: 2 * UIScreen.width,
                                     y: UIScreen.height))
            path.addLine(to: CGPoint(x: 0,
                                     y: UIScreen.height))
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
