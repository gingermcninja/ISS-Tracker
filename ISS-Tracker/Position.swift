//
//  Position.swift
//  ISS-Tracker
//
//  Created by Paul McGrath on 16/03/2016.
//  Copyright © 2016 Paul McGrath. All rights reserved.
//

import UIKit
import Decodable

public struct Position {
    public let latitude: Double
    public let longitude: Double
}

extension Position: Decodable {
    public static func decode(j: AnyObject) throws -> Position {
        return try Position(
            latitude: j => "latitude",
            longitude: j => "longitude"
        )
    }
    
}
