//
//  MapsViewController.swift
//  MapasCamara
//
//  Created by Daniel Esteban Alcantara on 21/11/26.
//

import Foundation
import MapKit

class MapsViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        //centerMap()
        centerMapIOSLab()
        addAnnotation()
        setupLocation()
        navigation()
    }
    
    private func setupMap() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.delegate = self
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func centerMap() {
        let coordinate = CLLocationCoordinate2D(
            latitude: 19.4326,
            longitude: -99.1332
        )
        
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
        
        mapView.setRegion(region, animated: true)
    }
    
    private func addAnnotation() {
        let annotation = MKPointAnnotation()
        
        annotation.title = "Ciudad de México"
        annotation.subtitle = "Mi ubicación"
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: 19.4326,
            longitude: -99.1332
        )
        
        mapView.addAnnotation(annotation)
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    private func centerMapIOSLab() {
        let coordinate = CLLocationCoordinate2D(
            latitude: 19.32758,
            longitude: -99.18231
        )
        
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
        
        mapView.setRegion(region, animated: true)
    }
    
    private func navigation() {
        if let location = locationManager.location?.coordinate {
            let latitude = location.latitude
            let longitude = location.longitude
            
            print("Latitud \(latitude)")
            print("Longitud \(longitude)")
            
            let destination = CLLocationCoordinate2D(
                latitude: 19.33121,
                longitude: -99.18470
            )
            
            drawroute(from: location, to: destination)
        }
    }
    
    private var hasDrawnRoute = false
    
    private func drawroute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(
            location: CLLocation(
                latitude: source.latitude,
                longitude: source.longitude
            ),
            address: nil
        )
        
        request.destination = MKMapItem(
            location: CLLocation(
                latitude: destination.latitude,
                longitude: destination.longitude
            ),
            address: nil
        )
        
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self, let route = response?.routes.first else {
                print("Error: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(
                    route.polyline.boundingMapRect,
                    edgePadding: UIEdgeInsets(
                        top: 88,
                        left: 40,
                        bottom: 80,
                        right: 40
                    ),
                    animated: true
                )
            }
        }
    }
}

// MARK: Este delegado es para activar los permisos de localizacion
extension MapsViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            navigation()
        default:
            break
        }
    }
}

extension MapsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .brown
        renderer.lineWidth = 4
        return renderer
    }
}
