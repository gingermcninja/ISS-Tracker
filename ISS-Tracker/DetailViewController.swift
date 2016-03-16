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
        self.mapView.delegate = self
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

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKPointAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIView

            }
            return view
        }
        return nil
    }
}



