//
//  AccountView.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 15/11/2023.
//

import Foundation
import SwiftUI

struct AccountView: View {
    
    @Binding var isShowing: Bool
    @State var width: CGFloat
    @State var onLogout: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(lineWidth: 3)
            .frame(width: width, height: isShowing ? 100 : 0)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: width, height: isShowing ? 100 : 0)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 0, x: 8, y: 8)
            }
            .overlay(content: {
                VStack(spacing: 10) {
                    Button {
                        isShowing.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundColor(.black)
                    }
                    
                    Rectangle()
                        .frame(height: isShowing ? 2 : 0)
                        .padding([.leading, .trailing], 4)
                    
                    Button {
                        onLogout()
                    } label: {
                        Image(systemName: "square.and.arrow.up.on.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundColor(.black)
                    }
                }
                .frame(width: width, height: isShowing ? 100 : 0)
            })
            .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    AccountView(isShowing: .constant(true), width: 50, onLogout: { })
}
