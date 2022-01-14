//
//  TextColorView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 29/12/2021.
//

import UIKit
protocol TextColorViewDelegate:class{
    func didTapCloseTextColorButton()
    func didFinishPickColor(color:UIColor?)
}
class TextColorView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    //
    let colors = Array(ColorModel.shareColor().reversed())
    weak var delegate:TextColorViewDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        Bundle.main.loadNibNamed("TextColorView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //set up collectionview
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        colorCollectionView.collectionViewLayout = layout
        let nibCell = UINib(nibName: "TextColorCollectionViewCell", bundle: nil)
        colorCollectionView.register(nibCell, forCellWithReuseIdentifier: "TextColorCollectionViewCell")
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
    }
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        delegate?.didTapCloseTextColorButton()
    }
}
extension TextColorView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "TextColorCollectionViewCell", for: indexPath) as! TextColorCollectionViewCell
        cell.configCell(item: colors[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didFinishPickColor(color: colors[indexPath.row])
    }
}
