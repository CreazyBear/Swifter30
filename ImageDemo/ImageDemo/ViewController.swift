//
//  ViewController.swift
//  ImageDemo
//
//  Created by Bear on 2017/8/18.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var image : UIImageView = {
        
        let view = UIImageView.init(image: #imageLiteral(resourceName: "image.jpg"))
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = UIColor.gray
        return view
    
    }()

    lazy var smallImage : UIImageView = {
        
        let view = UIImageView.init()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = UIColor.gray
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(image)
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        image.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        testUIViewContentMode()
        testViewImage()
    }
    
    func testCropImage() {
        view.addSubview(smallImage)
        smallImage.image = image.image?.getSubImage(rect: CGRect(x: 300, y: 100, width: 100, height: 100))
        smallImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
        smallImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        smallImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func testScaleSizeImage() {
        view.addSubview(smallImage)
        smallImage.image = image.image?.scaleTo(size: CGSize(width: 100, height: 100))
        smallImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
        smallImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        smallImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func testScaleRadioImage() {
        view.addSubview(smallImage)
        smallImage.image = image.image?.scaleRadio(radio: 10)
        smallImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
    }
    
    func testUIViewContentMode() {
        image.contentMode = .scaleToFill
    }
    
    
    /// 类似andorid .9的图片，用于拉伸图片
    func testStretchImage() {
        view.addSubview(smallImage)
        let originImage = #imageLiteral(resourceName: "qipao.png")
        let mirroredImage = UIImage.init(cgImage: originImage.cgImage!, scale: 1, orientation: .upMirrored)
// Deperated
//        let stretchedImage = mirroredImage.stretchableImage(withLeftCapWidth: 19, topCapHeight: 19)
        let stretchedImage = mirroredImage.resizableImage(withCapInsets: UIEdgeInsetsMake(19, 19, mirroredImage.size.width, mirroredImage.size.height), resizingMode: .stretch)
        smallImage.image = stretchedImage
        smallImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
        smallImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func testColorImage() {
        view.addSubview(smallImage)
        smallImage.image = UIImage.colorImage(color: UIColor.green, size: CGSize(width: 100, height: 100))
        smallImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
        
        //oc 有下面这个方法拿到图片颜色，swift没有了。这个方法能做到什么程序，等之后有空再说
        //[UIColor colorWithPatternImage:[UIImageimageNamed:@"EmailBackground.png"]]
    }
    
    func testTextImage() {
        view.addSubview(smallImage)
        let attr = [NSFontAttributeName:UIFont.systemFont(ofSize: 20)]
        smallImage.image = UIImage.textImage(text: "1", attribute: attr, size: CGSize(width: 100, height: 100))
        smallImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
    }
    
    func testViewImage() {
        let label : UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "X"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 50
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 3
        label.textAlignment = .center
        
        view.addSubview(smallImage)
        var viewImage = UIImage.viewImage(view: label)
        guard viewImage?.size != nil else {
            return
        }

//两种方式可以创建圆形图片，最简单的是使用view.layer.masksToBounds = true，而且视觉效果好。不过好像会有啥离屏渲染的性能问题
//        UIGraphicsBeginImageContext((viewImage?.size)!);
//        let path = UIBezierPath(roundedRect:CGRect.init(x: 0, y: 0, width: (viewImage?.size.width)!, height: (viewImage?.size.height)!), cornerRadius: 50)
//        path.addClip()
//        viewImage?.draw(at: CGPoint.zero)
//        viewImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        smallImage.image = viewImage
        smallImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        smallImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30).isActive = true
    }
}

extension UIImage
{
    
    /// 创建纯色图片
    ///
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片的大小
    /// - Returns: 纯色图片UIImage
    static func colorImage(color : UIColor, size : CGSize ) -> UIImage? {
        
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(color.cgColor)
        currentContext?.fill(bounds)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        return resultImage!
    }
    
    
    /// 文本转图片
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - attribute: 文本富文本属性
    ///   - size: 图片大小
    /// - Returns: UIImage
    static func textImage(text:NSString, attribute:Dictionary<String, Any>?, size:CGSize) -> UIImage?
    {
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        text.draw(in: bounds, withAttributes: attribute)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    
    /// 将View转换成图片
    ///
    /// - Parameter view: 需要转换的View
    /// - Returns: UIImage
    static func viewImage(view : UIView) -> UIImage?
    {
        view.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        if view.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        else{
            let currentContext = UIGraphicsGetCurrentContext()
            guard currentContext != nil else {
                return nil
            }
            view.layer.render(in: currentContext!)
        }
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    
    
    /// 截取部分图像
    func getSubImage(rect : CGRect) -> UIImage {
        guard self.cgImage != nil else {
            return self
        }
        let croppedCGImage = self.cgImage!.cropping(to: rect)
        guard croppedCGImage != nil else {
            return self
        }
        let drawBounds = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        UIGraphicsBeginImageContext(drawBounds.size)
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.draw(croppedCGImage!, in: drawBounds)
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        UIGraphicsEndImageContext()
        return croppedImage
    }
    
    /// 放缩图片到指定尺寸
    ///
    /// - Parameter size: 目标尺寸
    /// - Returns: 目标UIImage
    func scaleTo(size: CGSize) -> UIImage {
        guard size.width >= 0 , size.height >= 0 else {
            return self
        }
        let destinationBounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(destinationBounds.size, false, 0.0);
        self.draw(in: destinationBounds)
        let destinationImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        guard destinationImage != nil else {
            return self
        }
        return destinationImage!
    }
    
    
    /// 按比例缩放图片
    ///
    /// - Parameter radio: 缩放比例
    /// - Returns: 缩放后的UIImage
    func scaleRadio(radio:CGFloat) -> UIImage {
        guard radio > 0 else {
            return self
        }
        guard self.cgImage != nil else {
            return self
        }
        let resultImage = UIImage.init(cgImage: self.cgImage!, scale: radio, orientation: self.imageOrientation)
        return resultImage
    }
    
    /**
     听说某司用的就是这一压缩算法
     图片压缩的逻辑:
     一:图片尺寸压缩 主要分为以下几种情况 一般参照像素为targetPx
     a.图片宽高均≤targetPx时，图片尺寸保持不变;
     b.宽或高均＞targetPx时 ——图片宽高比≤2，则将图片宽或者高取大的等比压缩至targetPx; ——但是图片宽高比＞2时，则宽或者高取小的等比压缩至targetPx;
     c.宽高一个＞targetPx，另一个＜targetPx，--图片宽高比＞2时，则宽高尺寸不变;--但是图片宽高比≤2时,则将图片宽或者高取大的等比压缩至targetPx.
     
     二:图片质量压缩: 对于超过大小阈值的图片进行质量压缩，但不保证压缩后的大小
     一般图片质量都压缩在90%就可以了
     */
    func conpressImageView(targetPx:CGFloat, thresholdSize_KB:Int = 200)->Data?
    {
        var newImage:UIImage!  // 尺寸压缩后的新图片
        let imageSize:CGSize = self.size // 源图片的size
        let width:CGFloat = imageSize.width // 源图片的宽
        let height:CGFloat = imageSize.height // 原图片的高
        var drawImge:Bool = false    // 是否需要重绘图片 默认是NO
        var scaleFactor:CGFloat = 0.0   // 压缩比例
        var scaledWidth:CGFloat = targetPx   // 压缩时的宽度 默认是参照像素
        var scaledHeight:CGFloat = targetPx  // 压缩是的高度 默认是参照像素
        
        if width <= targetPx,height <= targetPx {
            newImage = self
        }
        else if width >= targetPx , height >= targetPx {
            drawImge = true
            let factor:CGFloat = width / height
            if factor <= 2 {
                // b.1图片宽高比≤2，则将图片宽或者高取大的等比压缩至targetPx
                scaleFactor = width > height ? targetPx/width : targetPx/height
            } else {
                // b.2图片宽高比＞2时，则宽或者高取小的等比压缩至targetPx
                scaleFactor = width > height ? targetPx/height : targetPx/width
            }
            
        }
            // c.宽高一个＞targetPx，另一个＜targetPx 宽大于targetPx
        else if width >= targetPx , height <= targetPx {
            if width / height > 2 {
                newImage = self;
            } else {
                drawImge = true;
                scaleFactor = targetPx / width;
            }
        }
            // c.宽高一个＞targetPx，另一个＜targetPx 高大于targetPx
        else if width <= targetPx , height >= targetPx {
            if height / width > 2 {
                newImage = self;
            } else {
                drawImge = true;
                scaleFactor = targetPx / height;
            }
        }
        
        // 如果图片需要重绘 就按照新的宽高压缩重绘图片
        if drawImge {
            scaledWidth = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            UIGraphicsBeginImageContext(CGSize(width:scaledWidth,height:scaledHeight));
            // 绘制改变大小的图片
            self.draw(in: CGRect.init(x: 0, y: 0, width: scaledWidth, height: scaledHeight))
            // 从当前context中创建一个改变大小后的图片
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            // 使当前的context出堆栈
            UIGraphicsEndImageContext();
        }
        // 如果图片大小大于200kb 在进行质量上压缩
        var scaledImageData:Data? = nil;
        guard newImage != nil else {
            return nil;
        }
        
        if (UIImageJPEGRepresentation(newImage!, 1) == nil) {
            scaledImageData = UIImagePNGRepresentation(newImage);
        }else{
            scaledImageData = UIImageJPEGRepresentation(newImage, 1);
            guard scaledImageData != nil else {
                return nil
            }
            if scaledImageData!.count >= 1024 * thresholdSize_KB {
                //压缩大小，但并不一定能一次到位，有需有可以for循环压缩
                //scaledImageData > 1024 * thresholdSize_KB
                scaledImageData = UIImageJPEGRepresentation(newImage, 0.9);
            }
        }
        
        return scaledImageData
    }

}




