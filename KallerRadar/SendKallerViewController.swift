//
//  SendKallerViewController.swift
//  KallerRadar
//
//  Created by Kuli Gabor on 2015. 04. 20..
//  Copyright (c) 2015. kebodev. All rights reserved.
//

import UIKit
import CoreLocation



class SendKallerViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet var postMenuBtn: UIButton!
    
    @IBOutlet weak var sendTextField: UITextField!
    @IBOutlet weak var routeTst: UITextField! = nil
    
    @IBOutlet weak var sendKallerBtn: UIButton!

    @IBOutlet weak var routePicker: UIPickerView!
    
    @IBOutlet weak var labelLan: UILabel!
    @IBOutlet weak var labelLon: UILabel!
    
    var manager:CLLocationManager!
    
    var latMain:String = ""
    var lonMain:String = ""
    
    var colors = [String]()
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        println("pickerView called... rows.....")
        return colors[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        println("pickerView called... return 1...")
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        println("pickerView called... count...")
        return colors.count
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("send view did load called...")
        sendTextField.delegate = self

        self.view.alpha = 0.9
        
        sendTextField.text = "Ide jöhet a szöveg..."
        
        sendTextField.textColor = UIColor.lightGrayColor()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        let imageName = "kr_new_br.png"
        let imageBack = UIImage(named: imageName)
        let backTst = UIImageView(image: imageBack!)
        
        backTst.frame = CGRect(x: 0, y: 0, width: 750, height: 1334)
        //backTst.alpha = 0.2
        view.addSubview(backTst)
        view.sendSubviewToBack(backTst)

        
        var menuButton = UIButton(frame: CGRectMake(0, 0, 100, 100))
        menuButton.setTitle("Vissza a feedbe", forState: UIControlState.Normal)
        menuButton.addTarget(self, action: "menuButtonPush:", forControlEvents:.TouchUpInside)
        menuButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(menuButton)
        view.addConstraints([
            NSLayoutConstraint(item: menuButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: -50),
            NSLayoutConstraint(item: menuButton, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 15),
            NSLayoutConstraint(item: menuButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -10)
            ])
        
        

        
        
    }
    
    
    func menuButtonPush(_sender: AnyObject?)
    {
        println("tapped button")
        self.dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("goBackFeed", sender: self)
    }

    
    
    

    @IBAction func sendTextEditDidBegin(sender: AnyObject) {
        if sendTextField.textColor == UIColor.lightGrayColor() {
            sendTextField.text = nil
            sendTextField.textColor = UIColor.blackColor()
        }

    }
    

    @IBAction func onBurger() {
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendTextField.resignFirstResponder()
        return true
    }
    
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {

        let location = locations.last as! CLLocation
        
        
        manager.stopUpdatingLocation()
        latMain = location.coordinate.latitude.description
        lonMain = location.coordinate.longitude.description
        getNearRoutes(location.coordinate.latitude.description, lon: location.coordinate.longitude.description)
    }
    
    
    @IBAction func pushDataToDb(sender: AnyObject) {
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()

        var sendingText = sendTextField.text
        var tstRoute = colors[routePicker.selectedRowInComponent(0)]
        println(tstRoute)
        
        if sendingText == ""  {
            sendingText = "üres üzenet.."
        }
        
        
        let parameters = [
            "idkamu": [4],
            "feedText" : sendingText + " - ezen a járaton: " + tstRoute,
            "feedLat" : latMain,
            "feedLon" : lonMain,
            "feedRouteShName" : tstRoute
        ]
        println(parameters)
        
        request(.POST, "http://79.172.249.175:7001/RestWebServiceApp/webresources/entity.bkkkallerfeedtst", parameters: parameters as! [String : AnyObject], encoding: .JSON)
        
               
        
            performSegueWithIdentifier("goBackFeed", sender: self)
    }
    
    
    func getNearRoutes(lat:String, lon:String){
        println("getNearRoutes called..")
        
        let json = JSON(url:"http://79.172.249.175:7001/RestWebServiceApp/webresources/entity.bkkmainprtable/"+lat+"/"+lon)

        
        //println(json)
        colors.removeAll(keepCapacity: false)
        
        
        println(json["bkkMainPrTable"].asError)
        
        
        if (json["bkkMainPrTable"].asError == nil){
            
            println("json nem null ag..")
        
        for (k, v) in json["bkkMainPrTable"] {
            
            
            //sendTextField.text = sendTextField.text + " " + v["routeShName"].description
            
            
            colors.append(v["routeShName"].description + " - megálló: " + v["stopName"].description)
            
            println(v["routeShName"])

            
        }
        }
        else {
            println("else json ag..")
            colors.append("Nincs elérhető járat")
            sendKallerBtn.setTitle("No Post", forState: UIControlState.Normal)
            //sendKallerBtn.enabled = false
        }
            routePicker.reloadAllComponents()
            

    }
    

    }
