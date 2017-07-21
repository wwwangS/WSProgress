//
//  ViewController.swift
//  pre
//
//  Created by ws on 2017/7/14.
//  Copyright © 2017年 ws. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = UISlider(frame: CGRect(x: 100, y: 400, width: 200, height: 20))
    
    let view0 = UIImageView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    let view1 = UIImageView(frame: CGRect(x: 120, y: 50, width: 50, height: 50))
    let view2 = UIImageView(frame: CGRect(x: 190, y: 50, width: 50, height: 50))
    let view3 = UIImageView(frame: CGRect(x: 260, y: 50, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        slider.addTarget(self, action: #selector(changed(slider:)), for: .valueChanged)
        self.view.addSubview(slider)
        
        
        view0.backgroundColor = UIColor.yellow
        view1.backgroundColor = UIColor.orange
        view2.backgroundColor = UIColor.brown
        view3.backgroundColor = UIColor.gray
        
        
        self.view.addSubview(view0)
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
    }
    
    
    func changed(slider: UISlider){
        
        var value = slider.value
        //        if value > 1 {
        //            value = Float(slider.value - slider.value.exponent)
        //        }
        
        
        WSProgressHUD.showPieProgress(view: view0,
                                    hudKey: "0",
                                    progress: CGFloat(slider.value))
        WSProgressHUD.showPieProgress(view: view1,
                                    hudKey: "1",
                                    progress: CGFloat(slider.value))
        WSProgressHUD.showPieProgress(view: view2,
                                    hudKey: "2",
                                    progress: CGFloat(slider.value))
        WSProgressHUD.showPieProgress(view: view3,
                                    hudKey: "3",
                                    progress: CGFloat(slider.value))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

