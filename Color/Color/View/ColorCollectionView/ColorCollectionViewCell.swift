import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModal: ColorViewModal? {
        didSet { configureUI() }
    }
    
    private let colorView = UIView()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.font = .infinity(size: 20)
        label.backgroundColor = .clear
        label.textAlignment = .center
        
        let angle = 90 * CGFloat.pi / 180
        let transrotate = CGAffineTransform(rotationAngle: angle)
        label.transform = transrotate
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(colorView)
        colorView.frame = bounds
        
        addSubview(colorLabel)
        
        let safeAreaTopHeight = Dimension.safeareaTopHeight
        colorLabel.frame = CGRect(x: 0,
                                  y: safeAreaTopHeight - 10,
                                  width: frame.width,
                                  height: frame.height - safeAreaTopHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        guard let viewModal = viewModal else { return }
        
        colorView.backgroundColor = viewModal.backgroundColor
        colorLabel.text = "# \(viewModal.colorLabelText)"
        colorLabel.textColor = viewModal.colorLabelTextColor
    }
}
