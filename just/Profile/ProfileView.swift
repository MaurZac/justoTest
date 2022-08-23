//
//  ProfileView.swift
//  just
//
//  Created by Mauricio Zarate Chula on 21/08/22.
//  
//

import Foundation
import UIKit

class ProfileView: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.isHidden = true
        profilePic.makeRounded()
        presenter?.viewDidLoad()
        print(profResView)
    }
    
    
    
}

extension ProfileView: ProfileViewProtocol {
    
    func presen2DataView(recViewData: [Profile]) {
        profResView = recViewData
        DispatchQueue.main.async { [self] in
            profilePic.downloaded(from: profResView[0].results?[0].picture?.medium ?? "noimage")
            nameLbl.text = profResView[0].results?[0].name?.first
            ageLbl.text = String(profResView[0].results?[0].dob?.age ?? 0)
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

