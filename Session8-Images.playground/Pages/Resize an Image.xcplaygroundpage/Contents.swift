//: [Previous](@previous)

import Foundation
import UIKit
import ImageIO

/// Resize an image based on a scale factor
func resize(image: UIImage, scale: CGFloat) -> UIImage {
  let size = image.size.applying(CGAffineTransform(scaleX: scale,y: scale))
  let hasAlpha = true
  
  // Automatically use scale factor of main screen
  let scale: CGFloat = 0.0
  
  UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
  image.draw(in: CGRect(origin: CGPoint.zero, size: size))
  let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  return scaledImage!
}




let image = UIImage(named: "pokemon")

let scaledImage = resize(image: image!, scale: 0.1)



//: [Next](@next)
