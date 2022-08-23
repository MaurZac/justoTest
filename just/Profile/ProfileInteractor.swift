//
//  ProfileInteractor.swift
//  just
//
//  Created by Mauricio Zarate Chula on 21/08/22.
//  
//

import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol {
   
    

    // MARK: Properties
    weak var presenter: ProfileInteractorOutputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol?
    var profileRes = [Profile]()
    
    func interGetData() {
        remoteDatamanager?.callApiRequestJust()
    }
}

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    
    func callBackApiData(with profile: [Profile]) {
        presenter?.inter2PresenPush(daraReceived: profile)
    }
}
