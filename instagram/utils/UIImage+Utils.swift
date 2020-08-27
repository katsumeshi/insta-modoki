//
//  UIImage+Utils.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/26/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import UIKit

extension UIImage {
  //  func resized(targetSize: CGSize) -> UIImage {
  //    // Determine the scale factor that preserves aspect ratio
  //    let widthRatio = targetSize.width / size.width
  //    let heightRatio = targetSize.height / size.height
  //
  //    let scaleFactor = min(widthRatio, heightRatio)
  //
  //    // Compute the new image size that preserves aspect ratio
  //    let scaledImageSize = CGSize(
  //      width: size.width * scaleFactor,
  //      height: size.height * scaleFactor
  //    )
  //
  //    // Draw and return the resized UIImage
  //    let renderer = UIGraphicsImageRenderer(
  //      size: scaledImageSize
  //    )
  //
  //    let scaledImage = renderer.image { _ in
  //      self.draw(
  //        in: CGRect(
  //          origin: .zero,
  //          size: scaledImageSize
  //        ))
  //    }
  //
  //    return scaledImage
  //  }

  func resized(targetSize: CGSize) -> UIImage {
    let widthRatio = targetSize.width / size.width
    let heightRatio = targetSize.height / size.height
    let ratio = widthRatio < heightRatio ? widthRatio : heightRatio

    let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)

    UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
    draw(in: CGRect(origin: .zero, size: resizedSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return resizedImage!
  }

  func cropToBounds(width: Double, height: Double) -> UIImage {

    let cgimage = self.cgImage!
    let contextImage: UIImage = UIImage(cgImage: cgimage)
    let contextSize: CGSize = contextImage.size
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    var cgwidth: CGFloat = CGFloat(width)
    var cgheight: CGFloat = CGFloat(height)

    // See what size is longer and create the center off of that
    if contextSize.width > contextSize.height {
      posX = ((contextSize.width - contextSize.height) / 2)
      posY = 0
      cgwidth = contextSize.height
      cgheight = contextSize.height
    } else {
      posX = 0
      posY = ((contextSize.height - contextSize.width) / 2)
      cgwidth = contextSize.width
      cgheight = contextSize.width
    }

    let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

    // Create bitmap image from context using the rect
    let imageRef: CGImage = cgimage.cropping(to: rect)!

    // Create a new image based on the imageRef and rotate back to the original orientation
    let image: UIImage = UIImage(
      cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

    return image
  }
}
