//
//  LocationViewController.swift
//  WeatherTestTask
//
//  Created by Сергей on 22.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationPicked: ((CLLocationCoordinate2D) -> Void)?
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        let pressPoint = sender.location(in: mapView)
        let pressCoordinate = mapView.convert(pressPoint, toCoordinateFrom: mapView)
        let pressPin = MKPointAnnotation()
        pressPin.coordinate = pressCoordinate
        mapView.addAnnotation(pressPin)
    }
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func pickLocation() {
        let location = mapView.visibleMapRect.origin.coordinate
        locationPicked?(location)
        navigationController?.popViewController(animated: true)
    }
    fileprivate let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        navigationController?.navigationBar.isHidden = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
