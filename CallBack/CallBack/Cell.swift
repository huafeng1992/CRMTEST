//
//  Cell.swift
//  CallBack
//
//  Created by 王华峰 on 2018/7/3.
//  Copyright © 2018年 hf. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

//MARK:- CRMDetailContactViewCell
class CRMDetailContactViewCell: UITableViewCell {
    
    weak var dateLab: UILabel?
    weak var descTitLab: UILabel?
    weak var contentLab: UILabel?
    weak var courseLab: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addAllView()
    }
    
    func addAllView() {
        let dateLab = UILabel()
        dateLab.font = UIFont.systemFont(ofSize: 12)
//        dateLab.textColor = CommonColor(Color999999)
//        dateLab.font = CommomFont(12)
        contentView.addSubview(dateLab)
        dateLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(16)
            make.right.equalToSuperview().offset(-12)
        }
        self.dateLab = dateLab
        
        let descTitLab = UILabel()
        descTitLab.font = UIFont.systemFont(ofSize: 12)
//        descTitLab.textColor = CommonColor(Color999999)
//        descTitLab.font = CommomFont(12)
        descTitLab.numberOfLines = 0
        descTitLab.lineBreakMode = .byCharWrapping
        contentView.addSubview(descTitLab)
        descTitLab.snp.makeConstraints { (make) in
            make.left.equalTo(dateLab)
            make.top.equalTo(dateLab.snp.bottom)
            make.right.equalTo(dateLab)
        }
        self.descTitLab = descTitLab
        
        let contentLab = UILabel()
        contentLab.font = UIFont.systemFont(ofSize: 14)
//        contentLab.textColor = CommonColor(Color333333)
//        contentLab.font = CommomFont(14)
        contentLab.numberOfLines = 0
        contentView.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(descTitLab.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-12)
        }
        self.contentLab = contentLab
        
        let courseLab = UILabel()
        courseLab.font = UIFont.systemFont(ofSize: 12)
//        courseLab.textColor = CommonColor(Color999999)
//        courseLab.font = CommomFont(12)
        courseLab.numberOfLines = 0
        courseLab.lineBreakMode = .byCharWrapping
        contentView.addSubview(courseLab)
        courseLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(contentLab.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-15)
        }
        self.courseLab = courseLab
    }
}
