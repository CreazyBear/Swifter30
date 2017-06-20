//
//  UILabelViewController.swift
//  UIElements
//
//  Created by 熊伟 on 2017/6/20.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class UILabelViewController: UIViewController {

    lazy var label:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.yellow
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 20)
        label.text = "Hello Swift"
        return label
    }()
    lazy var label2:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.yellow
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRect.init(x: 0, y: 130, width: UIScreen.main.bounds.width, height: 20)
        label.text = "Hello Swift"
        label.sizeToFit()
        return label
    }()
    
    lazy var label3:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.yellow
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRect.init(x:25, y: 160, width: UIScreen.main.bounds.width-50, height: 20)
        label.text = "Hello Swift"
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        return label
    }()
    
    
    lazy var label4:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.yellow
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRect.init(x: 0, y: 190, width: UIScreen.main.bounds.width, height: 20)
        label.text = "Hello Swift"
        label.textAlignment = .center
        return label
    }()
    
    var testLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "Label"
        
        self.view.addSubview(self.label)
        self.view.addSubview(self.label2)
        self.view.addSubview(self.label3)
        self.view.addSubview(self.label4)
        
        
        
        
        //MARK: - 富文本
        self.testLabel = UILabel.init(frame: CGRect.init(x: 10, y: 210, width: self.view.bounds.width-20, height: self.view.bounds.height-200))
        
        
        let text:String = "途牛旅游网于2006年10月创立于南京，以“让旅游更简单”为使命，为消费者提供由北京、天津、上海、广州、深圳、南京等64个城市出发的旅游产品预订服务，产品全面，价格透明，全年365天24小时400电话预订，并提供丰富的后续服务和保障。\n      途牛旅游网提供8万余种旅游产品供消费者选择，涵盖跟团、自助、自驾、邮轮、酒店、签证、景区门票以及公司旅游等，已成功服务累计超过400万人次出游。2014年12月15日，途牛旅游网宣布与弘毅投资、京东商城、携程旗下子公司“携程投资”以及途牛首席执行官与首席运营官签订股权认购协议。根据协议途牛将向上述投资者出售1.48亿美元的新发行股份。[1]\n       2015年11月24日，途牛旅游网与海航旅游集团共同宣布战略结盟。海航旅游战略投资途牛5亿美元，双方将利用各自优质资源，在线上旅游、航空、酒店服务等领域开展深度合作。[2]易观报告显示，2015年第3季度，途牛交易规模达到46.5亿元人民币，同比增长141.1%。这已是途牛连续三个季度同比增速超过三位数：2015年第二季度时，途牛交易规模同比增长135.3%；第一季度，这一数据为122.8%。\n        从增速来看，途牛再度蝉联行业第一。[3]以全年业绩来看，途牛2015年的净收入为76亿元人民币(合11.802亿美元)，较2014年增长116.3%。收入增长主要来自于跟团游、自助游及其他收入的增长。2015年总出游人次为4449053，较2014年的2181834人次增长103.9%。[4]adfasdfadf"
        
        let stringLen = text.characters.count
        
        let attrString = NSMutableAttributedString(string: text)
        
        //设置字体
        let attrFont = UIFont.systemFont(ofSize: 13.0)
        attrString.addAttribute(NSFontAttributeName, value: attrFont, range: NSRange(location: 0, length: stringLen))
        
        //设置倾斜，需要导入coreText
        //FIXME: 字母，数据，符号出现倾斜，而汉字没有影响
        let italicFont = self.GetVariationOfFontWithTrait(baseFont: attrFont, trait: .traitItalic)
        attrString.addAttribute(NSFontAttributeName, value: italicFont, range: NSRange(location: 0, length: stringLen))
        
        // 设置颜色:字体颜色，背景颜色
        attrString.addAttribute(NSForegroundColorAttributeName, value:UIColor.red, range:NSString(string:text).range(of: "途牛"))
        attrString.addAttribute(NSBackgroundColorAttributeName, value:UIColor.blue, range:NSString(string:text).range(of: "南京"))
        
        //段落样式
        let style:NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.lineSpacing = 10;//增加行高
        style.headIndent = 10;//头部缩进，相当于左padding
        style.tailIndent = -10;//相当于右padding
        style.lineHeightMultiple = 1.5;//行间距是多少倍
        style.alignment = .left;//对齐方式
        style.firstLineHeadIndent = 20;//首行头缩进
        style.paragraphSpacing = 10;//段落后面的间距
        style.paragraphSpacingBefore = 20;//段落之前的间距
        attrString.addAttribute(NSParagraphStyleAttributeName, value:style, range:NSMakeRange(0, stringLen))
        
        self.testLabel?.attributedText = attrString
        self.testLabel?.numberOfLines = 0
        self.view.addSubview(self.testLabel!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //获取斜体
    func GetVariationOfFontWithTrait(baseFont:UIFont, trait:CTFontSymbolicTraits)->UIFont {
        let fontSize:CGFloat  = baseFont.pointSize
        let baseFontName:CFString = baseFont.fontName as CFString
        let baseCTFont:CTFont = CTFontCreateWithName(baseFontName, fontSize, nil)
        let ctFont:CTFont = CTFontCreateCopyWithSymbolicTraits(baseCTFont, 0, nil, trait, trait)!
        let variantFontName:NSString = CTFontCopyName(ctFont, kCTFontPostScriptNameKey)!
        let variantFont:UIFont = UIFont.init(name:variantFontName as String, size: fontSize)!
        return variantFont;
    }

}
