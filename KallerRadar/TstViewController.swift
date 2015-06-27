//
//  TstViewController.swift
//  KallerRadar
//
//  Created by Kuli Gabor on 2015. 05. 03..
//  Copyright (c) 2015. kebodev. All rights reserved.
//

import UIKit

class TstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        let imageName = "akosjo.jpg"
        let imageBack = UIImage(named: imageName)
        let backTst = UIImageView(image: imageBack!)
        
        backTst.frame = CGRect(x: 0, y: 0, width: 340, height: 620)
        view.addSubview(backTst)

        */
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "akosjo5.jpg")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
