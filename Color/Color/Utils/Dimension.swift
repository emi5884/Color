import UIKit

struct Dimension {
    
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    static var viewWidth: CGFloat {
        return screenBounds.width
    }
    
    static var viewHeight: CGFloat {
        return screenBounds.height
    }
    
    // 画像の幅 (AVCaptureSession.Preset.mediumの場合)
    static var imageWidth: CGFloat {
        return 360
    }
    
    // 画像の高さ (AVCaptureSession.Preset.mediumの場合)
    static var imageHeight: CGFloat {
        return 480
    }
    
    static var topBlackSpaceHeight: CGFloat {
        return (viewHeight - imageHeight * 1.04) / 2
    }
    
    static var startShootingButtonHeight: CGFloat {
        return 50
    }
    
    static var captureAreaSize: CGFloat {
        return 50
    }
    
    static var xRatioOfPreViewImageAndCaptureImage: CGFloat {
        return imageWidth / viewWidth
    }
    
    static var safeareaTop: CGFloat = 0
    
    static var safeareaTopHeight: CGFloat {
        get {
            return safeareaTop
        }
        set(height) {
            safeareaTop = height
        }
    }
}
