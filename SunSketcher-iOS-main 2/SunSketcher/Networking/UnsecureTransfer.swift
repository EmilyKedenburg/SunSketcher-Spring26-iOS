//
//  UnsecureTransfer.swift
//  iOS-Server
//
//  Created by Travis Peden on 3/1/24.
//

import Foundation
import CryptoKit
import Network

extension FixedWidthInteger {
    var data: Data {
        var int = self
        return withUnsafeBytes(of: &int) { Data($0) }
    }
}

extension FloatingPoint {
    var data: Data {
        var float = self
        return withUnsafeBytes(of: &float) { Data($0) }
    }
}

struct UnsecureTransfer {
    var client: ClientConnection
    let prefs = UserDefaults.standard
    
    
    init() {
        client = ClientConnection(nwConnection: NWConnection(host: "161.6.109.198", port: 10000, using: .tcp))
    }
    
    func IDRequest() -> Bool {
        client.didStopCallback = didStopCallback(error:)
        client.start()
        sleep(1)
        
        print("Connection with server started successfully.")
        
        var clearToSend = ""
        client.receiveMessageString {
            message in
            if let message = message {
                clearToSend = message
            }
        }
        sleep(1)
        
        if (clearToSend == "true") {
            print("Sending server the necessary settings for ID the connection settings to the serverRequest.")
            //send
            client.send(data: Data("IDRequest\n".utf8))
            client.send(data: Data("uIOS\n".utf8))
            
            //send the passkey for authentication
            client.send(data: Data("SarahSketcher2024\n".utf8))
            sleep(1)
            
            print("Waiting for ID to be received.")
            //attempt to receive clientID
            var clientID = -1
            client.receiveMessageString {
                message in
                if let message = message {
                    clientID = Int(message) ?? -1
                }
            }
            sleep(1)
            
            if (clientID != -1) {
                //write client ID to prefs
                let prefs = UserDefaults.standard
                prefs.set(clientID, forKey: "ClientID")
                print("ClientID received successfully: \(clientID.description)")
                
                self.prefs.set(true, forKey: "ClientID obtained")
                client.stop()
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func TransferRequest() -> Bool {
        //if !prefs.bool(forKey: "Transfer called"){
            //prefs.set(true, forKey: "Transfer called")
            client.start()
            sleep(1)
            
            print("Connection with server started successfully.")
            
            var clearToSend = ""
            client.receiveMessageString {
                message in
                if let message = message {
                    clearToSend = message
                }
            }
            sleep(1)
            
            if (clearToSend == "true") {
                print("Sending server the necessary settings for IDRequest.")
                //send the connection settings to the server
                client.send(data: Data("TransferRequest\n".utf8))
                client.send(data: Data("uIOS\n".utf8))
                
                //send the passkey for authentication
                client.send(data: Data("SarahSketcher2024\n".utf8))
                sleep(1)
                
                print("Sending client ID: \(UserDefaults.standard.integer(forKey: "ClientID").description)")
                client.send(data: Data("\(UserDefaults.standard.integer(forKey: "ClientID"))\n".utf8))

                
                //loop through database entries
                let metadataArray = MetadataDB.shared.retrieveImageMeta()
                
                
                let arrayCount = metadataArray.count
                client.send(data: Data("\(arrayCount)\n".utf8))


                for metadata in metadataArray {
                    //client.send(data: Data(metadata.))
                    
                    print("ID: \(metadata.id), Latitude: \(metadata.latitude), Longitude: \(metadata.longitude), Altitude: \(metadata.altitude), Filepath: \(metadata.filepath), Capture Time: \(metadata.captureTime), ISO \(metadata.iso), Exposure time: \(metadata.exposureTime), White balance: \(metadata.whiteBalance), Focal distance: \(metadata.focalDistance), isCropped: \(metadata.isCropped)")
                    
                    
                    let filepath = metadata.filepath
                    let filename = URL(string: filepath)!.lastPathComponent
                    let fileNameData = Data("\(filename)\n".utf8)
                    //(filename?.data(using: .utf8))!
                    
                    //var fileLength = getFileSize(atPath: filepath)
                    //let fileLengthData = Data(bytes: &fileLength, count: MemoryLayout<Int64>.size)
                    
                    var fileData: Data? = nil

                    //if FileManager.default.fileExists(atPath: filepath) {
                        do {
                            let fileURL = NSURL(fileURLWithPath: filepath)
                            print("Filepath to read from: \(fileURL.absoluteString)")
                            
                            fileData = try Data(referencing: NSData(contentsOf: fileURL as URL))
                            
                            print("fileData: \(fileData)")
                        } catch {
                            print("Error converting file to Data: \(error.localizedDescription)")
                        }
                    /*} else {
                        print("File not found at path: \(filepath)")
                    }*/
                    
                    

                    
                    
                    // Convert numeric values to Data
                    
                    let unixTimeStamp1 = filepath.components(separatedBy: "_")
                    let unixTimeStamp2 = unixTimeStamp1[1].components(separatedBy: ".")
                    
                    print("Correct capture time: \(unixTimeStamp2[0])")
                    
                    
                    let latitudeData = Data("\(metadata.latitude)\n".utf8)
                    let longitudeData = Data("\(metadata.longitude)\n".utf8)
                    let altitudeData = Data("\(metadata.altitude)\n".utf8)
                    let captureTimeData = Data("\(unixTimeStamp2[0])\n".utf8)
                    let apertureData = Data("\(metadata.aperture)\n".utf8)
                    let isoData = Data("\(metadata.iso)\n".utf8)
                    let whiteBalanceData = Data("\(metadata.whiteBalance)\n".utf8)
                    let focusDistanceData = Data("\(metadata.focalDistance)\n".utf8)
                    let exposureData = Data("\(metadata.exposureTime)\n".utf8)
                    
                    
                    client.send(data: fileNameData)
                    //client.send(data: Data("\(String(data: fileLengthData, encoding: .utf8))\n".utf8))
                    //client.send(data: fileData)
                    client.send(data: fileData?.base64EncodedData() ?? Data())
                    client.send(data: Data("\n".utf8))
                    client.send(data: latitudeData)
                    client.send(data: longitudeData)
                    client.send(data: altitudeData)
                    client.send(data: captureTimeData)
                    client.send(data: apertureData)
                    client.send(data: isoData)
                    client.send(data: whiteBalanceData)
                    client.send(data: focusDistanceData)
                    client.send(data: exposureData)
                    
                    
                }
                
                var canDisconnect = "no"
                client.receiveMessageString {
                    message in
                    if let message = message {
                        canDisconnect = message
                    }
                }
                
                while(canDisconnect == "no") {
                    print("Can't disconnect yet.")
                    sleep(2)
                }
                prefs.set(true, forKey: "Transfer complete")
            }
            
            client.stop()
            //prefs.set(true, forKey: "Transfer complete")
            return true
        /*} else {
            return true
        }*/
        
    }
    
    func didStopCallback(error: Error?) {
        if error == nil {
            exit(EXIT_SUCCESS)
        } else {
            exit(EXIT_FAILURE)
        }
    }
    
    func getFileSize(atPath path: String) -> Int64? {
        let fileManager = FileManager.default
        do {
            let attributes = try fileManager.attributesOfItem(atPath: path)
            if let fileSize = attributes[FileAttributeKey.size] as? Int64 {
                return fileSize
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }

    
}
