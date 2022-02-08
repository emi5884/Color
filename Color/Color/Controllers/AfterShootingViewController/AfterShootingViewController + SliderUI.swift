import UIKit

enum sliderType {
    case hue
    case saturation
    case brightness
}

extension AfterShootingViewController {
    
    // MARK: - Actions
    
    @objc func showSliderModal() {
        let closeButtonHeight: CGFloat = 50
        let sliderBaseViewHeight = topBlackSpaceHeight + closeButtonHeight + view.safeAreaInsets.bottom + 12
        
        UIView.animate(withDuration: 0.25) {
            self.sliderBaseView.frame.origin.y = self.view.frame.height - sliderBaseViewHeight
            self.effectBlurView.frame.origin.y = self.view.frame.height - sliderBaseViewHeight
        }
    }
    
    @objc func closeSliderModal() {
        UIView.animate(withDuration: 0.25) {
            self.sliderBaseView.frame.origin.y = self.view.frame.height
            self.effectBlurView.frame.origin.y = self.view.frame.height
        }
    }
    
    // MARK: - Helpers
    
    func createSlider(y: CGFloat, value: Float, minValue: Float, maxValue: Float, image: UIImage, type: sliderType) {
        let slider = UISlider(frame: CGRect(x: 95,
                                            y: y,
                                            width: view.frame.size.width -  115,
                                            height: 80))
        slider.value = value
        slider.minimumValue = minValue
        slider.maximumValue = maxValue
        slider.minimumTrackTintColor = .lightGray.withAlphaComponent(0.5)
        slider.maximumTrackTintColor = .lightGray.withAlphaComponent(0.5)
        slider.setThumbImage(image, for: .normal)
        slider.addTarget(self, action: #selector(didFinishTouching(sender:)), for: .touchUpInside)
        
        switch type {
        case .hue:
            slider.addTarget(self, action: #selector(hueSliderChanged(sender:)), for: .valueChanged)
        case .saturation:
            slider.addTarget(self, action: #selector(saturationSliderChanged(sender:)), for: .valueChanged)
        case .brightness:
            slider.addTarget(self, action: #selector(brightnessSliderChanged(sender:)), for: .valueChanged)
        }
        
        sliderBaseView.addSubview(slider)
    }
    
    func createSliderValueLabel(positionY: CGFloat) -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: positionY, width: 70, height: 80)
        label.textColor = .white
        label.font = .infinity(size: 30)
        return label
    }
    
    func setupSliderModal() {
        
        let closeButtonHeight: CGFloat = 50
        let sliderBaseViewHeight = topBlackSpaceHeight + closeButtonHeight + view.safeAreaInsets.bottom + 12
        
        let sliderBaseViewFrame = CGRect(x: 0,
                                         y: view.frame.height,
                                         width: view.frame.width,
                                         height: sliderBaseViewHeight)
        
        setupBlurView(sliderBaseViewFrame: sliderBaseViewFrame)
        
        sliderBaseView.frame =  sliderBaseViewFrame
        sliderBaseView.layer.cornerRadius = 30
        view.addSubview(sliderBaseView)
        
        createSlider(y: 50, value: 0, minValue: -0.2, maxValue: 0.2, image: #imageLiteral(resourceName: "hue"), type: .hue)
        
        hueChangeValue.text = "   \(hueValueForLabel)"
        sliderBaseView.addSubview(hueChangeValue)
        
        createSlider(y: 100, value: 1, minValue: 0, maxValue: 2, image: #imageLiteral(resourceName: "contract"), type: .saturation)
        
        saturationChangeValue.text = "   \(saturationValueForLabel)"
        sliderBaseView.addSubview(saturationChangeValue)
        
        createSlider(y: 150, value: 0, minValue: -1, maxValue: 1, image: #imageLiteral(resourceName: "brightness"), type: .brightness)
        
        brightnessChangeValue.text = "   \(brightnessValueForLabel)"
        sliderBaseView.addSubview(brightnessChangeValue)
        
        setupCloseButton(closeButtonHeight: closeButtonHeight)
        setupSliderModalButton()
    }
    
    func setupBlurView(sliderBaseViewFrame: CGRect) {
        let blur = UIBlurEffect(style: .light)
        effectBlurView.effect = blur
        effectBlurView.frame = sliderBaseViewFrame
        effectBlurView.layer.cornerRadius = 30
        effectBlurView.clipsToBounds = true
        view.addSubview(effectBlurView)
    }
    
    func setupSliderModalButton() {
        
        let buttonWidth: CGFloat = 60
        let showSliderModalButtonFrame = CGRect(x: view.frame.width - buttonWidth - 10,
                                                y: topBlackSpaceHeight + 10,
                                                width: buttonWidth, height: buttonWidth)
        let blur = UIBlurEffect(style: .light)
        let buttonBackground = UIVisualEffectView(effect: blur)
        buttonBackground.alpha = 0.9
        buttonBackground.frame = showSliderModalButtonFrame
        buttonBackground.layer.cornerRadius = buttonWidth / 2
        buttonBackground.clipsToBounds = true
        view.addSubview(buttonBackground)
        
        let showSliderModalButton = UIButton()
        showSliderModalButton.frame = showSliderModalButtonFrame
        showSliderModalButton.addTarget(self, action: #selector(showSliderModal), for: .touchUpInside)
        showSliderModalButton.setImage(#imageLiteral(resourceName: "slider"), for: .normal)
        showSliderModalButton.layer.cornerRadius = buttonWidth / 2
        showSliderModalButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.addSubview(showSliderModalButton)
    }
    
    func setupCloseButton(closeButtonHeight: CGFloat) {
        let closeSliderButton = UIButton()
        closeSliderButton.frame = CGRect(x: sliderBaseView.frame.width - 60,
                                         y: 10,
                                         width: closeButtonHeight,
                                         height: closeButtonHeight)
        closeSliderButton.addTarget(self, action: #selector(closeSliderModal), for: .touchUpInside)
        closeSliderButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        closeSliderButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        sliderBaseView.addSubview(closeSliderButton)
    }
}
