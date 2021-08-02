//
//  ViewModel.swift
//  RxSwift-Practice
//
//  Created by Hannah.C on 02.08.21.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {

    let isLoading = BehaviorSubject(value: false)

    let noMoreData = BehaviorSubject(value: false)

    var songArray: [Song] = []

    let tokenManager = TokenManager()

//    let songs: PublishSubject<[Song]> = PublishSubject()

    let songs = KKBoxManager.shared.songs

    let disposeBag = DisposeBag()

    func getData() {
        tokenManager.getToken { token in
            KKBoxManager.shared.fetchSongs(token) { songData in
                guard !songData.data.isEmpty else {
                  self.noMoreData.onNext(true)
                  self.isLoading.onNext(false)
                  return
                }

                self.songArray += songData.data

                KKBoxManager.shared.offset = self.songArray.count
                self.songs.accept(self.songs.value)
                self.isLoading.onNext(false)
            }
        }

    }

}
