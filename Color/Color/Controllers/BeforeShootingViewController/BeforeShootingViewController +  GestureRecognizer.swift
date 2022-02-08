import UIKit
import AVFoundation

extension BeforeShootingViewController: UIGestureRecognizerDelegate {

    // MARK: - Actions
    
    @objc func pinchedGesture(sender: UIPinchGestureRecognizer) {
        
        var originalZoomScale: CGFloat = 1.0
        
        do {
            let videoSetting = AVCaptureDevice.default(for: AVMediaType.video)
            try videoSetting!.lockForConfiguration()
            let maxZoomScale: CGFloat = 6.0
            let minZoomScale: CGFloat = 1.0
            var currentZoomScale: CGFloat = videoSetting!.videoZoomFactor
            let pinchZoomScale: CGFloat = sender.scale
            
            if pinchZoomScale > 1.0 {
                currentZoomScale = originalZoomScale + pinchZoomScale - 1
            } else {
                currentZoomScale = originalZoomScale - (1 - pinchZoomScale) * originalZoomScale
            }
            
            if currentZoomScale < minZoomScale {
                currentZoomScale = minZoomScale
            } else if currentZoomScale > maxZoomScale {
                currentZoomScale = maxZoomScale
            }
            
            if sender.state == .ended {
                originalZoomScale = currentZoomScale
            }
            
            videoSetting!.videoZoomFactor = currentZoomScale
            videoSetting!.unlockForConfiguration()
        } catch {
            return
        }
    }
    
    // MARK: - Helpers
    
    func setupPinchGesture() {
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchedGesture))
        pinchGesture.delegate = self
        self.view.addGestureRecognizer(pinchGesture)
        
        unableTapTopBlackArea.frame = CGRect(x: 0, y: 0,
                                             width: view.frame.width,
                                             height: topBlackSpaceHeight)
        unableTapTopBlackArea.backgroundColor = .black
        self.view.addSubview(unableTapTopBlackArea)
        
        unableTapBottomBlackArea.frame = CGRect(x: 0,
                                                y: view.frame.height - topBlackSpaceHeight,
                                                width: view.frame.width,
                                                height: topBlackSpaceHeight)
        unableTapBottomBlackArea.backgroundColor = .black
        self.view.addSubview(unableTapBottomBlackArea)
    }
}
