//
//  ProfilePresenter.swift
//  just
//
//  Created by Mauricio Zarate Chula on 21/08/22.
//  
//

import Foundation

class ProfilePresenter  {
    
    // MARK: Properties
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
}

extension ProfilePresenter: ProfilePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.interGetData()
    }
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    func inter2PresenPush(daraReceived: [Profile]) {
        view?.presen2DataView(recViewData: daraReceived)
        
    }
    
    // TODO: implement interactor output methods
}
