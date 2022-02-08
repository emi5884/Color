import UIKit

extension AfterShootingViewController {
    
    @objc func hueSliderChanged(sender: UISlider) {
        
        huefilter.setValue(self.sourceImage, forKey: kCIInputImageKey)
        huefilter.setValue(sender.value, forKey: "inputAngle")
        
        guard let hueImage = huefilter.outputImage else { return }
        saturationFilter.setValue(hueImage, forKey: kCIInputImageKey)
        saturationFilter.setValue(self.saturationSliderValue, forKey: "inputSaturation")
        
        guard let saturationImage = saturationFilter.outputImage else { return }
        brightnessFilter.setValue(saturationImage, forKey: kCIInputImageKey)
        brightnessFilter.setValue(self.brightnessSliderValue, forKey: "inputEV")
        
        guard let brightnessImage = brightnessFilter.outputImage else { return }
        self.filteredImageView.image = UIImage(ciImage: brightnessImage)
        
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(brightnessImage, from: brightnessImage.extent) else { return }
        showColorInfoImage = UIImage(cgImage: cgImage)
        
        self.hueSliderValue = sender.value
        self.hueValueForLabel = Int(sender.value * 500)
        changeLabelValue(label: hueChangeValue, value: hueValueForLabel)
    }
    
    @objc func saturationSliderChanged(sender: UISlider) {
        
        saturationFilter.setValue(self.sourceImage, forKey: kCIInputImageKey)
        saturationFilter.setValue(sender.value, forKey: "inputSaturation")
        
        guard let saturationImage = saturationFilter.outputImage else { return }
        brightnessFilter.setValue(saturationImage, forKey: kCIInputImageKey)
        brightnessFilter.setValue(self.brightnessSliderValue, forKey: "inputEV")
        
        guard let brightnessImage = brightnessFilter.outputImage else { return }
        huefilter.setValue(brightnessImage, forKey: kCIInputImageKey)
        huefilter.setValue(self.hueSliderValue, forKey: "inputAngle")
        
        guard let hueImage = huefilter.outputImage else { return }
        self.filteredImageView.image = UIImage(ciImage: hueImage)
        
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(hueImage, from: hueImage.extent) else { return }
        showColorInfoImage = UIImage(cgImage: cgImage)
        
        self.saturationSliderValue = sender.value
        self.saturationValueForLabel = Int(sender.value * 100)
        self.saturationValueForLabel -= 100
        changeLabelValue(label: saturationChangeValue, value: saturationValueForLabel)
    }
    
    @objc func brightnessSliderChanged(sender: UISlider) {
        
        brightnessFilter.setValue(self.sourceImage, forKey: kCIInputImageKey)
        brightnessFilter.setValue(sender.value, forKey: "inputEV")
        
        guard let brightnessImage = brightnessFilter.outputImage else { return }
        saturationFilter.setValue(brightnessImage, forKey: kCIInputImageKey)
        saturationFilter.setValue(self.saturationSliderValue, forKey: "inputSaturation")
        
        guard let saturationImage = saturationFilter.outputImage else { return }
        huefilter.setValue(saturationImage, forKey: kCIInputImageKey)
        huefilter.setValue(self.hueSliderValue, forKey: "inputAngle")
        
        guard let hueImage = huefilter.outputImage else { return }
        self.filteredImageView.image = UIImage(ciImage: hueImage)
        
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(hueImage, from: hueImage.extent) else { return }
        showColorInfoImage = UIImage(cgImage: cgImage)
        
        self.brightnessSliderValue = sender.value
        self.brightnessValueForLabel = Int(sender.value * 100)
        changeLabelValue(label: brightnessChangeValue, value: brightnessValueForLabel)
    }
    
    @objc func didFinishTouching(sender: UISlider) {
        showColorInfo(image: showColorInfoImage, valueChanged: true)
    }
    
    func changeLabelValue(label: UILabel, value: Int) {
        
        if value > 0 {
            label.text = "+  \(value)"
        } else if value < 0 {
            label.text = "-  \(value * -1)"
        } else {
            label.text = "   \(value)"
        }
    }
}
