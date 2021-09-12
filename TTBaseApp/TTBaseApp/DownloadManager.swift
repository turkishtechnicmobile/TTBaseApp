//
//  DownloadManager.swift
//  TTBaseApp
//
//  Created by Remzi YILDIRIM on 17.02.2020.
//  Copyright © 2020 Turkish Technic. All rights reserved.
//

import Foundation

public protocol Download: AnyObject {
    var completion: ((DownloadResult<URL, Error>) -> Void)? { get set}
    func startDownload(for urlString: String)
}

public class DownloadManager: NSObject, Download {
    
    public static let shared = DownloadManager()
    @Inject var fileOperation: FileOperation

    var session : URLSession {
        get {
            let config = URLSessionConfiguration.default
//            config.requestCachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
//            config.urlCache = URLCache.shared
            return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        }
    }
    weak var dataTask: URLSessionDataTask?
    weak var downloadTask: URLSessionDownloadTask?
    
    public var completion: ((DownloadResult<URL, Error>) -> Void)?
    
    private let byteFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB]
        return formatter
    }()
    
    // information function
    public func startDownload(for urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        downloadTask?.cancel()
        
        // Don't specify a completion handler here or the delegate won't be called
        downloadTask = session.downloadTask(with: url)
        downloadTask?.resume()
    }
}

extension DownloadManager: URLSessionDelegate, URLSessionDownloadDelegate {
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            debugPrint("Task completed with Error: \(task), error: \(error)")
            completion?(.failure(error))
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let written = byteFormatter.string(fromByteCount: totalBytesWritten)
        let expected = byteFormatter.string(fromByteCount: totalBytesExpectedToWrite)
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        completion?(.progress(written, expected, progress))
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        var savedFilePath: URL!
        do {
            savedFilePath = try fileOperation.saveFile(for: sourceURL, at: location)
        } catch let error {
            debugPrint("Could not copy file to disk: \(error.localizedDescription)")
            completion?(.failure(error))
            return
        }
        
        completion?(.success(savedFilePath))
    }
}

public enum DownloadResult<Success, Failure> where Failure: Error {
    case progress(_ written: String, _ expected: String, _ progress: Float)
    case success(Success)
    case failure(Failure)
}
