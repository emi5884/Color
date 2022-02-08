import UIKit

extension UIFont {
    
    static func infinity(size: CGFloat) -> UIFont {
        return UIFont(name: "Infinity", size: size) ?? .systemFont(ofSize: size)
    }
}
