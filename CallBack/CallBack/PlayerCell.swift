//
//  PlayerCell.swift
//  CallBack
//
//  Created by 王华峰 on 2018/7/3.
//  Copyright © 2018年 hf. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CRMDetailContactPlayerViewCell: UITableViewCell {
    
    weak var dateLab: UILabel?
    weak var contentLab: UILabel?
    weak var playerView: PlayerView?
    
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
        
        let contentLab = UILabel()
        dateLab.font = UIFont.systemFont(ofSize: 14)
//        contentLab.textColor = CommonColor(Color333333)
//        contentLab.font = CommomFont(14)
        contentLab.numberOfLines = 0
        //        contentLab.lineBreakMode = .byCharWrapping
        contentView.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(dateLab.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-12)
        }
        self.contentLab = contentLab
        
        let playerView = PlayerView()
        playerView.backgroundColor = .white
        playerView.layer.borderColor = CommonColor("#E1E1E1").cgColor
        playerView.layer.borderWidth = 0.5
        contentView.addSubview(playerView)
        playerView.snp.makeConstraints{
            $0.top.equalTo(contentLab.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.height.equalTo(64)
            $0.bottom.equalToSuperview().offset(-15)
        }
        self.playerView = playerView

        let url = URL.init(string: "http://xiaohe-online.oss-cn-beijing.aliyuncs.com/emulation/audios/homework/02DF4E50AF20688B4F0F0464EF625B381528885269.mp3")
        playerView.setMedia(url: url!, totalTime: 300)
    }
}
