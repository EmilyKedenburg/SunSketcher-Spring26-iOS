//
//  SeeOrSkipTutorial.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/9/24.
//

import SwiftUI

struct SeeOrSkipTutorial: View {
    @Environment(\.dismiss) private var dismiss
    let prefs = UserDefaults.standard
    
    @Binding var shouldRefreshView: Bool
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack{
                
                ZStack {
                    // For background
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .background(Color(red: 0.04, green: 0.04, blue: 0.03))
                        .offset(x: 0, y: 0)
                    
                    // For logo
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: geo.size.width * 0.65, height: geo.size.height * 0.14)
                        .background(
                            Image("img-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width * 0.65, height: geo.size.height * 0.07)
                                .clipped()
                            
                        )
                        .offset(x: 0, y: -geo.size.height * 0.45)
                        .padding(.top, 20)
                    
                    // For eclipse image
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: geo.size.width * 0.85, height: geo.size.height * 1)
                        .background(
                            Image("img-eclipse")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 1, height: geo.size.height * 1.4)
                            
                        )
                        .offset(x: 0, y: geo.size.height * 0.22)
                    
                
                    VStack {
                        // This is for the top white line of the background overlay
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width, height: geo.size.height * 0.004)
                            .background(Color(red: 1, green: 1, blue: 1))
                            .padding(.top, geo.size.height * 0.11)
                        
                        ZStack {
                            // For dark somewhat clear background overlay
                            Color.black.opacity(0.4)
                                .frame(width: geo.size.width * 1, height: geo.size.height * 0.8)
                                .offset(x: 0, y: geo.size.height * 0.04)
                            
                            
                            VStack {
                                ScrollView {
                                    Text("Are you sure you want to skip the tutorial?")
                                      .font(
                                        Font.custom("Montserrat", size: geo.size.width * 0.09)
                                          .weight(.bold)
                                      )
                                      .multilineTextAlignment(.center)
                                      .foregroundColor(.white)
                                      .frame(width: geo.size.width * 0.8, alignment: .top)
                                }.frame(width: geo.size.width * 1, height: geo.size.height * 0.2)
                                
                                
                                
                                
                                // For buttons
                                NavigationLink(destination: TutorialScreen1(shouldRefreshView: $shouldRefreshView), label: {
                                    Text("See tutorial")
                                        .font(Font.custom("Montserrat", size: geo.size.width * 0.09))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.1)
                                        .background(Color(red: 0.05, green: 0.58, blue: 0))
                                        .clipShape(RoundedRectangle(cornerRadius: geo.size.width * 0.04))
                                        .overlay(RoundedRectangle(cornerRadius: geo.size.width * 0.04)
                                            .inset(by: -geo.size.width * 0.01)
                                            .strokeBorder(.white, lineWidth: geo.size.width * 0.008))
                                })
                                .frame(width: geo.size.width * 0.62, height: geo.size.height * 0.16)
                                    .offset(x: 0, y: -geo.size.height * 0)
                                Button(action: {
                                    print("Tapped")
                                    prefs.set(true, forKey: "FromSeeTutorial")
                                }) {
                                    
                                }
                                
                                NavigationLink(destination: LocationVerification(), label: {
                                    Text("Skip tutorial")
                                        .font(Font.custom("Montserrat", size: geo.size.width * 0.09))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.1)
                                        .background(Color(red: 0.47, green: 0, blue: 0))
                                        .clipShape(RoundedRectangle(cornerRadius: geo.size.width * 0.04))
                                        .overlay(RoundedRectangle(cornerRadius: geo.size.width * 0.04)
                                            .inset(by: -geo.size.width * 0.01)
                                            .strokeBorder(.white, lineWidth: geo.size.width * 0.008))
                                }).frame(width: geo.size.width * 0.62, height: geo.size.height * 0.16)
                                    .offset(x: 0, y: -geo.size.height * 0)
                                
                                
                                
                            }// VStack
                        }// ZStack
                        .padding(.top, geo.size.width * 0.01)
                        
                        // This is for the bottom white line of the background overlay
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width, height: geo.size.height * 0.004)
                            .background(Color(red: 1, green: 1, blue: 1))
                            .padding(.top, geo.size.height * 0.028)
                    }// VStack
                    
                }// Zstack
            }// Navigation stack
            .navigationBarBackButtonHidden()
            .onAppear {
                if prefs.bool(forKey: "FromSeeTutorial") || prefs.bool(forKey: "Close skiptutorial"){
                    prefs.removeObject(forKey: "FromSeeTutorial")
                    prefs.removeObject(forKey: "Close skiptutorial")
                    dismiss()
                }
            }
            
        }// Geometry reader
    }// body view
}

#Preview {
    SeeOrSkipTutorial(shouldRefreshView: .constant(false))
}
