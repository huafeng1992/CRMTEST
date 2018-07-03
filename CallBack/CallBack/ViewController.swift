//
//  ViewController.swift
//  CallBack
//
//  Created by 王华峰 on 2018/7/2.
//  Copyright © 2018年 hf. All rights reserved.
//

import UIKit

let kw = UIScreen.main.bounds.size.width
let kh = UIScreen.main.bounds.size.height

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let tableViewController = TableViewController()
        self.show(tableViewController, sender: nil)
    }
    
}


//class ViewController: UIViewController {
//
//    var ctcall: CTCallCenter?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//        let callBtn = UIButton()
//        callBtn.frame = CGRect.init(x: 100, y: 100, width: kw - 200, height: 40)
//        callBtn.setTitle("拨打电话", for: .normal)
//        callBtn.setTitleColor(UIColor.red, for: .normal)
//        view.addSubview(callBtn)
//
//        callBtn.addTarget(self, action: #selector(callBtnAction), for: .touchUpInside)
//    }
//
//    @objc func callBtnAction() {
//        print("拨打电话")
//
//        CallCenter.center.call(phone: nil)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}

