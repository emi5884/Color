import UIKit

// color - source color, which is must be replaced
// withColor - target color
// tolerance - value in range from 0 to 1
func replaceColor(color: UIColor, withColor: UIColor, image: UIImage, tolerance: CGFloat) -> UIImage {

    // This function expects to get source color(color which is supposed to be replaced)
    // and target color in RGBA color space, hence we expect to get 4 color components: r, g, b, a
    assert(color.cgColor.numberOfComponents == 4 && withColor.cgColor.numberOfComponents == 4,
           "Must be RGBA colorspace")

    // Allocate bitmap in memory with the same width and size as source image
    let imageRef = image.cgImage!
    let width = imageRef.width
    let height = imageRef.height

    let bytesPerPixel = 4
    let bytesPerRow = bytesPerPixel * width;
    let bitsPerComponent = 8
    let bitmapByteCount = bytesPerRow * height

    let rawData = UnsafeMutablePointer<UInt8>.allocate(capacity: bitmapByteCount)

    let context = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: CGColorSpace(name: CGColorSpace.genericRGBLinear)!,
                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)


    let rc = CGRect(x: 0, y: 0, width: width, height: height)

    // Draw source image on created context
    context!.draw(imageRef, in: rc)


    // Get color components from replacement color
    let withColorComponents = withColor.cgColor.components
    let r2 = UInt8(withColorComponents![0] * 255)
    let g2 = UInt8(withColorComponents![1] * 255)
    let b2 = UInt8(withColorComponents![2] * 255)
    let a2 = UInt8(withColorComponents![3] * 255)

    // Prepare to iterate over image pixels
    var byteIndex = 0

    while byteIndex < bitmapByteCount {

        // Get color of current pixel
        let red = CGFloat(rawData[byteIndex + 0]) / 255
        let green = CGFloat(rawData[byteIndex + 1]) / 255
        let blue = CGFloat(rawData[byteIndex + 2]) / 255
        let alpha = CGFloat(rawData[byteIndex + 3]) / 255

        let currentColor = UIColor(red: red, green: green, blue: blue, alpha: alpha);

        // Compare two colors using given tolerance value
        if compareColor(color: color, withColor: currentColor , withTolerance: tolerance) {

            // If the're 'similar', then replace pixel color with given target color
            rawData[byteIndex + 0] = r2
            rawData[byteIndex + 1] = g2
            rawData[byteIndex + 2] = b2
            rawData[byteIndex + 3] = a2
        }

        byteIndex = byteIndex + 4;
    }

    // Retrieve image from memory context
    let imgref = context!.makeImage()
    let result = UIImage(cgImage: imgref!)

    // Clean up a bit
    rawData.deallocate()

    return result
}

func compareColor(color: UIColor, withColor: UIColor, withTolerance: CGFloat) -> Bool {

    var r1: CGFloat = 0.0, g1: CGFloat = 0.0, b1: CGFloat = 0.0, a1: CGFloat = 0.0;
    var r2: CGFloat = 0.0, g2: CGFloat = 0.0, b2: CGFloat = 0.0, a2: CGFloat = 0.0;

    color.getRed(&r1, green: &g1, blue: &b1, alpha: &a1);
    withColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2);

    return abs(r1 - r2) <= withTolerance &&
        abs(g1 - g2) <= withTolerance &&
        abs(b1 - b2) <= withTolerance &&
        abs(a1 - a2) <= withTolerance;
}
