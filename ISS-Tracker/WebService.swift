//
//  WebService.swift
//  NYTBrowser
//
//  Created by Paul McGrath on 19/01/2016.
//  Copyright © 2016 Paul McGrath. All rights reserved.
//

import UIKit

class WebService: NSObject {
    var currentLocationURL: String = "http://api.open-notify.org/iss-now.json"
    var nextPassURL: String = "http://api.open-notify.org/iss-pass.json"
    
    func getCurrentLocation(completionHandler: (NSDictionary?, NSError?) -> Void) {
        self.getFromAPI(currentLocationURL, completionHandler: completionHandler)
    }
    
    func getNextPassTimeFor(longitude:String, latitude:String, completionHandler: (NSDictionary?, NSError?) -> Void) {
        let fullURL:String = nextPassURL+"?lat="+latitude+"&lon="+longitude
        self.getFromAPI(fullURL, completionHandler: completionHandler)
    }
    
    func getFromAPI(url:String, completionHandler: (NSDictionary?, NSError?) -> Void) {
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
        let session: NSURLSession = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if(data == nil) {
                completionHandler(nil,error)
            } else {
                do {
                    let responseDictionary: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                    completionHandler(responseDictionary,error)
                } catch let error as NSError {
                    completionHandler(nil,error)
                }
            }
        }
        task.resume()
    }
    
}

