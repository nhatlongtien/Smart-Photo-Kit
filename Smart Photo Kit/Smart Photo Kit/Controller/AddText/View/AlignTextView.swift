//
//  AlignTextView.swift
//  Smart Photo Kit
//
//  Created by Tien Nguyen on 19/01/2022.
//

import UIKit
protocol AlignTextViewDelegate:class{
    func didtapCloseAlignTextView()
    func didTapLeftAlign()
    func didTapCenterAlign()
    func didTapRightAlign()
}
class AlignTextView: UIView {

    @IBOutlet var containerView: UIView!
    weak var delegate:AlignTextViewDelegate?
    
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
        Bundle.main.loadNibNamed("AlignTextView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        delegate?.didtapCloseAlignTextView()
    }
    @IBAction func leftAlignButtonWasPressed(_ sender: Any) {
        delegate?.didTapLeftAlign()
    }
    @IBAction func centerAlignButtonWasPressed(_ sender: Any) {
        delegate?.didTapCenterAlign()
    }
    @IBAction func rightAlignButtonWasPressed(_ sender: Any) {
        delegate?.didTapRightAlign()
    }
    
}
