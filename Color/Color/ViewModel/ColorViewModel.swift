import UIKit
import ChameleonFramework

struct ColorViewModal {
    let color: UIColor
    
    var backgroundColor: UIColor {
        return color
    }
    
    var colorLabelText: String {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return String(NSString(format: "%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255)))
        }
        
        return ""
    }
    
    var colorLabelTextColor: UIColor {
        return ContrastColorOf(color, returnFlat: true)
    }
    
    init(color: UIColor) {
        self.color = color
    }
}
