//
//  Pass.swift
//  ISS-Tracker
//
//  Created by Paul McGrath on 16/03/2016.
//  Copyright © 2016 Paul McGrath. All rights reserved.
//

import UIKit
import Decodable

public struct Pass {
    public let riseTime: NSDate
    public let duration: Double
}

extension Pass: Decodable {
    public static func decode(j: AnyObject) throws -> Pass {
        return try Pass(
            riseTime: decodeDateFromString(j => "riseTime"),
            duration: j => "duration"
        )
    }
    
    private static func decodeDateFromString(date: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssxxx"
        return dateFormatter.dateFromString(date) ?? NSDate()
    }

}