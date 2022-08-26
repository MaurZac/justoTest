//
//  ProfileRemoteDataManager.swift
//  just
//
//  Created by Mauricio Zarate Chula on 21/08/22.
//  
//

import Foundation

class ProfileRemoteDataManager:ProfileRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol?
    
    func callApiRequestJust() {
          guard let url = URL(string: "https://randomuser.me/api/") else { return }
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
             
              if let data = data {
                  print(data)
                  if let res = try? JSONDecoder().decode(Profile.self, from: data) {
                      remoteRequestHandler?.callBackApiData(with: [res])
                      
                  } else {
                      print("Invalid Response")
                  }
              } else if let error = error {
                  print("HTTP Request Failed \(error)")
              }
          }
          task.resume()
      }
    
}
