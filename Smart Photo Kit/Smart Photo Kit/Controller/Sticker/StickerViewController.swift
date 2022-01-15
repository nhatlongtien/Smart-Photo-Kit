//
//  StickerViewController.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 14/01/2022.
//

import UIKit
import SnapKit
protocol StickerViewControllerDelegate:class{
    func passStickerImage(sticker:UIImage?)
}
class StickerViewController: UIViewController {

    @IBOutlet weak var stickerTableView: UITableView!
    //
    var sticker:[StickerModel] = []
    weak var delegate:StickerViewControllerDelegate?
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let nibCell = UINib(nibName: "StickerTableViewCell", bundle: nil)
        stickerTableView.register(nibCell, forCellReuseIdentifier: "StickerTableViewCell")
        stickerTableView.delegate = self
        stickerTableView.dataSource = self
    }
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension StickerViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sticker.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stickerTableView.dequeueReusableCell(withIdentifier: "StickerTableViewCell", for: indexPath) as! StickerTableViewCell
        cell.configCell(listSticker: sticker[indexPath.section].listItem)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        let titleLbl = UILabel()
        headerView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        titleLbl.textColor = .white
        titleLbl.text = sticker[section].groupName?.uppercased()
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
extension StickerViewController:StickerTableViewCellDelegate{
    func didFinishSelectStickerImg(sticker: UIImage?) {
        delegate?.passStickerImage(sticker: sticker)
        self.dismiss(animated: true, completion: nil)
    }
}

