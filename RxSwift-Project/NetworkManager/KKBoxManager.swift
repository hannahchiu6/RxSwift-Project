//
//  KKBoxManager.swift
//  RxSwift-Practice
//
//  Created by Hannah.C on 02.08.21.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import Alamofire

class KKBoxManager {

    var offset = 0

    static let shared = KKBoxManager()

    let songs: BehaviorRelay<[Song]> = BehaviorRelay(value: [])

    func fetchSongs(_ token: String, completionHandeler: @escaping (SongData) -> Void) {

        let url = "https://api.kkbox.com/v1.1/new-hits-playlists/DZrC8m29ciOFY2JAm3/tracks"

        let headers: HTTPHeaders = [
          "Host": "api.kkbox.com",
          "Authorization": "Bearer WzD1ZwNEWp1Rv5N_euLt6g=="
        ]

        let parameters = [
          "territory": "TW",
          "offset": String(offset),
          "limit": "20"
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: SongData.self) { response in

            switch response.result {

            case .success(let song):

                print("Song fetched success!")
                self.songs.accept(song.data)

                completionHandeler(song)

            case .failure(let error):
                print(error)
            }
        }
    }
}
