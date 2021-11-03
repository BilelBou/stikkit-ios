//
//  StickersViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 13/09/2021.
//

import UIKit

protocol StickersViewControllerDelegate: AnyObject {
    func didTapCell(sticker: stickerModel, pos: GeoModel)
}

class StickersViewController: UIViewController {
    weak var delegate: StickersViewControllerDelegate?

    var stickersTab: [stickerModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.stickersTableView.reloadData()
            }
        }
    }

    private lazy var label = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "My stickers".typography(.title2)
    }

    lazy var stickersTableView = UITableView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(StickerTableViewCell.self)
        $0.rowHeight = 80
        $0.alwaysBounceVertical = false
        $0.backgroundColor = UIColor.clear
        $0.isOpaque = false
        $0.tableFooterView = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        AuthAPI.shared.getStickers { (stickers) in
            self.stickersTab = stickers
        }
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AuthAPI.shared.getStickers { myStickers in
            self.stickersTab = myStickers
        }
    }

    private func configure() {
        view.addSubview(label)
        view.addSubview(stickersTableView)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._12),

            stickersTableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: Margin._20),
            stickersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stickersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stickersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension StickersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stickersTab.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StickerTableViewCell = stickersTableView.dequeue(for: indexPath)
        cell.configure(name: stickersTab[indexPath.row].stickerId, date: stickersTab[indexPath.row].creationDate)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch stickersTab[indexPath.row].stickerId {
        case "Prototype":
            delegate?.didTapCell(sticker: stickersTab[indexPath.row], pos: GeoModel(latitude: 43.695804221981724, longitude: 7.269651956133283))
        case "test1":
            delegate?.didTapCell(sticker: stickersTab[indexPath.row], pos: GeoModel(latitude: 43.69601029076336, longitude: 7.277102691102712))
        case "test2":
            delegate?.didTapCell(sticker: stickersTab[indexPath.row], pos: GeoModel(latitude: 43.70159515127883, longitude: 7.265858870982911))
        case "test3":
            delegate?.didTapCell(sticker: stickersTab[indexPath.row], pos: GeoModel(latitude: 43.697685803582445, longitude: 7.278819304876558))
        default:
            break
        }
    }
}
