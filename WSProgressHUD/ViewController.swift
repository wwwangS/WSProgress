//
//  ViewController.swift
//  pre
//
//  Created by ws on 2017/7/14.
//  Copyright © 2017年 ws. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    let button = UIButton(frame: CGRect(x: 100, y: 400, width: 50, height: 50))
    
    let view0 = UIImageView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    let view1 = UIImageView(frame: CGRect(x: 120, y: 50, width: 50, height: 50))
    let view2 = UIImageView(frame: CGRect(x: 190, y: 50, width: 50, height: 50))
    let view3 = UIImageView(frame: CGRect(x: 260, y: 50, width: 50, height: 50))
    
    var timer: DispatchSourceTimer?
    var progress: Float? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        button.addTarget(self, action: #selector(changed), for: .touchUpInside)
        button.setTitle("开始", for: .normal)
        button.backgroundColor = UIColor.black
        self.view.addSubview(button)
        
        
        view0.backgroundColor = UIColor.yellow
        view1.backgroundColor = UIColor.orange
        view2.backgroundColor = UIColor.brown
        view3.backgroundColor = UIColor.gray
        
        self.view.addSubview(view0)
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        
        resumeTimer()
    }
    
    func timeFire(){
        
        progress! += 0.02

        WSProgressHUD.showPieProgress(view: view0,
                                      hudKey: "0",
                                      progress: CGFloat(progress!)) { (hudKey) in
                                        print("key为 \(hudKey) 的进度条已结束")
        }
        
        WSProgressHUD.showPieProgress(view: view1,
                                      hudKey: "1",
                                      progress: CGFloat(progress!)) { (hudKey) in
                                        print("key为 \(hudKey) 的进度条已结束")
        }
        
        WSProgressHUD.showPieProgress(view: view2,
                                      hudKey: "2",
                                      progress: CGFloat(progress!)) { (hudKey) in
                                        print("key为 \(hudKey) 的进度条已结束")
        }
        
        WSProgressHUD.showPieProgress(view: view3,
                                      hudKey: "3",
                                      progress: CGFloat(progress!)) { (hudKey) in
                                        print("key为 \(hudKey) 的进度条已结束")
        }
        
        if CGFloat(progress!) >= 1 {
            deinitTimer()
        }
    }
    
    
    
    
    
    
    
    func changed(){
        progress = 0
        resumeTimer()
    }
    
    
    func resumeTimer() {
        timer = DispatchSource.makeTimerSource(queue: .main)
        timer?.scheduleRepeating(deadline: .now() + 0.1, interval: 0.1)
        timer?.setEventHandler {
            self.timeFire()
        }
        // 启动定时器
        timer?.resume()
    }
    
    func deinitTimer() {
        if let time = self.timer {
            time.cancel()
            timer = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

