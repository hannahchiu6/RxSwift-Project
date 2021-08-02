//
//  HeaderTableViewCell.swift
//  RxSwift-Practice
//
//  Created by Hannah.C on 02.08.21.
//

import UIKit
import Kingfisher

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setupImage() {
        let imgUrl = URL(string: "https://i.kfs.io/playlist/global/26541395v266/cropresize/600x600.jpg")
        headerImage.kf.setImage(with: imgUrl)

    }

}
