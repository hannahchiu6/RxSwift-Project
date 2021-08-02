//
//  SongTableViewCell.swift
//  RxSwift-Practice
//
//  Created by Hannah.C on 01.08.21.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class SongTableViewCell: UITableViewCell {

    @IBOutlet var songImage: UIImageView!

    @IBOutlet var songTitleLabel: UILabel!

    @IBOutlet var heartButton: UIButton!

    let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

        heartButton.rx.tap.asObservable() 
            .subscribe(onNext: { [weak self] _ in
                self!.heartButton.image(for: .selected)

            }).disposed(by: disposeBag)



    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupCell(model: Song) {
        let imageUrl = URL(string: model.album.images[0].url)
        songImage.kf.setImage(with: imageUrl)

        songTitleLabel.text = model.name

    }
    
}
