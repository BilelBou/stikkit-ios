import UIKit

import Kingfisher

final class MyProfileViewController: Controller {
    private var username: String = ""
    let defaults = UserDefaults.standard
    private var groups: [GroupModel] = [GroupModel(createdAt: "2021-10-21T17:15:06.481Z", id: "123", ownerID: "1", name: "Family", users: [User(id: 1, name: "Bilel", image: "public/img/users/default.png"), User(id: 2, name: "Hugo", image: "public/img/users/default.png"), User(id: 3, name: "Tristan", image: "public/img/users/default.png")]),
                                        GroupModel(createdAt: "2021-10-21T17:15:06.481Z", id: "123", ownerID: "1", name: "Friends", users: [])]

    private lazy var profilePicture = UIImageView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        let ressource = ImageResource(downloadURL: URL(string: "https://api.stikkit.fr/" + defaults.string(forKey: "image")!)!)
        $0.kf.setImage(with: ressource)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 60
        $0.contentMode = .scaleAspectFill
    }

    //    private lazy var createGroupeLabel = UILabel()..{
    //        $0.translatesAutoresizingMaskIntoConstraints = false
    //        $0.attributedText = Icon.App.addEmote.typographyIcon(font: Font.Icon._30, alignment: .center)
    //        $0.isUserInteractionEnabled = true
    //        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNewGroup)))
    //        $0.backgroundColor = Color.buttonColor
    //        $0.layer.cornerRadius = 20
    //        $0.clipsToBounds = true
    //    }

    private lazy var createGroupButton = IconButton(icon: Icon.App.plus, title: "Create a new group")..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = Color.buttonColor
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNewGroup)))
    }

    private lazy var createStickerLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = Icon.App.plus.typographyIcon(font: Font.Icon._30, alignment: .center)
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNewSticker)))
        $0.backgroundColor = Color.buttonColor
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }

    private lazy var stickerCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()..{
        $0.sectionInset = .zero
        $0.scrollDirection = .horizontal
    }

    lazy var groupsCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: stickerCollectionViewLayout)..{
        $0.dataSource = self
        $0.delegate = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.backgroundColor
        //$0.contentInset = UIEdgeInsets(top: Margin._8, left: Margin._8, bottom: 0, right: Margin._8)
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.register(StickerCollectionViewCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.backgroundColor
        updateNavigationBar(NavTitleStyle.title(username), titleColor: Color.white, rightButton: .option, rightColor: Color.white)
    }

    init(username: String) {
        super.init()
        self.username = username
        configureStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didTapOption() {
        let alert = UIAlertController(title: "Log Out", message: "You want to log out ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { alertAction in
            self.defaults.removeObject(forKey: "id")
            self.defaults.removeObject(forKey: "firstName")
            self.defaults.removeObject(forKey: "lastName")
            self.defaults.removeObject(forKey: "email")
            self.defaults.removeObject(forKey: "phone")
            self.defaults.removeObject(forKey: "image")
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    private func configureStyle() {
        view.addSubview(profilePicture)
        //view.addSubview(createGroupeLabel)
        view.addSubview(createStickerLabel)
        view.addSubview(groupsCollectionView)
        view.addSubview(createGroupButton)

        NSLayoutConstraint.activate([
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._30),
            profilePicture.heightAnchor.constraint(equalToConstant: 120),
            profilePicture.widthAnchor.constraint(equalToConstant: 120),

            groupsCollectionView.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: Margin._30),
            groupsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            groupsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            groupsCollectionView.heightAnchor.constraint(equalToConstant: 100),

            //            createGroupeLabel.heightAnchor.constraint(equalToConstant: 60),
            //            createGroupeLabel.widthAnchor.constraint(equalToConstant: 60),
            //            createGroupeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margin._20),
            //            createGroupeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),

            createGroupButton.topAnchor.constraint(equalTo: groupsCollectionView.bottomAnchor, constant: Margin._20),
            createGroupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            createGroupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            createGroupButton.heightAnchor.constraint(equalToConstant: 60),

            createStickerLabel.heightAnchor.constraint(equalToConstant: 60),
            createStickerLabel.widthAnchor.constraint(equalToConstant: 60),
            createStickerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margin._20),
            createStickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20)
        ])
    }

    @objc func didTapNewGroup() {
        let vc = CreateGroupController(type: .group)
        present(vc, animated: true)
    }

    @objc func didTapNewSticker() {
        let vc = CreateGroupController(type: .stickers)
        present(vc, animated: true)
    }
}


extension MyProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StickerCollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.configure(name: groups[indexPath.row].name, users: groups[indexPath.row].users)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = MapViewController()
        //        vc.navigationController?.view.backgroundColor = .clear
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width - 30, height: 100)
    }
}
