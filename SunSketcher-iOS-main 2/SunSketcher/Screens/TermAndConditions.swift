//
//  TermAndConditions.swift
//  Sunsketcher
//
//  Created by Ferguson, Tameka on 2/13/24.
//

import SwiftUI

struct TermAndConditions: View {
    @Environment(\.dismiss) private var dismiss
    
    
    let termsAndConStr = """
        I. The Application

        SunSketcher (“Licensed Application” or “App” hereinafter) is a piece of software created to photograph the 2024 Great North American Eclipse. The App is customized for iOS and Android mobile devices (“Devices”), and is owned by WKU. The App is used with phones located in the Continental United States to take a series of photographs of the totality of the Great North American Eclipse on April 8, 2024. With user consent, the images collected by each user of the App (“User Content”) will be sent to a database along with the time and location (longitude, latitude, and altitude) at which the images were taken. Normal data rates may apply.

        To learn more about the SunSketcher App, and the Great North American Eclipse, see https://sunsketcher.org/faq.php.

        II. Conditions of Use

        By using this app, you certify that you have read and reviewed this Agreement and that you agree to comply with its terms. If you do not want to be bound by the terms of this Agreement, you are advised to stop using the App. Use and access to this App, its products, and its services is only available to those who have accepted the terms and conditions contained herein.

        III. Privacy Policy: Data Collection

        The App will, with your consent, take and collect a series of images from your Device during the Great North American Eclipse on April 8, 2024. The App will also, with your consent, collect your location (longitude, latitude, and altitude), when images of the Great North American Eclipse are collected from your Device on April 8, 2024. Other than location, this App will not collect or store any personal information. See https://sunsketcher.org/privacy.php.

        You may elect to register as a SunSketcher (https://sunsketcher.org/register.php), by providing your email address to receive updates from SunSketcher; however, providing your email address is optional, meaning that you are not required to provide the data in order for the App to function.

        IV. Age Restriction

        If you are under the age of 13, you should not use this App. If you are a minor between the ages of 13-18, you may use this App only in conjunction with your parent, legal guardian, or other responsible adult.

        The above stated age restrictions are necessary to ensure compliance with the Children’s Online Privacy Protection Act (COPPA). 15 U.S.C §§ 6501-6506.

        V. Intellectual Property

        The App and its original content (which does not include User Content), are and will remain the exclusive property of SunSketcher. User hereby grants to WKU a perpetual, irrevocable, non-exclusive, royalty free license to use, reproduce, display and publish the User Content uploaded through the App, for any purpose determined by WKU.

        VI. Updates and Modifications

        We reserve the right to modify or change the terms contained herein at any time.

        VII. Applicable Law

        This Agreement shall be governed by, construed, and enforced in accordance with the laws of the state of Kentucky (without giving effect to principles of conflicts of law).

        VIII. Severability

        If any provision of these Terms of Use is deemed unlawful, void, or unenforceable for any reason, then that provision will be deemed severable from the remainder of this Agreement and will not affect the validity or enforceability of the remainder of this Agreement.

        IX. Liability 
    
        You expressly understand and agree that SunSketcher, Western Kentucky University, its directors, officers, employees, and agents, will not be held liable for any direct, indirect, incidental, special, consequential or punitive damages resulting from the use of the App or inability to use the App.

        X. Contact 
    
        If you have any questions about the SunSketcher App, please contact:

        Western Kentucky University Greg Arbuckle greg.arbuckle@WKU.edu

    """
    
    
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
                            .padding(.top, geo.size.height * 0.12)
                        
                        ZStack {
                            // For dark somewhat clear background overlay
                            Color.black.opacity(0.4)
                                .frame(width: geo.size.width * 1, height: geo.size.height * 0.8)
                                .offset(x: 0, y: geo.size.height * 0.04)
                            
                            VStack{
                                ScrollView {
                                        
                                        Text(termsAndConStr)
                                          .font(
                                            Font.custom("Montserrat", size: geo.size.width * 0.032)
                                              .weight(.semibold)
                                          )
                                          .multilineTextAlignment(.leading)
                                          .foregroundColor(.white)
                                          .frame(width: geo.size.width * 0.8, alignment: .top)
                                          .offset(x: 0, y: geo.size.height * 0.02)
                                
                                    
                                }// For Scroll
                                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.7, alignment: .top)
                                .padding(.bottom, geo.size.height * 0.04)
                                // For button
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image("ic-checkmark")
                                        .frame(width: geo.size.width * 0.10, height: geo.size.width * 0.08)
                                        .offset(x: geo.size.width * 0.0, y: geo.size.height * 0.0)
                                }
                            }
                            .frame(width: geo.size.width, height: geo.size.height * 0.8)
                            
                            
                        }// ZStack
                        .padding(.top, geo.size.width * 0.0)
                        
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
            
        }
        
    }
}

#Preview {
    TermAndConditions()
}
