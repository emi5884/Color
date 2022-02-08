import UIKit

extension UIImage {
    
    static func modifyImageDirection(image : UIImage, width: CGFloat, height: CGFloat, blendemode: CGBlendMode) -> UIImage! {
        
        UIGraphicsBeginImageContext(CGSize(width: width, height:height))
        image.draw(in: CGRect(x:0, y:0, width:image.size.width, height:image.size.height), blendMode: blendemode, alpha: 1)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func createImage(image: UIImage , width: CGFloat, height: CGFloat) -> UIImage! {
        
        UIGraphicsBeginImageContext(CGSize(width: width, height:height))
        
        image.draw(in: CGRect(x:0,
                              y:0, width:image.size.width,
                              height:image.size.height), blendMode: .clear, alpha: 1)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func croppingImage(to: CGRect) -> UIImage? {
        var opaque = false
        
        if let cgImage = cgImage {
            switch cgImage.alphaInfo {
            case .noneSkipLast, .noneSkipFirst:
                opaque = true
            default:
                break
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(to.size, opaque, scale)
        
        draw(at: CGPoint(x: -to.origin.x, y: -to.origin.y))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}
