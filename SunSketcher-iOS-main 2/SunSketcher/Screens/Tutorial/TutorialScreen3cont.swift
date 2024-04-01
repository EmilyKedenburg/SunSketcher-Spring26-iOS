//
//  TutorialScreen3.5.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 4/1/24.
//

import SwiftUI

struct TutorialScreen3cont: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var shouldRefreshView: Bool
    
    let prefs = UserDefaults.standard
    
    let txt = "Remember to take proper safety precautions! Always use ISO 12312-2 certified solar filters when looking at the Sun during the eclipse, except for the brief period during totality where it is safe to take them off.\n\nThat being said, please do not place a solar filter over the phone's camera(s)!\nWhile we humans have sensitive eyes that require a solar filter to be able to safely look at the Sun, rest assured that aiming a camera at the Sun will incur no damages to it, especially over such a short period of time. A phone's camera has nothing organic like the cells in our eyes do, and, as such, cannot be damaged by contact with sunlight unless over very long periods, about the same amount of time it might take for a piece of cloth to become sun-bleached. The SunSketcher team has performed extensive testing related to the effects of sunlight on phone cameras and even tested the SunSketcher app during the October 14th, 2023 annular eclipse (which, due to being annular as opposed to total, results in more light hitting the camera's sensor) and saw no adverse effects, whether lasting or temporary, with any phone used."
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                
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
                                    Text("About solar filters")
                                      .font(
                                        Font.custom("Oswald", size: geo.size.width * 0.1)
                                          .weight(.bold)
                                      )
                                      .multilineTextAlignment(.center)
                                      .foregroundColor(.white)
                                      .frame(maxWidth: .infinity)
                                      //.padding(.top, -geo.size.height * 0.02)
                                }.frame(width: geo.size.width * 1, height: geo.size.height * 0.1, alignment: .top)
                                
                                // For image
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: geo.size.width * 0.55, height: geo.size.height * 0.3)
                                    .background(
                                        Image("img-solar_glasses")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.01)
                                            .offset(x: 0, y: -geo.size.height * 0.03)
                                    )//.padding(.bottom, geo.size.height * 0.08)
                                
                                ScrollView {
                                    Text(txt)
                                      .font(
                                        Font.custom("Montserrat", size: geo.size.width * 0.049)
                                          .weight(.medium)
                                      )
                                      .multilineTextAlignment(.center)
                                      .foregroundColor(.white)
                                      .frame(maxWidth: .infinity)
                                      //.frame(width: geo.size.width * 0.8, height: geo.size.height * 0.25, alignment: .top)
                                }.frame(width: geo.size.width * 0.9, height: geo.size.height * 0.32)
                                    .offset(x: 0, y: -geo.size.height * 0.03)
                                
                                
                                
                                // For buttons
                                HStack {
                                    NavigationLink(destination: TutorialScreen3(shouldRefreshView:$shouldRefreshView), label: {
                                        EmptyView()
                                    })
                                    .navigationBarBackButtonHidden(true)
                                    Button(action: {
                                        dismiss()
                                    }) {
                                        Image("ic-leftarrow")
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.08)
                                            .padding(.trailing, geo.size.width * 0.02)
                                            .offset(x: geo.size.width * 0.0, y: geo.size.height * 0.01)
                                    }
                                    
                                    
                                    NavigationLink(destination: TutorialScreen4(shouldRefreshView:$shouldRefreshView), label: {
                                        Image("ic-rightarrow")
                                            .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.08)
                                           .padding(.leading, geo.size.width * 0.6)
                                            .offset(x: geo.size.width * 0.0, y: geo.size.height * 0.01)
                                    })
                                }// For HStack
                                //.offset(x: 0, y: geo.size.height * 0.2)
                                
                            }// VStack
                            
                        }// Zstack
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width, height: geo.size.height * 0.004)
                            .background(Color(red: 1, green: 1, blue: 1))
                            .padding(.top, geo.size.height * 0.04)
                        
                    }// For VStack
                }// For Zstack
            }// For NavigationStack
            .onAppear {
                if prefs.bool(forKey: "Checked") {
                    dismiss()
                }
            }
        }// For geomtry
        
    }
}



struct TutorialScreen3cont_Previews: PreviewProvider {
    static var previews: some View {
        TutorialScreen3cont(shouldRefreshView: .constant(false))
    }
}
