//
//  WSProgressHUD.swift
//  WSProgressHUD
//
//  Created by ws on 2017/7/21.
//  Copyright © 2017年 ws. All rights reserved.
//



import UIKit

class PieProgress: WSProgressHUD {
    
    
    fileprivate func showPieProgress(view: UIView, hudKey: NSCopying, progress: CGFloat, strokeColor: UIColor, fillColor: UIColor) {
        
        guard layerContainer.object(forKey: hudKey) != nil else {
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



class WSProgressHUD: NSObject {
    
    class func setStrokeColor(strokeColor: UIColor){
        instanceManager().strokeColor = strokeColor
    }
    
    class func setFillColor(fillColor: UIColor){
        instanceManager().fillColor = fillColor
    }
    
    private static let instance = WSProgressHUD()
    private static let pieInstance = PieProgress()
    
    fileprivate class func instanceManager() -> WSProgressHUD{
        return instance
    }
    
    fileprivate var strokeColor: UIColor = {
        let color = UIColor.black.withAlphaComponent(0.7)
        return color
    }()
    
    fileprivate var fillColor: UIColor = {
        let color = UIColor.clear
        return color
    }()
    
    fileprivate var layerContainer: NSMutableDictionary = {
        let dic = NSMutableDictionary()
        return dic
    }()
    
    
    class func showPieProgress(view: UIView, hudKey: String, progress: CGFloat) {
        
        pieInstance.showPieProgress(view: view,
                                    hudKey: hudKey as NSCopying,
                                    progress: progress,
                                    strokeColor: instanceManager().strokeColor,
                                    fillColor: instanceManager().fillColor)
    }
}
