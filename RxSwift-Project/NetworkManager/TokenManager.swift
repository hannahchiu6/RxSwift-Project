//
//  TokenManager.swift
//  RxSwift-Practice
//
//  Created by Hannah.C on 02.08.21.
//

import UIKit
import RxSwift
import RxCocoa
import KKBOXOpenAPISwift


class TokenManager {

    private let api = KKBOXOpenAPI(clientID: "7d536470f54e0cbd0e9afad5ae368163",
                           secret: "671be86508d17b838fd0227bb521732d")

    func getToken(completionHandler: @escaping (String) -> Void) {
      do {
        _ = try api.fetchAccessTokenByClientCredential { result in
          switch result {
          case .error(let error):
            print(error)
          case .success(let token):
            completionHandler(token.accessToken)
          }
        }
      } catch {
        print(error)
      }
    }
}
