import UIKit

extension AfterShootingViewController {
    
    func showColorInfo(image: UIImage, valueChanged: Bool) {
        
        let imageWidth = Int(image.size.width)
        let imageHeight = Int(image.size.height)
        let pixelData = image.cgImage?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        colors = []
        colorDic = [:]
        topColors = []
        
        for x in 0..<imageWidth {
            for y in 0..<imageHeight {
                
                let point = CGPoint(x: x, y: y)
                let pixelInfo: Int = ((imageWidth * Int(point.y)) + Int(point.x)) * 4
                var color = UIColor()
                
                if valueChanged {
                    color = UIColor(red: CGFloat(data[pixelInfo]) / 255.0,
                                    green: CGFloat(data[pixelInfo + 1]) / 255.0,
                                    blue: CGFloat(data[pixelInfo + 2]) / 255.0,
                                    alpha: CGFloat(data[pixelInfo + 3]) / 255.0)
                } else {
                    color = UIColor(red: CGFloat(data[pixelInfo + 2]) / 255.0,
                                    green: CGFloat(data[pixelInfo + 1]) / 255.0,
                                    blue: CGFloat(data[pixelInfo]) / 255.0,
                                    alpha: CGFloat(data[pixelInfo + 3]) / 255.0)
                }
                getRGB(color: color)
            }
        }
        createColorData()
    }
    
    func getRGB(color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
            colors.append(color)
        }
    }
    
    func createColorData() {
        colors.forEach { colorDic[$0, default: 0] += 1 }
        let sortedDic = colorDic.sorted { $0.value > $1.value }
        
        for i in 0 ..< 100 {
            let color = sortedDic[i].key
            topColors.append(color)
        }
    }
}
