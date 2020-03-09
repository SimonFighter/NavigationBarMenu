//
//  CustomListCell.swift
//  NavigationBarView
//
//  Created by huangmian on 2018/7/30.
//  Copyright © 2018年 hm. All rights reserved.
//

import UIKit

class CustomListCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.init(hexString: "#63c6f9")
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    private lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(selectedImageView)
        //selectedImageView.image = #imageLiteral(resourceName: "cell_selected")
        titleLabel.text = ""
        titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(UIEdgeInsetsMake(15, 15, 15, 15))
            $0.right.lessThanOrEqualTo(selectedImageView.snp.left).offset(15)
        }
        
        selectedImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-15)
        }
    }
    
    func setSelected(_ selected: Bool) {
        selectedImageView.isHidden = !selected
        titleLabel.textColor = selected ? UIColor.init(hexString: "#63c6f9") : UIColor.init(hexString: "#494949")
        
    }
    
    func setTitle(_ titleString: String) {
        titleLabel.text = titleString
    }
}

class CustomListAddCell: UITableViewCell {
    var addTapped: (()->Void)?
    private lazy var addButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("+添加新音箱", for: UIControlState.normal)
        button.setTitleColor(UIColor.init(hexString: "#494949"), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        button.borderColor = UIColor.init(hexString_: "#898989")
//        button.cornerRadius = 15
//        button.borderWidth = 1.0
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.white
        contentView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addAction), for: UIControlEvents.touchUpInside)
        addButton.snp.makeConstraints {
            $0.width.equalTo(140)
            $0.height.equalTo(30)
            $0.top.bottom.equalToSuperview().inset(UIEdgeInsetsMake(20, 0, 20, 0))
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func addAction(button: UIButton) {
        print("addAction")
        addTapped?()
    }
}
