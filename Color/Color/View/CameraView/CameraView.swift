import UIKit
import AVFoundation

class CameraView: UIView {
    
    // MARK: - Properties
    
    public let captureSession = AVCaptureSession()
    public let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blur)
        return effectView
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func setupCamera() {
        
        captureSession.sessionPreset = AVCaptureSession.Preset.medium
        
        if let videoDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                                     for: AVMediaType.video, position: .back) {
            
            do {
                videoDevice.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: 30)
                
                try videoDevice.lockForConfiguration()
                videoDevice.whiteBalanceMode = .locked
                videoDevice.whiteBalanceMode = .continuousAutoWhiteBalance
                videoDevice.unlockForConfiguration()
                
                let videoInput = try AVCaptureDeviceInput.init(device: videoDevice)
                if(captureSession.canAddInput(videoInput)) {
                    captureSession.addInput(videoInput)
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        
        if(captureSession.canAddOutput(videoDataOutput)) {
            captureSession.addOutput(videoDataOutput)
        }
        captureSession.startRunning()
    }
    
    func configureUI() {
        previewImageView.frame = frame
        addSubview(previewImageView)
        
        blurView.frame = previewImageView.frame
        previewImageView.addSubview(blurView)
        
        let videoLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        videoLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        previewImageView.layer.addSublayer(videoLayer)
    }
}
