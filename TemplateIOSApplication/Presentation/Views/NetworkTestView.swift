//
//  NetworkTestView.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation
import SwiftUI
import UIKit

struct NetworkTestView: View {
    
    @EnvironmentObject var vm: NetworkTestVM
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .teal]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 200)
                .padding([.leading, .trailing], 40)
                .overlay {
                    Text("")
                }
                .shadow(radius: 0, x: 10, y: 10)
        }
    }
    
//    var body: some View {
//        NavigationView {
//            ScrollView(showsIndicators: false) {
//                ForEach(vm.animals, id: \.id) { item in
//                    NavigationLink {
//                        DetailView(model: item)
//                    } label: {
//                        RoundedRectangle(cornerRadius: 12)
//                            .frame(height: 200)
//                            .overlay {
//                                HStack(spacing: 10) {
//                                    AsyncImage(url: URL(string: item.url), scale: 2)
//                                        .frame(width: UIScreen.width * 3 / 7, height: 200)
//                                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                                    VStack(alignment: .leading) {
//                                        Text("\(item.id)")
//                                            .font(.title)
//                                            .fontWeight(.bold)
//                                            .foregroundColor(.black)
//                                        Text("\(item.height) \(item.width)")
//                                            .font(.subheadline)
//                                            .fontWeight(.bold)
//                                            .foregroundColor(.black)
//                                        Spacer()
//                                    }
//                                    .padding(.top, 10)
//                                    Spacer()
//                                }
//                            }
//                            .overlay(content: {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .stroke(lineWidth: 3)
//                                    .frame(height: 200)
//                                    .foregroundColor(.black)
//                            })
//                            .background(content: {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .frame(height: 200)
//                                    .shadow(radius: 0, x: 8, y: 8)
//                            })
//                            .padding(.bottom, 10)
//                    }
//                }
//                .padding()
//                .padding(.top, 60)
//            }
//            .foregroundColor(.teal)
//            .ignoresSafeArea()
//        }
//    }
}

struct DetailView: View {
    @State var model: Animal
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: model.url))
                .frame(width: UIScreen.width - 40, height: UIScreen.height / 2)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Text("\(model.id)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("\(model.height) \(model.width)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
        }
    }
}

struct NetworkTestView_Preview: PreviewProvider {
    static var previews: some View {
        NetworkTestView()
    }
}
