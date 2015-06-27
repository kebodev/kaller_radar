//
//  TstKurvaKocka.swift
//  KallerRadar
//
//  Created by Kuli Gabor on 2015. 05. 05..
//  Copyright (c) 2015. kebodev. All rights reserved.
//

import UIKit

class TstKurvaKocka: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        opaque = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func drawRect(rect: CGRect) {
        println("kocaka rajzolas fut..")
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 6)
        
        
        
        path.lineWidth = 0.3
        
        UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).setFill()
        path.fill()
        
        //UIColor.redColor().setStroke()
        //path.stroke()
        
        
    }

}
