//
//  SharePhotosScreen.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/5/24.
//

import SwiftUI

struct SharePhotosScreen: View {
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
                    //.frame(width: 261, height: 56)
                        .frame(width: geo.size.width * 0.65, height: geo.size.height * 0.14)
                        .background(
                            Image("img-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            //.frame(width: 261, height: 56)
                                .frame(width: geo.size.width * 0.65, height: geo.size.height * 0.07)
                                .clipped()
                            
                        )
                        .offset(x: 0, y: -geo.size.height * 0.45)
                        .padding(.top, 20)
                    
                    // For eclipse image
                    Rectangle()
                        .foregroundColor(.clear)
                    //.frame(width: 741, height: 720)
                        .frame(width: geo.size.width * 0.85, height: geo.size.height * 1)
                        .background(
                            Image("img-eclipse")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            //.frame(width: 500, height: 500)
                                .frame(width: geo.size.width * 1, height: geo.size.height * 1.4)
                            
                        )
                    //.offset(x: 0, y: 160)
                        .offset(x: 0, y: geo.size.height * 0.22)
                    
                    if geo.size.height <= 749 {
                     Rectangle()
                         .foregroundColor(.clear)
                         .frame(width: geo.size.width * 4, height: geo.size.height * 0.85)
                         .background(Color(red: 0.07, green: 0.06, blue: 0.03).opacity(0.9))
                         .overlay(
                             RoundedRectangle(cornerRadius: geo.size.width * 0.04)
                                 .inset(by: -geo.size.width * 0)
                                 .stroke(.white, lineWidth: geo.size.width * 0.007)
                         ).offset(x: 0, y: geo.size.height * 0.035)
                    } else {
                     Rectangle()
                         .foregroundColor(.clear)
                         .frame(width: geo.size.width * 4, height: geo.size.height * 0.8)
                         .background(Color(red: 0.07, green: 0.06, blue: 0.03).opacity(0.9))
                         .overlay(
                             RoundedRectangle(cornerRadius: geo.size.width * 0.04)
                                 .inset(by: -geo.size.width * 0)
                                 .stroke(.white, lineWidth: geo.size.width * 0.007)
                         ).offset(x: 0, y: geo.size.height * 0.04)
                    }
                    
                    VStack {
                        Text("Ok to Share Photos?")
                          .font(
                            Font.custom("Oswald", size: geo.size.height * 0.045)
                              .weight(.semibold)
                          )
                          .multilineTextAlignment(.center)
                          .foregroundColor(.white)
                          .frame(width: geo.size.width * 0.8, alignment: .top)
                        
                        Text("Scroll left and right for more images.\n\nThey might look a little boring, but they can still be valuable to us! ")
                          .font(
                            Font.custom("Montserrat", size: geo.size.height * 0.027)
                              .weight(.light)
                          )
                          .multilineTextAlignment(.center)
                          .foregroundColor(.white)
                          .frame(width: geo.size.width * 0.8, alignment: .top)
                        
                        
                        
                    }
                      
                    
                    
                    
                }
            }
            
        }
    }
}
struct SharePhotosScreen_Previews: PreviewProvider {
    static var previews: some View {
        SharePhotosScreen()
    }
}
