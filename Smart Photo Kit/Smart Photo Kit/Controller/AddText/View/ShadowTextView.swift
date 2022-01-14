//
//  ShadowTextView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 30/12/2021.
//

import UIKit
protocol ShadowTextViewDelegate:class{
    func didTapCloseShadowTextViewButton()
    func widthSliderValueChange(value:CGFloat?)
    func heightSliderValueChange(value:CGFloat?)
    func blurSliderValueChange(value:CGFloat?)
    func pickShadowColorFinish(color:UIColor?)
}
class ShadowTextView: UIView {
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var blurSlider: CustomSlider!
    @IBOutlet weak var heightSlider: CustomSlider!
    @IBOutlet weak var widthSlider: CustomSlider!
    //
    weak var delegate: ShadowTextViewDelegate?
    let colors = Array(ColorModel.shareColor().reversed())
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        Bundle.main.loadNibNamed("ShadowTextView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //
        widthSlider.minimumValue = -10
        widthSlider.maximumValue = 10
        widthSlider.value = 0
        heightSlider.minimumValue = -10
        heightSlider.maximumValue = 10
        heightSlider.value = 0
        blurSlider.minimumValue = 0
        blurSlider.maximumValue = 2
        blurSlider.value = 0
        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        colorCollectionView.collectionViewLayout = layout
        let nibCell = UINib(nibName: "TextColorCollectionViewCell", bundle: nil)
        colorCollectionView.register(nibCell, forCellWithReuseIdentifier: "TextColorCollectionViewCell")
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
    }
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        delegate?.didTapCloseShadowTextViewButton()
    }
    
    @IBAction func widthSliderWasChange(_ sender: Any) {
        delegate?.widthSliderValueChange(value: CGFloat(widthSlider.value))
    }
    @IBAction func heightSliderWasChange(_ sender: Any) {
        delegate?.heightSliderValueChange(value: CGFloat(heightSlider.value))
    }
    @IBAction func blurSliderWasChange(_ sender: Any) {
        delegate?.blurSliderValueChange(value: CGFloat(blurSlider.value))
    }
}
extension ShadowTextView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "TextColorCollectionViewCell", for: indexPath) as! TextColorCollectionViewCell
        cell.colorView.layer.cornerRadius = 25
        cell.colorView.clipsToBounds = true
        cell.configCell(item: colors[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pickShadowColorFinish(color: colors[indexPath.row])
    }
}
