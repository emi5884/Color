import UIKit
import AVFoundation
import ChameleonFramework

class BeforeShootingViewController: UIViewController {
    
    // MARK: - properties
    
    public let imageWidth = Dimension.imageWidth
    public let imageHeight = Dimension.imageHeight
    public var topBlackSpaceHeight = Dimension.topBlackSpaceHeight
    
    public let unableTapTopBlackArea = UIButton()
    public let unableTapBottomBlackArea = UIButton()
    
    public var modifiedImage = UIImage()
    public let filteredImageView = UIImageView()
    
    public let cameraView = CameraView()
    
    public lazy var shootingButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 40
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(onClickShootingButton(sender:)), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "circle").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setupPinchGesture()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Dimension.safeareaTopHeight = view.safeAreaInsets.top
    }
    
    // MARK: - Helpers
    
    func setupUI() {
        view.addSubview(cameraView)
        cameraView.frame = view.frame
        
        self.shootingButton.frame = CGRect(x: 0,
                                           y: 0,
                                           width: 80,
                                           height: 80)
        self.shootingButton.center.x = view.frame.width / 2
        self.shootingButton.center.y = view.frame.height - topBlackSpaceHeight / 2
        self.view.addSubview(shootingButton)
    }
    
    // MARK: - Actions
    
    @objc func onClickShootingButton(sender: UIButton) {
        self.shootingButton.removeFromSuperview()
    }
}
