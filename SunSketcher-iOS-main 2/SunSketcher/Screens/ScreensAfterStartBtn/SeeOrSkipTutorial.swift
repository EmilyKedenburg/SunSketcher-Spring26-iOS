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
    
    let txt = "Press “YES” when asked if it is ok to share photos. To make sure we receive your data, please don’t delete the app until you are notified your data has been sent."
    
    @Binding var shouldRefreshView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.04, green: 0.04, blue: 0.03)
                    .ignoresSafeArea()

                VStack {
                    // Logo
                    Image("img-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250)
                        .padding(.top, 20)

                    Spacer()

                    // Eclipse image
                    Image("img-eclipse")
                        .resizable()
                        .scaledToFit()

                    Spacer()

                    // Overlay content
                    VStack(spacing: 20) {
                        Text("Before you start..")
                            .font(.custom("Oswald", size: 36))
                            .bold()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Image("img-dndtutorial")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200)

                        Text(txt)
                            .font(.custom("Montserrat", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        NavigationLink(destination: TutorialScreen2(shouldRefreshView: $shouldRefreshView)) {
                            Image("ic-rightarrow")
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(12)

                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                if prefs.bool(forKey: "Checked") {
                    prefs.removeObject(forKey: "Checked")
                    dismiss()
                }
            } // ZStack
        } // NavigationStack
    } // body view

}

#Preview {
    SeeOrSkipTutorial(shouldRefreshView: .constant(false))
}
