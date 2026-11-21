//
//  MapsViewController.swift
//  MapasCamara
//
//  Created by Daniel Esteban Alcantara on 21/11/26.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        //centerMap()
        addAnnotation()
        setupLocation()
        centerMapIOSLab()
    }
    
    private func setupMap(){
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func centerMap(){
        let coordinate = CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func addAnnotation(){
        let annotation = MKPointAnnotation()
        
        annotation.title = "Ciudad de México"
        annotation.subtitle = "Mi ubicación"
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332)
        
        mapView.addAnnotation(annotation)
    }
    
    private func setupLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    private func centerMapIOSLab(){
        
        let coordinate = CLLocationCoordinate2D(latitude: 19.32758, longitude: -99.18231)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        mapView.setRegion(region, animated: true)
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
        default:
            break
        }
    }
}
