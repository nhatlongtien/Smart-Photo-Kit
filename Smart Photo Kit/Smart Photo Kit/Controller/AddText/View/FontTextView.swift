//
//  FontTextView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 11/01/2022.
//

import UIKit
protocol FontTextViewDelegate:class{
    func didTapCloseFontTextView()
    func didFininshSelectFont(fontName:String)
}
class FontTextView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var fontCollectionView: UICollectionView!
    //
    let fonts = Constant.fonts
    weak var delegate:FontTextViewDelegate?
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        Bundle.main.loadNibNamed("FontTextView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //TODO: - Setup collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        fontCollectionView.collectionViewLayout = layout
        let nibCel = UINib(nibName: "FontCollectionViewCell", bundle: nil)
        fontCollectionView.register(nibCel, forCellWithReuseIdentifier: "FontCollectionViewCell")
        fontCollectionView.delegate = self
        fontCollectionView.dataSource = self
    }
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        delegate?.didTapCloseFontTextView()
    }
    
}

extension FontTextView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fontCollectionView.dequeueReusableCell(withReuseIdentifier: "FontCollectionViewCell", for: indexPath) as! FontCollectionViewCell
        cell.configCell(item: fonts[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didFininshSelectFont(fontName: fonts[indexPath.row])
    }
}
