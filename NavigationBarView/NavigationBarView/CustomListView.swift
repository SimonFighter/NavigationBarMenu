//
//  CustomListView.swift
//  NavigationBarView
//
//  Created by huangmian on 2018/7/30.
//  Copyright © 2018年 hm. All rights reserved.
//

import UIKit
import SwifterSwift

class CustomListView: UIView {
    var dataList = [String]()
    var maxHeight = UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height - 44 - 49
    var addTapped: (()->Void)?
    
    private lazy var bgButton: UIButton = {
        let button = UIButton.init()
        return button
    }()
    
    private lazy var bgView: UIView = {
        let bgView = UIView.init()
        return bgView
    }()
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    var addCell:CustomListAddCell?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        setupViews()
        resetFrame()
        loadData()
    }
    
    func loadData() {
        
    }
    
    func resetFrame(){
        var totalHeight:CGFloat = 0.0
        if self.dataList.count == 0 {
            totalHeight = 70.0
        }else{
            totalHeight = CGFloat(45 * self.dataList.count + 70)
        }
        
        if totalHeight > maxHeight {
            totalHeight = maxHeight
        }
        
        bgView.snp.updateConstraints {
            $0.left.right.top.bottom.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, maxHeight - totalHeight, 0))
        }
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: CGFloat(maxHeight))
    }
    
    func setMaxeight(_ maxH:CGFloat){
        maxHeight = maxH
        resetFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.clear
        addSubview(bgButton)
        addSubview(bgView)
        
        CustomListView.setMaskBackGroundColoer(bgView)
        bgView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.isUserInteractionEnabled = true
        tableView.register(cellWithClass: CustomListCell.self)
        tableView.register(cellWithClass: CustomListAddCell.self)
        tableView.showsVerticalScrollIndicator = false
        addCell = tableView.dequeueReusableCell(withClass: CustomListAddCell.self)
        addCell?.addTapped = { [weak self] in
            print("addCell Add")
            self?.addTapped?()
            self?.dissMiss()
            
        }
        
        bgButton.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        bgButton.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        bgView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        tableView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview().inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
    }
    
    @objc func buttonAction(button: UIButton) {
        print("buttonAction")
        self.dissMiss()
    }
    
    func isShowing() ->Bool {
        return !self.isHidden
    }
    
    func show(){
        self.isHidden = false
        self.loadData()
    }
    
    @objc func dissMiss(){
        self.isHidden = true
    }
    
    static func setMaskBackGroundColoer(_ view:UIView) {
        
        view.backgroundColor = UIColor.white
        view.alpha = 0.95
        view.layer.shadowColor = UIColor.init(hexString: "#b6b6b6", alpha: 0.6).cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        view.layer.shadowRadius = 0.5
    }
    
    deinit {
        print("CustomListView deinit")
    }
}

extension CustomListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
