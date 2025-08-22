//
//  ImageService.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import UIKit
import ImageIO

struct ImageLoader {
    static func loadImage(from url: URL,
                          completion: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error al descargar imagen:", error)
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let targetHeight = CGFloat(250)
            let targetWidth = UIScreen.main.bounds.width
            let maxPixelSize = max(targetHeight, targetWidth) * UIScreen.main.scale
            
            let options: [CFString: Any] = [
                kCGImageSourceShouldCache: false,
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceThumbnailMaxPixelSize: maxPixelSize
            ]
            
            guard let source = CGImageSourceCreateWithData(data as CFData, nil),
                  let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            let uiImage = UIImage(cgImage: cgImage)
            DispatchQueue.main.async { completion(uiImage) }
        }
        .resume()
    }
}

