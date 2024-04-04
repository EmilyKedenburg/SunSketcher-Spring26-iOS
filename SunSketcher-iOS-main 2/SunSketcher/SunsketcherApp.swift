//
//  SunSketcherApp.swift
//  SunSketcher
//
//  Created by Tameka Ferguson on 8/25/23.
//

// This the main .swift file for the app.
// In the views, GeometryReader is used because we want the app to be optimized for different screen sizes so this adjsuts all of the
// measurements to accommodate the screen.

import SwiftUI


@main
struct SunSketcherApp: App {
    @StateObject var locationManager = LocationManager()
    let metadataDB = MetadataDB.shared
    
    let preferences = UserDefaults.standard
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
        }
    }
    
    // convert `hh:mm:ss` format string to unix time (this version is specifically for Apr. 8, 2024 eclipse)
    // To change this function to fit with another eclipse
    func convertTimes(data: [String]) -> [Int64] {
        let start = data[0].split(separator: ":").compactMap { Int($0) }
        let end = data[1].split(separator: ":").compactMap { Int($0) }

        // Add the actual time to the Unix time of UTC midnight for the start of that day
        // For April 8
        let startUnix = 1712534400 + (Int64(start[0]) * 3600) + (Int64(start[1]) * 60) + Int64(start[2])
        let endUnix = 1712534400 + (Int64(end[0]) * 3600) + (Int64(end[1]) * 60) + Int64(end[2])

        return [startUnix, endUnix]
    }
    
    /*func testConvertTimes(data: [String]) -> [Int64] {
        let start = data[0].split(separator: ":").compactMap { Int($0) }
        let end = data[1].split(separator: ":").compactMap { Int($0) }
        
        //get current time in seconds, remove a day if it is past UTC midnight for the date that your timezone is currently in
        var currentDateUnix = Int64(Date().timeIntervalSince1970)
        let currentTimeUnix = currentDateUnix % 86400
        if (currentTimeUnix > 0) && (currentTimeUnix < 5 * 60 * 60) {
            print("Current time is past UTC midnight; Subtracting a day from time estimate")
            currentDateUnix -= 86400
        }
        let currentDateTimezoneCorrectedUnix = currentDateUnix - (currentDateUnix % (60 * 60 * 24))
        
        // Convert the given time to seconds, add it to the start of the day as calculated by
        let startUnixMult = Int64(start[0]) * 3600 + Int64(start[1]) * 60 + Int64(start[2])
        let startUnix = currentDateTimezoneCorrectedUnix + startUnixMult
        
        let endUnixMult = Int64(end[0]) * 3600 + Int64(end[1]) * 60 + Int64(end[2])
        let endUnix = currentDateTimezoneCorrectedUnix + endUnixMult
        
        return [startUnix, endUnix]
        
    }*/
    
}

