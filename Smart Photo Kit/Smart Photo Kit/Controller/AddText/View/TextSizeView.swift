//
//  TextSizeView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 30/12/2021.
//

import UIKit
protocol TextSizeViewDelegate:class{
    func didCloseButtonTextSizeViewWasPressed()
    func textSizeSliderDidChange(value:Float?)
}
class TextSizeView: UIView {

    @IBOutlet weak var sliderView: CustomSlider!
    @IBOutlet var containerView: UIView!
    //
    weak var delegate:TextSizeViewDelegate?
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
        Bundle.main.loadNibNamed("TextSizeView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //
        sliderView.minimumValue = 10
        sliderView.maximumValue = 100
    }
    
    @IBAction func sliderValueChange(_ sender: Any) {
        delegate?.textSizeSliderDidChange(value: sliderView.value)
    }
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        delegate?.didCloseButtonTextSizeViewWasPressed()
    }
    
}
