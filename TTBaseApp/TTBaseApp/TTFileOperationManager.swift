//
//  FileOperationManager.swift
//  NMBaseApp
//
//  Created by Remzi YILDIRIM on 17.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol TTFileOperation {
    func saveFile(for sourceUrl: URL, at location: URL) throws -> URL
}

public class TTFileOperationManager: TTFileOperation {
    
    public static let shared = TTFileOperationManager()
    
    // Get local file path: download task stores here.
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let temporaryPath = FileManager.default.temporaryDirectory
    
    public func saveFile(for sourceUrl: URL, at location: URL) throws -> URL {
        let destinationURL = saveFilePath(for: sourceUrl)
        
        if fileExists(at: destinationURL) {
            try FileManager.default.removeItem(at: destinationURL)
        }
        try FileManager.default.copyItem(at: location, to: destinationURL)
        return destinationURL
    }
    
    func fileExists(fileName: String) -> Bool {
        let filePath = documentsPath.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: filePath.path)
    }
    
    func fileExists(at destinationUrl: URL) -> Bool {
        return FileManager.default.fileExists(atPath: destinationUrl.path)
    }
    
    func saveFilePath(for sourceUrl: URL) -> URL {
        let fileName = sourceUrl.lastPathComponent
        return documentsPath.appendingPathComponent(fileName)
    }
}
