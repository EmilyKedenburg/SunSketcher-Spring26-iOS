//
//  SQLiteManager.swift
//  Sunsketcher
//
//  Created by Tameka Ferguson on 1/22/24.
//

/*
 This file is for the app database. It holds the latitude, longitude, altitude, filepath, capture time, aperture, iso, exposure time, white balance, focal distance and if the images are cropped (0/1) values.
 It uses SQLite/SQL for the query language.
 */

import Foundation
import SQLite3

struct ImageMetadata {
    let id: Int
    let latitude: Double
    let longitude: Double
    let altitude: Double
    let filepath: String
    let captureTime: Int64
    let aperture: Double
    let iso: Float
    let exposureTime: Float
    let whiteBalance: Int
    let focalDistance: Float
    let isCropped: Int
}


class MetadataDB {
    static let shared = MetadataDB()
    private var db: OpaquePointer?

    private init() {
        openDatabase()
        createMetadataTable()
    }

    private func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("metadata.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database.")
        } else {
            print("Database opened.")
        }
    }

    private func createMetadataTable() {
        let createTableSQL = """
        CREATE TABLE IF NOT EXISTS Metadata (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude REAL,
            longitude REAL,
            altitude REAL,
            filepath VARCHAR(255),
            captureTime INTEGER UNIQUE,
            aperture REAL,
            iso REAL,
            exposureTime REAL,
            whiteBalance REAL,
            focalDistance REAL,
            isCropped INTEGER
        );
        """
        print("Table created.")
        executeQuery(sql: createTableSQL)
    }
    
    private func executeQuery(sql: String) {
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error executing query.")
            }
            sqlite3_finalize(statement)
            print("Query executed.")
        } else {
            print("Error preparing SQL statement.")
        }
    }

    func addImageMeta(latitude: Double, longitude: Double, altitude: Double, filepath: String, captureTime: Int64, aperture: Double, iso: Float, exposureTime: Float, whiteBalance: Int32, focalDistance: Float, isCropped: Int) {
        let insertSQL = "INSERT INTO Metadata (latitude, longitude, altitude, filepath, captureTime, aperture, iso, exposureTime, whiteBalance, focalDistance, isCropped) VALUES (?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?);"
        
        let tempFilepath: NSString = NSString(string: filepath)

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_double(statement, 1, latitude)
            sqlite3_bind_double(statement, 2, longitude)
            sqlite3_bind_double(statement, 3, altitude)
            sqlite3_bind_text(statement, 4, tempFilepath.utf8String, -1, nil)
            sqlite3_bind_int64(statement, 5, captureTime)
            sqlite3_bind_double(statement, 6, aperture)
            sqlite3_bind_double(statement, 7, Double(iso))
            sqlite3_bind_double(statement, 8, Double(exposureTime))
            sqlite3_bind_int(statement, 9, whiteBalance)
            sqlite3_bind_double(statement, 10, Double(focalDistance))
            sqlite3_bind_int(statement, 11, Int32(isCropped))
            
        
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error inserting data into Metadata table: \(String(cString: sqlite3_errmsg(db)))")

            }
            
            sqlite3_finalize(statement)
        } else {
            print("Error preparing SQL statement: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    
    // Used this one specifically for cropped images
    func updateImageFilepath(rowID: Int, filepath: String, isCropped: Int) {
        let updateSQL = "UPDATE Metadata SET filepath = ?, isCropped = ? WHERE id = ?"
        
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (filepath as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 2, Int32(isCropped))
            sqlite3_bind_int(statement, 3, Int32(rowID))
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error updating data in Metadata table: \(String(cString: sqlite3_errmsg(db)))")
            }
            
            sqlite3_finalize(statement)
        } else {
            print("Error preparing SQL statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
    }
    
    // Used this one if the app is updated while on SharePhotosScreen it can replace the new directory of the app
    // with the new one so that images can be found
    func updateImageFilepathOnly(filepath: String, newFilepath: String) {
        let updateSQL = "UPDATE Metadata SET filepath = ? WHERE filepath = ?"
        
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (newFilepath as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (filepath as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error updating data in Metadata table: \(String(cString: sqlite3_errmsg(db)))")
            }
            
            sqlite3_finalize(statement)
        } else {
            print("Error preparing SQL statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
    }
    
    
    func retrieveImageMeta() -> [ImageMetadata] {
        var metadataArray = [ImageMetadata]()
        
        let querySQL = "SELECT * FROM Metadata;"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let latitude = Double(sqlite3_column_double(statement, 1))
                let longitude = Double(sqlite3_column_double(statement, 2))
                let altitude = Double(sqlite3_column_double(statement, 3))
                let filepath = String(cString: sqlite3_column_text(statement, 4))
                let captureTime = Int64(sqlite3_column_int(statement, 5))
                let aperture = Double(sqlite3_column_double(statement, 6))
                let iso = Float(sqlite3_column_double(statement, 7))
                let exposureTime = Float(sqlite3_column_double(statement, 8))
                let whiteBalance = Int(sqlite3_column_int(statement, 9))
                let focalDistance = Float(sqlite3_column_double(statement, 10))
                let isCroppedInt = Int(sqlite3_column_int(statement, 11))
                
                let metadata = ImageMetadata(id: id, latitude: latitude, longitude: longitude, altitude: altitude, filepath: filepath, captureTime: captureTime, aperture: aperture, iso: iso, exposureTime: exposureTime, whiteBalance: whiteBalance, focalDistance: focalDistance, isCropped: isCroppedInt)
                metadataArray.append(metadata)
            }
            
            sqlite3_finalize(statement)
        } else {
            print("Error preparing SQL statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
        return metadataArray
    }
    
//    func dropTable() {
//        let dropSQL = "DROP TABLE IF EXISTS Metadata;"
//
//        var statement: OpaquePointer?
//        if sqlite3_prepare_v2(db, dropSQL, -1, &statement, nil) == SQLITE_OK {
//            if sqlite3_step(statement) != SQLITE_DONE {
//                print("Error dropping Metadata table: \(String(cString: sqlite3_errmsg(db)))")
//            }
//            
//            print("Database dropped")
//            sqlite3_finalize(statement)
//        } else {
//            print("Error preparing SQL statement: \(String(cString: sqlite3_errmsg(db)))")
//        }
//        
//        createMetadataTable()
//    }



    deinit {
        sqlite3_close(db)
    }
}
