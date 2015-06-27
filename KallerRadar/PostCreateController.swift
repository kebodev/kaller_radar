//
//  PostCreateController.swift
//  KallerRadar
//
//  Created by Kuli Gabor on 2015. 05. 23..
//  Copyright (c) 2015. kebodev. All rights reserved.
//

import UIKit
import CoreLocation

class PostCreateController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource, CLLocationManagerDelegate,UITextFieldDelegate {
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var routesToChose = [UIImage]()
    var routesToChoseString = [String]()
    var routesToChoseType = [String]()
    var chosedRoute : Int!
    var locManager:CLLocationManager!
    var postText : UITextField!
    var createPostButton : UIButton!
    var pickerView : AKPickerView!
    
    //store current gps coordinates
    var latitude : String!;
    var longitude: String!;
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        // Setup the font specific variables
        var textColor: UIColor = UIColor.whiteColor()
        var textFont: UIFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        //Setup the image context using the passed image.
        UIGraphicsBeginImageContext(inImage.size)
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        var rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)
        
        //Now Draw the text into an image.
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
        
    }
    
    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return routesToChose.count
    }
    
    
    func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return routesToChose[item]
    }
    
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        chosedRoute = item
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        println("didfail")
        println(error)
        //locManager.stopUpdatingLocation()
        //locManager.startUpdatingLocation()
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        println("location manager called..")
        let locationLast = locations.last as! CLLocation
        
        latitude = locationLast.coordinate.latitude.description
        longitude = locationLast.coordinate.longitude.description
        
        locManager.stopUpdatingLocation()
        
        println(latitude)
        println(longitude)
        //after get gps coordinates call this to populate the pickerview
        getNearRoutes(latitude, longitude: longitude)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        println(newHeading.trueHeading)
        locManager.stopUpdatingHeading()
        
    }
    
    
    
    override func viewDidLoad() {
        self.title = "Kaller küldése"
        println("PostCreateController didload called")
        super.viewDidLoad()
        routesToChose.removeAll(keepCapacity: false)
        routesToChoseString.removeAll(keepCapacity: false)
        routesToChoseType.removeAll(keepCapacity: false)
      
        
        routesToChose.removeAll(keepCapacity: false)
        routesToChoseString.removeAll(keepCapacity: false)
        if (pickerView != nil) {
            pickerView.reloadData()
            println("reloading pickerview data")
            pickerView.removeFromSuperview()
        }
        self.view.backgroundColor = UIColor(red:0.17, green:0.30, blue:0.45, alpha:1.0)
        
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        locManager.startUpdatingHeading()
        

        
        var backForPicker = UIView()
        backForPicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        backForPicker.backgroundColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0)
        
        view.sendSubviewToBack(backForPicker)
        
        view.addSubview(backForPicker)
        
        view.addConstraints([
            NSLayoutConstraint(item: backForPicker, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: backForPicker, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: backForPicker, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: backForPicker, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 70),
            NSLayoutConstraint(item: backForPicker, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -70)
            ])
        
        //view.sendSubviewToBack(backForPicker)
        
        var backButton = UIButton()
        backButton.setTitle("< Vissza", forState: UIControlState.Normal)
        backButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(backButton)
        
        
        
        view.addConstraints([
            NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 25),
            NSLayoutConstraint(item: backButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 20)
            ])
        
        
        backButton.addTarget(self, action: "goBack:", forControlEvents:.TouchUpInside)
        
        postText = UITextField()
        postText.placeholder = "Post szövege..."
        postText.textColor = UIColor.blackColor()
        postText.delegate = self
        postText.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(postText)
        
        view.addConstraints([
            NSLayoutConstraint(item: postText, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: postText, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: -180),
            NSLayoutConstraint(item: postText, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 125)
            ])
        
        //postText.backgroundColor = UIColor.lightGrayColor()
        
        
        createPostButton = UIButton()
        createPostButton.setImage(UIImage(named: "postbar2.png"), forState: UIControlState.Normal)
        createPostButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        //createPostButton.on = true
        view.addSubview(createPostButton)
        
        view.addConstraints([
            NSLayoutConstraint(item: createPostButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: createPostButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 70),
            NSLayoutConstraint(item: createPostButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])
        
        createPostButton.addTarget(self, action: "postThenGoBack:", forControlEvents: .TouchUpInside);
        
        var logo = UILabel()
        logo.setTranslatesAutoresizingMaskIntoConstraints(false)
        logo.text = "Kaller küldése"
        logo.textColor = UIColor.whiteColor()
        view.addSubview(logo)
        
        view.addConstraints([
            
            //NSLayoutConstraint(item: logo, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0),

            NSLayoutConstraint(item: logo, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 23),
            NSLayoutConstraint(item: logo, attribute: NSLayoutAttribute.CenterX, relatedBy: .Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
            ])

        
    }
    
    func postThenGoBack(sender: UIButton!) {
        
        //set to null
        chosedRoute = 0
        
        
        
        var chosedRoutName = routesToChoseString[chosedRoute]
        var chosedRoutType = routesToChoseType[chosedRoute]
        var sendingPostText = postText.text
        
        if sendingPostText == ""  {
            sendingPostText = "üres üzenet.."
        }
        
        
        let parameters = [
            "idkamu": [4],
            "feedText" : sendingPostText,
            "feedLat" : latitude,
            "feedLon" : longitude,
            "feedRouteShName" : chosedRoutName,
            "feedImgType" : chosedRoutType
        ]
        println(parameters)
        
        request(.POST, "http://79.172.249.175:7001/RestWebServiceApp/webresources/entity.bkkkallerfeedtst", parameters: parameters as! [String : AnyObject], encoding: .JSON)
        
        if let navController = self.navigationController {
            navController.popToRootViewControllerAnimated(true)
        }
        
        
        
    }
    
    
    func goBack(_sender: AnyObject?) {
        
        if let navController = self.navigationController {
            routesToChose.removeAll(keepCapacity: false)
            routesToChoseString.removeAll(keepCapacity: false)
            routesToChoseType.removeAll(keepCapacity: false)
            //pickerView.reloadData()
            navController.popToRootViewControllerAnimated(true)
            
        }
        
    }
    
    func getNearRoutes(latitude:String, longitude:String){
        println("getNearRoutes called..")
        
        let json = JSON(url:"http://79.172.249.175:7001/RestWebServiceApp/webresources/entity.bkkmainprtable/"+latitude+"/"+longitude)
        
        //println(json)
        routesToChose.removeAll(keepCapacity: false)
        routesToChoseString.removeAll(keepCapacity: false)
        routesToChoseType.removeAll(keepCapacity: false)
        
        if (json.asError == nil) {
            println("nem error")
            
            
            var bkkKallerFeedTst = json["bkkMainPrTable"]
            var bkkKallerFeedTstArray : [JSON]
            
            if bkkKallerFeedTst.isDictionary {
                bkkKallerFeedTstArray = [bkkKallerFeedTst] //initialize
            } else {
                
                bkkKallerFeedTstArray = bkkKallerFeedTst.asArray!
            }
            
            for v in bkkKallerFeedTstArray {
                
           
                //routType
                //println("for fut..")
                //println(v)
                
                
                //create img if routtype is bus : 3 villamos: 0 metro : 1 valamimas  : 5
                if (v["routType"].description == "3") {
                    let routeIconName = "bus.png"
                    let routeIconResized = RBResizeImage(UIImage(named: routeIconName)!, targetSize: CGSizeMake(200, 200))
                    let routeImg = textToImage(v["routeShName"].description + " - " + v["stopName"].description, inImage: routeIconResized, atPoint: CGPointMake(51.0, 11.0))
                    
                    routesToChose.append(routeImg)
                    routesToChoseString.append(v["routeShName"].description)
                    routesToChoseType.append(v["routType"].description)
                }
                
                if (v["routType"].description == "0") {
                    let routeIconName = "combino.png"
                    let routeIconResized = RBResizeImage(UIImage(named: routeIconName)!, targetSize: CGSizeMake(200, 200))
                    let routeImg = textToImage(v["routeShName"].description + " - " + v["stopName"].description, inImage: routeIconResized, atPoint: CGPointMake(51, 11))
                    
                    routesToChose.append(routeImg)
                    routesToChoseString.append(v["routeShName"].description)
                    routesToChoseType.append(v["routType"].description)
                }
                
                if (v["routType"].description == "2") {
                    let routeIconName = "suburban.png"
                    let routeIconResized = RBResizeImage(UIImage(named: routeIconName)!, targetSize: CGSizeMake(200, 200))
                    let routeImg = textToImage(v["routeShName"].description + " - " + v["stopName"].description, inImage: routeIconResized, atPoint: CGPointMake(51, 11))
                    
                    routesToChose.append(routeImg)
                    routesToChoseString.append(v["routeShName"].description)
                    routesToChoseType.append(v["routType"].description)
                }
                
                
                
                
                
            }
 
            //println(json["bkkMainPrTable"])
            
            /*for (k, v) in json["bkkMainPrTable"] {
                //routType
                println("for fut..")
                println(v)
                

                //create img if routtype is bus : 3 villamos: 0 metro : 1 valamimas  : 5
                if (v["routType"].description == "3") {
                    let routeIconName = "bus.png"
                    let routeIconResized = RBResizeImage(UIImage(named: routeIconName)!, targetSize: CGSizeMake(200, 200))
                    let routeImg = textToImage(v["routeShName"].description + " - " + v["stopName"].description, inImage: routeIconResized, atPoint: CGPointMake(51.0, 11.0))
                    
                    routesToChose.append(routeImg)
                    routesToChoseString.append(v["routeShName"].description)
                    routesToChoseType.append(v["routType"].description)
                }
                
                if (v["routType"].description == "0") {
                    let routeIconName = "combino.png"
                    let routeIconResized = RBResizeImage(UIImage(named: routeIconName)!, targetSize: CGSizeMake(200, 200))
                    let routeImg = textToImage(v["routeShName"].description + " - " + v["stopName"].description, inImage: routeIconResized, atPoint: CGPointMake(51, 11))
                    
                    routesToChose.append(routeImg)
                    routesToChoseString.append(v["routeShName"].description)
                    routesToChoseType.append(v["routType"].description)
                }
                
                if (v["routType"].description == "2") {
                    let routeIconName = "suburban.png"
                    let routeIconResized = RBResizeImage(UIImage(named: routeIconName)!, targetSize: CGSizeMake(200, 200))
                    let routeImg = textToImage(v["routeShName"].description + " - " + v["stopName"].description, inImage: routeIconResized, atPoint: CGPointMake(51, 11))
                    
                    routesToChose.append(routeImg)
                    routesToChoseString.append(v["routeShName"].description)
                    routesToChoseType.append(v["routType"].description)
                }
                
                
                
                
            }*/
        }
        else {
            println("else")
            println(json.asError)
            let routeIconName = "dont.png"
            let routeIconResized = RBResizeImage(UIImage(named: routeIconName)!, targetSize: CGSizeMake(200, 200))
            let routeImg = textToImage("Nincs járat", inImage: routeIconResized, atPoint: CGPointMake(32.0, 7.0))
            routesToChose.append(routeImg)
            routesToChoseString.append("")
            routesToChoseType.append("999")
            createPostButton.enabled = false
        }
        
        
        //create pickerview when data is ready
        pickerView = AKPickerView()
        pickerView.reloadData()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        pickerView.interitemSpacing = 50
        pickerView.viewDepth = 700
        //pickerView.backgroundColor = UIColor.lightGrayColor()
        
        view.addSubview(pickerView)
        
        //this is for sizeing
        self.automaticallyAdjustsScrollViewInsets = false
        
        view.addConstraints([
            NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 350),
            NSLayoutConstraint(item: pickerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 330)
            ])
        
        
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        postText.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        


        
    }
    
    
}
