//
//  PostLineItem.swift
//  KallerRadar
//
//  Created by Kuli Gabor on 2015. 05. 22..
//  Copyright (c) 2015. kebodev. All rights reserved.
//

import UIKit

class PostLineItem: UIView {
    
    
    var labelText : String!
    var labelHeader : String!
    var routType : String!
    var busIconName : String!
    var dateLabel : String!
    
    init(labelText: String , labelHeader: String, routType: String, dateLabel: String) {
        super.init(frame: CGRect.zeroRect)
        self.labelText = labelText
        self.labelHeader = labelHeader
        self.routType = routType
        self.dateLabel = dateLabel
        var tlb = timeLineBlock()
        self.addSubview(tlb)
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: tlb, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: tlb, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: tlb, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: tlb, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0)
            ])
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        println("required public")
    }
    
    
    private func timeLineBlock() -> UIView{
        
        var v = UIView()
        v.setTranslatesAutoresizingMaskIntoConstraints(false)         
        
        /*v.layer.borderWidth = 0.3
        v.layer.borderColor = UIColor.blackColor().CGColor
        v.layer.cornerRadius = 30
        v.layer.masksToBounds = true
        */
         //v.alpha = 0.4
      
        
        let titleLabel = UILabel()
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont(name: "Helvetica", size: 20)
        
        
        var postTextHeader = labelHeader
        titleLabel.text = labelHeader
        
        titleLabel.numberOfLines = 0
        titleLabel.layer.masksToBounds = false
        titleLabel.textColor = UIColor(red:0.45, green:0.45, blue:0.45, alpha:1.0)
        v.addSubview(titleLabel)
        v.addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -120),
            NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 95),
            NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 25)
            ])
        
        
        
        let timeLabel = UILabel()
        timeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        timeLabel.font = UIFont(name: "Helvetica", size: 10)
        timeLabel.textColor = UIColor(red:0.45, green:0.45, blue:0.45, alpha:1.0)
        timeLabel.text = dateLabel
        timeLabel.numberOfLines = 0
        timeLabel.layer.masksToBounds = false
        v.addSubview(timeLabel)
        
        
        v.addConstraints([
            NSLayoutConstraint(item: timeLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -120),
            NSLayoutConstraint(item: timeLabel, attribute: .Right, relatedBy: .Equal, toItem: v, attribute: .Right, multiplier: 1.0, constant: 145),
            NSLayoutConstraint(item: timeLabel, attribute: .Top, relatedBy: .Equal, toItem: v, attribute: .Top, multiplier: 1.0, constant: 6)
            ])

        
        
        
        
        let textLabel = UILabel()
        textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        textLabel.font = UIFont(name: "ArialMT", size: 13)
        textLabel.textColor = UIColor(red:0.45, green:0.45, blue:0.45, alpha:1.0)
        textLabel.text = labelText
        
        textLabel.numberOfLines = 0
        textLabel.layer.masksToBounds = false
        v.addSubview(textLabel)
        v.addConstraints([
            NSLayoutConstraint(item: textLabel, attribute: .Width, relatedBy: .Equal, toItem: v, attribute: .Width, multiplier: 1.0, constant: -100),
            NSLayoutConstraint(item: textLabel, attribute: .Left, relatedBy: .Equal, toItem: v, attribute: .Left, multiplier: 1.0, constant: 95),
            NSLayoutConstraint(item: textLabel, attribute: .Right, relatedBy: .Equal, toItem: v, attribute: .Right, multiplier: 1.0, constant: -5),
            NSLayoutConstraint(item: textLabel, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1.0, constant: 5),
            NSLayoutConstraint(item: textLabel, attribute: .Bottom, relatedBy: .Equal, toItem: v, attribute: .Bottom, multiplier: 1.0, constant: -10)
            ])
        
        
        //create img if routtype is bus : 3 villamos: 0 metro : 1 valamimas  : 5
        
        if (routType == "3") {
           busIconName = "bus.png"
        }
        
        else if (routType == "0") {
             busIconName = "combino.png"
        }
        
        else if (routType == "1") {
            busIconName = "bus.png"
        }
            
        else if (routType == "2") {
            busIconName = "suburban.png"
        }

        
        else if (routType == "5") {
            busIconName = "suburban.png"
        }
        
        let busImg = UIImage(named: busIconName)
        let busImgView = UIImageView(image: busImg!)
        
        busImgView.frame = CGRect()
        busImgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        busImgView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        v.addSubview(busImgView)
        
        v.addConstraints([
            NSLayoutConstraint(item: busImgView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 59),
            NSLayoutConstraint(item: busImgView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 58),
            NSLayoutConstraint(item: busImgView, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: v, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: busImgView, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: v, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 5)
            ])
        
        /*let kisBusIconName = "nyil"
        let kisBusImg = UIImage(named: kisBusIconName)
        let kisBusImgView = UIImageView(image: kisBusImg!)
        
        kisBusImgView.frame = CGRect()
        kisBusImgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        kisBusImgView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        kisBusImgView.alpha = 0.1
        v.addSubview(kisBusImgView)
        
        v.addConstraints([
            NSLayoutConstraint(item: kisBusImgView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 22),
            NSLayoutConstraint(item: kisBusImgView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 21),
            NSLayoutConstraint(item: kisBusImgView, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: titleLabel, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: kisBusImgView, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: titleLabel, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -30)
            ])
        
        */
                
        
        return v
    }
}
