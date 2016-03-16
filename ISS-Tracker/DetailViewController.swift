//
//  DetailViewController.swift
//  ISS-Tracker
//
//  Created by Paul McGrath on 16/03/2016.
//  Copyright © 2016 Paul McGrath. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var detailItem: Position? {
        didSet {
            if let position = detailItem {
                self.showPositionOnMap(position)
            }
        }
    }
    
    func showPositionOnMap(position:Position) {
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(position.latitude, position.longitude)
        let mapAnnotation:MKPointAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = coordinate
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.mapView.addAnnotation(mapAnnotation)
            self.mapView.centerCoordinate = coordinate
        })

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let service:WebService = WebService()
        service.getCurrentLocation { (apiData, apiError) -> Void in
            print(apiData)
            do {
                let position:Position =  try Position.decode(apiData!["iss_position"]!)
                self.detailItem = position
                self.showPositionOnMap(position)
            } catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}


