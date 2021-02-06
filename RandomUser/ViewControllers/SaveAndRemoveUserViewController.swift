//
//  SaveAndRemoveUserViewController.swift
//  RandomUser
//
//  Created by Karen Madoyan on 2021/1/31.
//

import UIKit
import MapKit
import RealmSwift

class SaveAndRemoveUserViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var saveUserButton: UIButton!
    @IBOutlet private weak var remopveUserButton: UIButton!
    private var realm = AppSettings().realm
    var user: User!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureMap()
        self.checkSaveButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.title = "\(self.user.name.first ?? String()) \(self.user.name.last ?? String())"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    

    // MARK: - Private Methods -
    
    private func configureView() {
        self.userImageView.image = Helper.downloadImage(from: self.user.picture.medium, complition: { (image) in
            self.userImageView.image = image
        })
        self.nameLabel.text = "\(self.user.name.first.as(String())) \(self.user.name.last.as(String()))"
        self.infoLabel.text = """
            \(self.user.gender.as(String())), \(self.user.cell.as(String()))
            \(self.user.location.country.as(String()))
            \(self.user.location.street.number.as(Int())) \(self.user.location.street.name.as(String()))
            """
    }
    
    private func configureMap() {
        self.mapView.register(MKMarkerAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let latitude = CLLocationDegrees(self.user.location.coordinates.latitude).as(CLLocationDegrees())
        let longitude = CLLocationDegrees(self.user.location.coordinates.longitude).as(CLLocationDegrees())
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let coordinateMapAnnotation = CoordinateMapAnnotation(coordinate: coordinate)
        self.mapView.addAnnotation(coordinateMapAnnotation)
        self.mapView.setRegion(coordinateMapAnnotation.region, animated: true)
    }
    
    private func checkSaveButtonState() {
        let model = self.realm.objects(UserModel.self)
        guard !model.isEmpty else { return }
        
        for user in model {
            if user.email == self.user.email {
                self.saveUserButton.isSelected = true
                self.saveUserButton.backgroundColor = UIColor.App.gray232.color
                self.saveUserButton.isUserInteractionEnabled = false
                self.remopveUserButton.isHidden = false
            }
        }
    }
    
    private func addUserModel() -> UserModel {
        let nameModel = NameModel()
        nameModel.title = self.user.name.title
        nameModel.first = self.user.name.first
        nameModel.last = self.user.name.last
        
            let streetModel = StreetModel()
            streetModel.number = self.user.location.street.number
            streetModel.name = self.user.location.street.name
        
            let coordinatesModel = CoordinatesModel()
            coordinatesModel.latitude = self.user.location.coordinates.latitude
            coordinatesModel.longitude = self.user.location.coordinates.longitude
        
            let timezoneModel = TimezoneModel()
            timezoneModel.offset = self.user.location.timezone.offset
            timezoneModel.descriptionTimezone = self.user.location.timezone.description

        let locationModel = LocationModel()
        locationModel.street = streetModel
        locationModel.city = self.user.location.city
        locationModel.state = self.user.location.state
        locationModel.country = self.user.location.country
        locationModel.postcode = self.user.location.postcode
        locationModel.coordinates = coordinatesModel
        locationModel.timezone = timezoneModel
        
        let loginModel = LoginModel()
        loginModel.uuid = self.user.login.uuid
        loginModel.username = self.user.login.username
        loginModel.password = self.user.login.password
        loginModel.salt = self.user.login.salt
        loginModel.md5 = self.user.login.md5
        loginModel.sha1 = self.user.login.sha1
        loginModel.sha256 = self.user.login.sha256
        
        let dobModel = DobModel()
        dobModel.date = self.user.dob.date
        dobModel.age = self.user.dob.age
        
        let registeredModel = DobModel()
        registeredModel.date = self.user.registered.date
        registeredModel.age = self.user.registered.age
        
        let idModel = IDModel()
        idModel.name = self.user.id.name
        idModel.value = self.user.id.value

        let pictureModel = PictureModel()
        pictureModel.large = self.user.picture.large
        pictureModel.medium = self.user.picture.medium
        pictureModel.thumbnail = self.user.picture.thumbnail
        
        let userModel = UserModel()
        userModel.gender = self.user.gender
        userModel.name = nameModel
        userModel.location = locationModel
        userModel.email = self.user.email
        userModel.login = loginModel
        userModel.dob = dobModel
        userModel.registered = registeredModel
        userModel.phone = self.user.phone
        userModel.cell = self.user.cell
        userModel.id = idModel
        userModel.picture = pictureModel
        userModel.nat = self.user.nat
        
        return userModel
    }
    
    private func seveUserAction() {
        let userModel = self.addUserModel()
        self.realm.beginWrite()
        self.realm.add(userModel)
        try! self.realm.commitWrite()
    }
    
    private func deleteUserModel() {
        DispatchQueue.main.async {
            autoreleasepool {
                let model = self.realm.objects(UserModel.self).filter({ (user) -> Bool in
                    user.email == self.user.email
                })
                if !model.isEmpty {
                    try! self.realm.write {
                        self.realm.delete(model)
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self.view.layoutIfNeeded()
                                self.saveUserButton.isSelected = false
                                self.saveUserButton.backgroundColor = UIColor.App.greenButton.color
                                self.saveUserButton.isUserInteractionEnabled = true
                                self.remopveUserButton.isHidden = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - @IBAction Methods -

    @IBAction func saveUserButtonAction(_ sender: UIButton) {
        guard !sender.isSelected else { return }
        
        self.seveUserAction()
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = UIColor.App.gray232.color
        sender.isUserInteractionEnabled = false
        self.remopveUserButton.isHidden = false
    }
    
    @IBAction func remopveUserButtonAction(_ sender: UIButton) {
        self.deleteUserModel()
    }
    
    @IBAction private func showDetailsImageGesture(_ sender: UIButton) {
        self.showFullScreenImageIfNeeded(self.user.picture.large)
    }
}

extension SaveAndRemoveUserViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if let mapAnnotation = self.mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
        mapAnnotation.animatesWhenAdded = true
        mapAnnotation.titleVisibility = .adaptive
        mapAnnotation.titleVisibility = .visible
        
        return mapAnnotation
    }
    
    return nil
  }
}
