//
//  PhotoRecord.swift
//  ClassicPhoto
//
//  Created by 熊伟 on 2017/7/2.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

enum PhotoRecordState {
    case New, Downloaded, Filtered, Failed
}

class PhotoRecord {
    let name: String
    let url: URL
    var state = PhotoRecordState.New
    var image = UIImage(named: "Placeholder")
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}

class SessionWrapper {
    static func getData(_ url: String,
                        callback:@escaping ((Data?) -> Void),
                        errorCallback:@escaping ((Error) -> Void)) {
        var fullUrl:String = url
        if fullUrl.hasPrefix("http://")
        {
            let replacingRange = fullUrl.startIndex..<fullUrl.characters.index(fullUrl.startIndex, offsetBy: 4)
            fullUrl.replaceSubrange(replacingRange, with: "https")
        }
        
        let nsURL = URL(string: fullUrl)!
        let session = URLSession.shared
        let urlRequest = URLRequest(url: nsURL, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        
        let task = session.downloadTask(with: urlRequest) { (location, response, error) in
            
            guard error == nil else{
                errorCallback(error!)
                return
            }
            
            guard location != nil else {
                callback(nil)
                return
            }
            let data = try? Data(contentsOf: location!)
            DispatchQueue.main.async {
                callback(data)
            }
            
        }
        task.resume()
    }
}

class PendingOperations {
    lazy var downloadsInProgress = [IndexPath:Operation]()
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var filtrationsInProgress = [IndexPath:Operation]()
    lazy var filtrationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filtration queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class ImageDownloader: Operation {
    let photoRecord: PhotoRecord
    
    init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }
    
    /// Main is the function actually perform work.
    override func main() {
        /// Check for cancellation before starting.
        if isCancelled {
            return
        }
        
        do {
            let imageData = try Data(contentsOf: photoRecord.url)
            
            if self.isCancelled {
                return
            }
            
            if imageData.count > 0 {
                photoRecord.image = UIImage(data: imageData)
                photoRecord.state = .Downloaded
            } else {
                photoRecord.state = .Failed
                photoRecord.image = UIImage(named: "Failed")
            }
        } catch let error as NSError{
            print(error.domain)
        }
    }
}

class ImageFiltration: Operation {
    let photoRecord: PhotoRecord
    
    init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }
    
    func applySepiaFilter(image: UIImage) -> UIImage? {
        let inputImage = CIImage(data: UIImagePNGRepresentation(image)!)
        
        if isCancelled {
            return nil
        }
        
        let context = CIContext(options:nil)
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(0.8, forKey: "inputIntensity")
        
        if isCancelled {
            return nil
        }
        
        if let outputImage = filter?.outputImage,
            let outImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: outImage)
        } else {
            return nil
        }
    }
    
    override func main () {
        if isCancelled {
            return
        }
        
        if self.photoRecord.state != .Downloaded {
            return
        }
        
        if let image = photoRecord.image,
            let filteredImage = applySepiaFilter(image: image) {
            photoRecord.image = filteredImage
            photoRecord.state = .Filtered
        }
    }
}
