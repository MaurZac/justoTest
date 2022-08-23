//
//  ProfileProtocols.swift
//  just
//
//  Created by Mauricio Zarate Chula on 21/08/22.
//  
//

import Foundation
import UIKit

protocol ProfileViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: ProfilePresenterProtocol? { get set }
    func presen2DataView(recViewData: [Profile])
}

protocol ProfileWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createProfileModule() -> UIViewController
}

protocol ProfilePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol ProfileInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func inter2PresenPush(daraReceived: [Profile]) 
}

protocol ProfileInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
    
    func interGetData()
}

protocol ProfileDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol ProfileRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    func callApiRequestJust()
}

protocol ProfileRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func callBackApiData(with profile: [Profile])
}

protocol ProfileLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
