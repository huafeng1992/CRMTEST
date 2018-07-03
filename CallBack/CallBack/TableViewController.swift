//
//  TableViewController.swift
//  CallBack
//
//  Created by 王华峰 on 2018/7/2.
//  Copyright © 2018年 hf. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kw, height: kh), style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CRMDetailContactViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CRMDetailContactPlayerViewCell.self, forCellReuseIdentifier: "playerCell")
        view.addSubview(tableView)
    }
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 || indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! CRMDetailContactPlayerViewCell
            cell.dateLab?.text = "2016-12-17     14:42"
            cell.contentLab?.text = "测评师  王俊杰  电话  联系了客户"
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CRMDetailContactViewCell
            cell.dateLab?.text = "2016-12-17     14:42"
            cell.descTitLab?.text = "测评师  王俊杰  电话  联系了客户"
            cell.contentLab?.text = "沟通内容：是出自诗经中的词语，原意为凤与凰在空中相偕而飞，一般用来祝福婚姻新人的生活幸福美满，本是用于婚礼的祝词，后来却由于周璇的著名同名歌曲而家喻户晓。亦作“ 凤..."
            cell.courseLab?.text = "意向学科：数学、英语    意向程度：中    预约试听：2017-09-09    试听学科：英语    市场活动：无"
            return cell
        }
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
