//
//  ViewController.swift
//  onBoard
//
//  Created by Данис Тазетдинов on 07.04.17.
//  Copyright © 2017 Deniska. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet private weak var coordinatesCell : UITableViewCell!
    @IBOutlet private weak var altitudeCell : UITableViewCell!
    @IBOutlet private weak var locationAccuracyCell : UITableViewCell!
    @IBOutlet private weak var speedCell : UITableViewCell!
    @IBOutlet private weak var headingCell : UITableViewCell!
    @IBOutlet private weak var updatedCell : UITableViewCell!

    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            requestLocationUpdates()
        } else if CLLocationManager.authorizationStatus() == .restricted {
            // TODO: show info to allow location updates

        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func requestLocationUpdates() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .otherNavigation
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            requestLocationUpdates()
        } else {
            // TODO: show info to allow location updates
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingCell.detailTextLabel?.text = "\(newHeading.magneticHeading)˚"
        //speedCell.detailTextLabel.text = "\(newHeading.magneticHeading)˚"
//        headingAccuracyCell.detailTextLabel?.text = "\(newHeading.headingAccuracy)˚"

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        coordinatesCell.detailTextLabel?.text = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
        altitudeCell.detailTextLabel?.text = "\(location.altitude)"
        let accuracy = max(location.horizontalAccuracy, location.verticalAccuracy)
        locationAccuracyCell.detailTextLabel?.text = "\(accuracy)"
        speedCell.detailTextLabel?.text = "\(location.speed)"
        headingCell.detailTextLabel?.text = "\(location.course)˚"
        updatedCell.detailTextLabel?.text = "\(location.timestamp)"
    }



    func updateUI() {

    }




}

