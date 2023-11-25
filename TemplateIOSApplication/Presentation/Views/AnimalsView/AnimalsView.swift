//
//  NetworkTestView.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation
import SwiftUI
import UIKit

struct AnimalsView: View {
    
    @EnvironmentObject var vm: AnimalsViewVM
    @State var focus: Bool = false
    @State var showAccount: Bool = false
    @State var accountButtonSize: CGRect = .zero
    var onLogout: () -> Void
    
    var body: some View {
        LoadingView(isShowing: $vm.showLoading) {
            NavigationView {
                GeometryReader { geometry in
                    ZStack {
                        ZStack(alignment: .top) {
                            ScrollView(showsIndicators: false) {
                                ForEach(vm.animals, id: \.id) { item in
                                    NavigationLink {
                                        DetailView(model: item).navigationBarBackButtonHidden(true)
                                    } label: {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(height: 200)
                                            .overlay {
                                                HStack(spacing: 10) {
                                                    AsyncImage(url: URL(string: item.url ?? ""), scale: 2)
                                                        .frame(width: UIScreen.width * 3 / 7, height: 200)
                                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    VStack(alignment: .leading) {
                                                        Text("\(item.id ?? "")")
                                                            .font(.title)
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.black)
                                                        Text("\(item.height) \(item.width)")
                                                            .font(.subheadline)
                                                            .fontWeight(.bold)
                                                            .foregroundColor(.black)
                                                        Spacer()
                                                    }
                                                    .padding(.top, 10)
                                                    Spacer()
                                                }
                                            }
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(lineWidth: 3)
                                                    .frame(height: 200)
                                                    .foregroundColor(.black)
                                            })
                                            .background(content: {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .frame(height: 200)
                                            })
                                            .padding(.bottom, 10)
                                    }
                                }
                                .padding([.leading, .trailing], 20)
                                .offset(y: 40)
                                
                                // Show more in case do not searching only
                                if vm.text.isEmpty {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(lineWidth: 3)
                                        .frame(height: 50)
                                        .overlay {
                                            Text("Load more")
                                                .font(.system(size: 26))
                                                .fontWeight(.bold)
                                        }
                                        .background(content: {
                                            RoundedRectangle(cornerRadius: 12)
                                                .frame(height: 50)
                                                .foregroundColor(.white)
                                        })
                                        .padding([.leading, .trailing], 20)
                                        .padding(.bottom, 40)
                                        .offset(y: 40)
                                        .onTapGesture {
                                            Task { @MainActor in
                                                await vm.getMore()
                                            }
                                        }
                                }
                            }
                            .padding(.top, 30)
                            .foregroundColor(.teal)
                            
                            HStack(spacing: 4) {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(lineWidth: 3)
                                    .frame(height: 50)
                                    .overlay {
                                        TextField("Enter", text: $vm.text) { focus in
                                            self.focus = focus
                                        }
                                        .padding()
                                    }
                                    .background {
                                        RoundedRectangle(cornerRadius: 25)
                                            .frame(height: 50)
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 0, x: 8, y: 8)
                                    }
                                Circle()
                                    .stroke(lineWidth: 3)
                                    .frame(height: 50)
                                    .overlay {
                                        Button {
                                            showAccount.toggle()
                                        } label: {
                                            Image(systemName: "person")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 20)
                                                .foregroundColor(.black)
                                        }
                                        
                                    }
                                    .background {
                                        Circle()
                                            .frame(height: 50)
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 0, x: 8, y: 8)
                                    }
                                    .readSize { analysedSize in
                                        accountButtonSize = analysedSize
                                    }
                            }
                            .padding([.leading, .trailing, .bottom], 20)
                        }
                    }
                    AccountView(isShowing: $showAccount, width: 50, onLogout: {
                        showAccount = false
                        onLogout()
                    })
                    .offset(x: accountButtonSize.minX, y: accountButtonSize.minY)
                }
            }
        }
    }
}

struct DetailView: View {
    @State var model: Animal
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                AsyncImage(url: URL(string: model.url ?? ""))
                    .frame(width: UIScreen.width - 40, height: UIScreen.height / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("\(model.id ?? "")")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("\(model.height) \(model.width)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(width: UIScreen.width)
            .padding(.top, 40)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.black)
            }
            .padding(.trailing, 20)
        }
    }
}


struct NetworkTestView_Preview: PreviewProvider {
    static var previews: some View {
        AnimalsView(onLogout: { })
    }
}
