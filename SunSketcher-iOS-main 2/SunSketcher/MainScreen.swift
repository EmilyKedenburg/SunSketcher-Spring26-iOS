//
//  MainScreen.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 1/25/24.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        ZStack() {
            // Background
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 403, height: 861)
                .background(Color(red: 0.04, green: 0.04, blue: 0.03))
                .offset(x: 1.50, y: -2.50)
            
            // SunSketcher logo
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 261, height: 56)
                .background(
                    Image("img-logo")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 261, height: 56)
                        .clipped()
                
                )
                .offset(x: 0.50, y: -329)
            
            // Eclipse image
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 741, height: 720)
                .background(
                    Image("img-eclipse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500, height: 500)
                        
                )
                .offset(x: 0, y: 160)
            
            // Start Btn
            ZStack() {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Start")
                        .font(Font.custom("Oswald", size: 48)).fontWeight(.bold).foregroundStyle(.white)
                }).foregroundStyle(.clear)
                    .frame(width: 250, height: 60)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(red: 0.87, green: 0.58, blue: 0.09), Color(red: 0.10, green: 0.13, blue: 0.47).opacity(0)]), startPoint: .bottom, endPoint: .top)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: -1.50)
                            .stroke(.white, lineWidth: 1.50)
                    )
                    .offset(x: 0, y: 0.50)
            }
            .frame(width: 250, height: 61)
            .offset(x: 6, y: -193.50)
            
            // Tutorial Btn
            ZStack() {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Tutorial")
                        .font(Font.custom("Oswald", size: 48)).fontWeight(.bold).foregroundStyle(.white)
                }).foregroundStyle(.clear)
                    .frame(width: 250, height: 60)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(red: 0.87, green: 0.58, blue: 0.09), Color(red: 0.10, green: 0.13, blue: 0.47).opacity(0)]), startPoint: .bottom, endPoint: .top)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: -1.50)
                            .stroke(.white, lineWidth: 1.50)
                    )
                    .offset(x: 0, y: 0.50)
            }
            .frame(width: 250, height: 61)
            .offset(x: 6, y: -86.50)
            
            // Learn More Btn
            ZStack() {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Learn More")
                        .font(Font.custom("Oswald", size: 40)).fontWeight(.bold).foregroundStyle(.white)
                }).foregroundStyle(.clear)
                    .frame(width: 250, height: 60)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(red: 0.87, green: 0.58, blue: 0.09), Color(red: 0.10, green: 0.13, blue: 0.47).opacity(0)]), startPoint: .bottom, endPoint: .top)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: -1.50)
                            .stroke(.white, lineWidth: 1.50)
                    )
                    .offset(x: 0, y: 0.50)
            }
            .frame(width: 250, height: 61)
            .offset(x: 6, y: 20.50)
        }
        .frame(width: 360, height: 800)
        .background(.white)
    }
}

struct MainScreen_Previews: PreviewProvider {
  static var previews: some View {
      MainScreen()
  }
}
