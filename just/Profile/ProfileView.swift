//
//  ProfileView.swift
//  just
//
//  Created by Mauricio Zarate Chula on 21/08/22.
//  
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class ProfileView: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    // MARK: Properties
    var presenter: ProfilePresenterProtocol?
    var view2Show = false
    var profResView = [Profile]()


    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var contentVi: UIView!
    // MARK: Lifecycle
    
    private let locationManager = CLLocationManager()
    var latt = 00.00
    var long = 00.00
    
    let mapConstainer: GMSMapView = {
        let mapConstainer = GMSMapView()
        mapConstainer.contentMode = .scaleAspectFill
        mapConstainer.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        mapConstainer.clipsToBounds = true
        return mapConstainer
     }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.isHidden = true
        profilePic.makeRounded()
        presenter?.viewDidLoad()
        mapConstainer.delegate = self
               constraints()
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.requestAlwaysAuthorization()
               locationManager.startUpdatingLocation()


               if CLLocationManager.locationServicesEnabled() {
                 switch (CLLocationManager.authorizationStatus()) {
                   case .notDetermined, .restricted, .denied:
                     print("No access")
                   case .authorizedAlways, .authorizedWhenInUse:
                     print("Access")
                     DispatchQueue.main.async {
                         self.showCurrentLocation()
                         
                     }
                     
                 }
               } else {
                 print("Location services are not enabled")
               }
    }
    
    func showCurrentLocation() {
        mapConstainer.settings.myLocationButton = true
        view.addSubview(mapConstainer)
        
        let center = CLLocationCoordinate2D(latitude: latt, longitude: long)
              
              let marker = GMSMarker()
              marker.position = center
              
              marker.icon = UIImage(named: "pinSelected")
              marker.map = mapConstainer
              let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latt, longitude: long, zoom: Float(16.0))
              self.mapConstainer.animate(to: camera)
    
       }
    
    func constraints(){
        
        contentVi.translatesAutoresizingMaskIntoConstraints = false
        contentVi.addSubview(mapConstainer)
        
        mapConstainer.topAnchor.constraint(equalTo: view.topAnchor , constant: 300).isActive = true
        mapConstainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        mapConstainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
            mapConstainer.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
            
    
    
    
}

extension ProfileView: ProfileViewProtocol {
    
    func presen2DataView(recViewData: [Profile]) {
        profResView = recViewData
        DispatchQueue.main.async { [self] in
            profilePic.downloaded(from: profResView[0].results?[0].picture?.medium ?? "noimage")
            nameLbl.text = profResView[0].results?[0].name?.first
            ageLbl.text = String(profResView[0].results?[0].dob?.age ?? 0)
            latt = Double("\(String(describing: profResView[0].results?[0].location?.coordinates?.latitude))") ?? 0.0
            long = Double("\(profResView[0].results?[0].location?.coordinates?.longitude ?? "")") ?? 0.0
            mapConstainer.clear()
        }
    }
    
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}

