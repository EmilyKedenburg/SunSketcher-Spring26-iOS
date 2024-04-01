//
//  AfterPhotosReceived.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/9/24.
//

import SwiftUI
import UserNotifications

struct AfterPhotosReceived: View {
    let prefs = UserDefaults.standard
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        // GeometryReader is used because we want the app to be optimized for different screen sizes so this adjsuts all of the
        // measurements to accommodate the screen.
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
                        // This is for the top white line of the overlay background
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
                                
                                Text("Thank you!")
                                  .font(
                                    Font.custom("Oswald", size: geo.size.width * 0.14)
                                      .weight(.semibold)
                                  )
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(.white)
                                  .frame(width: geo.size.width * 0.9, alignment: .top)
                                  .offset(x: 0, y: geo.size.height * 0.04)
                                
                                ScrollView {
                                    Text("Your data has been received! Thank you for participating in SunSketcher! You are now free to uninstall the app.")
                                      .font(
                                        Font.custom("Montserrat", size: geo.size.width * 0.07)
                                          .weight(.semibold)
                                      )
                                      .multilineTextAlignment(.center)
                                      .foregroundColor(.white)
                                      .frame(maxWidth: .infinity)
                                      .offset(x: 0, y: geo.size.height * 0)
                                }.frame(width: geo.size.width * 1, height: geo.size.height * 0.25)
                                
                                // SciStarter button
                                Button(action: {
                                    if let url = URL(string: "https://scistarter.org/form/180") {
                                        UIApplication.shared.open(url)
                                    }
                                }){
                                    HStack {
                                        Text("SciStarter Site")
                                        Image("ic-website")
                                    }.font(Font.custom("Montserrat", size: geo.size.width * 0.07))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.08)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.87, green: 0.58, blue: 0.09), Color(red: 0.10, green: 0.13, blue: 0.47).opacity(0)]), startPoint: .bottom, endPoint: .top)
                                        ).clipShape(RoundedRectangle(cornerRadius: geo.size.width * 0.04))
                                        .overlay(RoundedRectangle(cornerRadius: geo.size.width * 0.04)
                                            .inset(by: -geo.size.width * 0.01)
                                            .strokeBorder(.white, lineWidth: geo.size.width * 0.008))
                                }
                                
                                // For Learn More button
                                NavigationLink(destination: LearnMoreScreen1(), label: {
                                    Text("Learn More")
                                        .font(Font.custom("Montserrat-SemiBold", size: geo.size.width * 0.07))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .frame(width: geo.size.width * 0.66, height: geo.size.height * 0.078)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.87, green: 0.58, blue: 0.09), Color(red: 0.10, green: 0.13, blue: 0.47).opacity(0)]), startPoint: .bottom, endPoint: .top)
                                        ).clipShape(RoundedRectangle(cornerRadius: geo.size.width * 0.04))
                                        .overlay(RoundedRectangle(cornerRadius: geo.size.width * 0.04)
                                            .inset(by: -geo.size.width * 0.01)
                                            .strokeBorder(.white, lineWidth: geo.size.width * 0.008))
                                })// For navigation link
                                .frame(width: geo.size.width * 0.62, height: geo.size.height * 0.16)
                                
                                
                            }// VStack
                        }// ZStack
                        .padding(.top, geo.size.width * 0.01)
                        // This is for the bottom white line of the overlay background
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: geo.size.width, height: geo.size.height * 0.004)
                            .background(Color(red: 1, green: 1, blue: 1))
                            .padding(.top, geo.size.height * 0.022)
                    }// VStack
                    
                }// Zstack
            }// Navigation stack
            .navigationBarBackButtonHidden()
            .onAppear {
                // I am setting these so that if the app is closed and reopened it will take the user to the correct screen they
                // should be on.
                viewModel.AfterPhotosReceivedScreen = true
                viewModel.SharePhotosScreen = false
                viewModel.YesShareScreen = false
                
                // This is to ensure that the permission to send notifications have already been granted.
                checkForPermissions()
                
            }
            
        }// Geometry reader
    }
    
    // Checks the notification permission. If it was denied, the notification is never sent. If it was authorized,
    // the dispatchNotification is called to schedule the notification
    func checkForPermissions() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                print("Notifications granted")
                self.dispatchNotifications()
            case .denied:
                print("Notifications denied")
            default:
                break
            }
        }
    }
    
    // This is for dispatching the notification that the server has received the data and they can uninstall the app
    // Note the notification will not show, if the user has the view already shown
    func dispatchNotifications() {
        // I added this to delay the notification so it has enough time to show
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            
            // Gets the current notification center
            let notificationCenter = UNUserNotificationCenter.current()
            
            // This is to create the content of the notification: title, body, sound
            let content = UNMutableNotificationContent()
            content.title = "Photos Received!"
            content.body = "Your data has been received. Thank you for participating in SunSketcher! You can now uninstall the app."
            content.sound = UNNotificationSound.default
            
            // This trigger is for the time interval if you want the notification to repeat and how many seconds inbetween
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let request = UNNotificationRequest(identifier: "photosReceivedNotification", content: content, trigger: trigger)
            
            // This removes any pending notifications that have the same identifier. I have this because this function is called
            // twice for some reason so this prevents duplicate notifications
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["photosReceivedNotification"])
            
            // This is for adding the requested notification to the notification center
            notificationCenter.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
    }
    
    
}

#Preview {
    AfterPhotosReceived()
}
