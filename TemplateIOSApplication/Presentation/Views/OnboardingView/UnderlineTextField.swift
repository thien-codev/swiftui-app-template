//
//  UnderlineTextField.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 12/11/2023.
//

import Foundation
import SwiftUI

struct UnderlineTextField: View {
    
    @Binding var text: String
    @Binding var focus: Bool
    @Binding var placeholderColor: Color
    
    var body: some View {
        GeometryReader { view in
            VStack(alignment: .leading, spacing: 2) {
                TextField("", text: $text) { focus in
                    self.focus = focus
                }
                .placeHolder(when: text.isEmpty, placeholder: {
                    Text("Display name")
                        .foregroundColor(placeholderColor)
                })
                .foregroundColor(.gray)
                .accentColor(.gray)
                .font(Font.bold(Font.system(size: 30))())
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: focus || !text.isEmpty ? view.size.width : 100 ,height: 4)
                    .foregroundColor(.gray)
            }
        }
        .animation(.easeInOut, value: focus)
    }
}

#Preview {
    UnderlineTextField(text: .constant(""), focus: .constant(true), placeholderColor: .constant(.gray))
}
