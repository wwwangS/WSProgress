//
//  WSProgressHUD.swift
//  WSProgressHUD
//
//  Created by ws on 2017/7/21.
//  Copyright © 2017年 ws. All rights reserved.
//



import UIKit



class WSProgressHUD: NSObject {
    
    // MARK: open
    
    //** strokeColor*/
    class func strokeColor(strokeColor: UIColor){
        instanceManager().layerStrokeColor = strokeColor
    }
    
    //** fillColor*/
    class func fillColor(fillColor: UIColor){
        instanceManager().layerFillColor = fillColor
    }
    
    
    /// 展示扇形进度条
    ///
    /// - Parameters:
    ///   - view: 父View
    ///   - hudKey: 进度条的key
    ///   - progress: progress
    ///   - completed: 进度为1时的闭包，将hudKey值返回
    class func showPieProgress(view: UIView, hudKey: String, progress: CGFloat, completed: @escaping(_ hudKey: String) ->() ) {
        
        
        pieInstance.showPieProgress(view: view,
                                    hudKey: hudKey as NSCopying,
                                    progress: progress,
                                    strokeColor: instanceManager().layerStrokeColor,
                                    fillColor: instanceManager().layerFillColor) { (keyString) in
                                        completed(keyString)
        }
    }
    
    
    // MARK: private
    private static let instance = WSProgressHUD()
    private static let pieInstance = PieProgress()
    
    private class func instanceManager() -> WSProgressHUD{
        return instance
    }
    
    private var layerStrokeColor: UIColor = {
        let color = UIColor.black.withAlphaComponent(0.7)
        return color
    }()
    
    private var layerFillColor: UIColor = {
        let color = UIColor.clear
        return color
    }()
}


class PieProgress: WSProgressHUD {
    
    private var layerContainer: NSMutableDictionary = {
        let dic = NSMutableDictionary()
        return dic
    }()
    
    fileprivate func showPieProgress(view: UIView, hudKey: NSCopying, progress: CGFloat, strokeColor: UIColor, fillColor: UIColor, completed: @escaping(_ keyString: String) ->()) {
        
        guard layerContainer.object(forKey: hudKey) != nil else {
            // 根据key查找layer，未找到时新建
            let pieLayer = setupPieLayer(view: view,
                                         strokeColor: strokeColor,
                                         fillColor: fillColor)
            pieLayer.strokeEnd = 1 - progress
            layerContainer.setObject(pieLayer, forKey: hudKey)
            
            view.layer.addSublayer(pieLayer)
            
            return
        }
        
        let pieLayer: CAShapeLayer = layerContainer.object(forKey: hudKey) as! CAShapeLayer
        pieLayer.strokeEnd = 1 - progress
        
        if Int(progress) >= 1 {
            // 进度为1，删除layer，completed闭包
            pieLayer.removeFromSuperlayer()
            layerContainer.removeObject(forKey: hudKey)
            completed(hudKey as! String)
        }
        
    }
    
    private func setupPieLayer(view: UIView, strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer{
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        let hypotLength = CGFloat(hypot(width, height))
        let pieStartAngle = CGFloat(-0.5 * Double.pi)
        let pieEndAngle = CGFloat(1.5 * Double.pi)
        let layerCenter: CGPoint = CGPoint(x: width / 2, y: height / 2)
        
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.masksToBounds = true
        layer.strokeEnd = 1
        layer.lineWidth = hypotLength
        
        let bPath = UIBezierPath()
        bPath.addArc(withCenter: layerCenter, radius: hypotLength/2, startAngle: pieEndAngle, endAngle: pieStartAngle, clockwise: false)
        layer.path = bPath.cgPath
        
        return layer
    }
}








