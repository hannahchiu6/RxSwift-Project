//
//  ViewController.swift
//  RxSwift-Practice
//
//  Created by Hannah.C on 01.08.21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import MJRefresh

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!

    let vm = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "songCell")

        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerCell")

        setupTableView()

        setupRefresher()

        vm.getData()
    }

    func setupRefresher() {

      let footer = MJRefreshBackNormalFooter {

        self.vm.noMoreData.subscribe { [weak self] noMoreData in

          if noMoreData.element == true {

            self?.tableView.mj_footer?.endRefreshingWithNoMoreData()

          } else {

            self?.vm.getData()

            self?.tableView.mj_footer?.endRefreshing()

          }

        }.disposed(by: self.disposeBag)
      }

      tableView.mj_footer = footer
    }


    func setupTableView() {

        vm.songs.asObservable()
            .bind(to: tableView.rx.items) { (tableView, row, element) in

            let indexPath = IndexPath(row: row, section: 0)

            if row == 0 {

                let cell = self.tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell

                cell.setupImage()

                return cell

            } else {

                let cell = self.tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell

                cell.setupCell(model: element)

                return cell

            }

        }.disposed(by: disposeBag)


//        KKBoxManager.shared.songs.bind(to: tableView.rx.items(cellIdentifier: "songCell",cellType: SongTableViewCell.self)) { row, model, cell in
//
//            cell.setupCell(model: vm.songs.value[row])
//            cell.selectionStyle = .none
//
//        }.disposed(by: disposeBag)


//        tableView.rx.contentOffset.subscribe { [weak self] in
//          guard let self = self else {
//            return
//          }
//          let offsetY = ($0.element?.y ?? 0 ) + 48.0
//
//          if offsetY > 0 {
//            self.image.alpha = (self.image.frame.height - offsetY) / self.image.frame.height
//
//          } else {
//
//            self.image.alpha = 1
//            let zoomRatio = -offsetY / 500
//            self.image.transform = CGAffineTransform(scaleX: 1 + zoomRatio, y: 1 + zoomRatio)
//          }
//        }.disposed(by: disposeBag)

//        tableView.rx.contentOffset.asObservable()
//            .subscribe { [self] offset in
//                let topcell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
//                if offset.y < 0 {
//                    topcell?.frame.size.height = 500 - offset.y
//                    topcell?.frame.origin.y = offset.y
//                } else {
//                    topcell?.alpha = (500 - offset.y) / 500
//                }
//            }  onDisposed: {
//                print("tableView disposed")
//            }.disposed(by: disposeBag)

    }


}
