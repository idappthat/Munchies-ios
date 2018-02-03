//
//  RecommendationViewController.swift
//  Munchies
//
//  Created by Cameron Moreau on 2/2/18.
//  Copyright © 2018 Mobi. All rights reserved.
//

import UIKit
import MapKit

class RecommendationViewController: UIViewController {

    @IBOutlet weak var mapSnapshot: UIImageView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeCategory: UILabel!
    @IBOutlet weak var placeDistance: UILabel!
    @IBOutlet weak var placeHours: UILabel!
    @IBOutlet weak var placePrice: UILabel!
    @IBOutlet weak var placeRating: UILabel!
    
    var recommendationManager = RecommendationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateMapSnapshot()
        recommendationManager.getRecommendation { recommendation, error in
            if let r = recommendation {
                self.placeTitle.text = r.name
                self.placeCategory.text = r.category
                self.placePrice.text = r.price
                self.placeRating.text = String(r.rating)
            }
        }
    }
    
    func generateMapSnapshot() {
        let mapSnapshotOptions = MKMapSnapshotOptions()

        // Bounds
        var coordinates = [CLLocationCoordinate2DMake(32.733338, -97.111425)]
        let polyLine = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        let region = MKCoordinateRegionForMapRect(polyLine.boundingMapRect)

        // Map Options
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: self.mapSnapshot.frame.width, height: self.mapSnapshot.frame.height)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        
        snapShotter.start() { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            self.mapSnapshot.image = snapshot.image
        }
    }
}
