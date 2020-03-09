//
//  CustomItemView.swift
//  NavigationBarView
//
//  Created by huangmian on 2018/7/30.
//  Copyright © 2018年 hm. All rights reserved.
//

import UIKit
import SnapKit
import SwifterSwift

class CustomItemView: UIView {
    var toggleAction: (()->Void)?
    
    private lazy var bgButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.system)
        button.titleLabel?.text = ""
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(bgButton)
        addSubview(titleLabel)
        addSubview(arrowImageView)
        bgButton.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        bgButton.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(UIEdgeInsetsMake(0, -1.5, 0, 0))
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(13.0)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(14.5)
            $0.right.equalToSuperview()
            $0.width.equalTo(9.0)
            $0.height.equalTo(5.5)
            $0.centerY.equalToSuperview()
        }
        arrowImageView.image = UIImage(named: "arrow_down")
    }
    
    @objc func buttonAction(button: UIButton) {
        print("buttonAction")
        toggleAction?()
    }
    
    func setTitleString(_ titleString: String) -> CGFloat {
        let attrStr = NSMutableAttributedString(string: titleString)
        let linebreak = NSMutableParagraphStyle.init()
        linebreak.lineBreakMode = NSLineBreakMode.byWordWrapping
        attrStr.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12.0),
                               NSAttributedStringKey.foregroundColor : UIColor.init(hexString: "#494949"),
                               NSAttributedStringKey.paragraphStyle : linebreak],
                              range: NSMakeRange(0,titleString.count))
        
        titleLabel.attributedText = attrStr
        titleLabel.sizeToFit()
        
        let maxWidth = UIScreen.main.bounds.width - 15 - 50
        var titleWidth = titleLabel.frame.size.width + 14.5 + 9.0
        if titleWidth > maxWidth {
            titleWidth = maxWidth
        }
        let frame = self.frame
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: titleWidth, height: 44)
        titleLabel.snp.updateConstraints {
            $0.width.equalTo(titleWidth - 14.5 - 9.0)
        }
        return titleWidth
    }
    
    deinit {
        print("CustomItemView deinit")
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexString = hexString
        if hexString.count < 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }
        
        var startIndex = hexString.startIndex
        if hexString.hasPrefix("0x"){
            startIndex = hexString.index(startIndex, offsetBy: 2)
            hexString = String(hexString[startIndex..<hexString.endIndex])
        }else if hexString.hasPrefix("#"){
            startIndex = hexString.index(startIndex, offsetBy: 1)
            hexString = String(hexString[startIndex..<hexString.endIndex])
        }
        
        if hexString.count != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        }else{
            var r: UInt32 = 0
            var g: UInt32 = 0
            var b: UInt32 = 0
            let redIndex = hexString.startIndex
            let redString = hexString[redIndex..<hexString.index(redIndex, offsetBy: 2)]
            let greenIndex = hexString.index(redIndex, offsetBy: 2)
            let greenString = hexString[greenIndex..<hexString.index(greenIndex, offsetBy: 2)]
            let blueIndex = hexString.index(redIndex, offsetBy: 4)
            let blueString = hexString[blueIndex..<hexString.endIndex]
            Scanner.init(string: String(redString)).scanHexInt32(&r)
            Scanner.init(string: String(greenString)).scanHexInt32(&g)
            Scanner.init(string: String(blueString)).scanHexInt32(&b)
            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        }
    }
}
