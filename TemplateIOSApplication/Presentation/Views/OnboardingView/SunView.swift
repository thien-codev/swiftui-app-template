//
//  SunView.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 14/11/2023.
//

import Foundation
import SwiftUI

struct SunView: View {
    var body: some View {
        Circle()
            .mask {
                Image("sun_img")
                    .resizable()
            }
            .overlay {
                Image("sun_img")
                    .resizable()
                    .shadow(radius: 0, x: 8, y: 8)
                    .overlay {
                        Image(systemName: "arrowtriangle.right.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundColor(.orange)
                            .offset(x: 4)
                    }
            }
    }
}

#Preview {
    SunView()
}
