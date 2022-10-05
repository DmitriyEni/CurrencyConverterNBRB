//
//  ExchangeField.swift
//  NormExchange
//
//  Created by Dmitriy Eni on 26.05.2022.
//

import UIKit

class ExchangeField: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
  
    func setupWith(_ currency: Currency? = nil) {
            currencyLabel.text = "\(currency?.abb! ?? "BYN"):"
            inputTextField.tag = currency?.id ?? 0
            
            guard let currency = currency,
                  currency.abb.lowercased() != "xdr"
            else {
                setupImage(url: URL(string: "https://wise.com/public-resources/assets/flags/rectangle/byn.png")!)
                return
            }
            
            let abb = currency.abb!
            setupImage(url: URL(string: "https://wise.com/public-resources/assets/flags/rectangle/\(abb.lowercased()).png")!)
        }
        
        private func setupImage(url: URL) {
            guard let imgData = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: imgData as Data) else { return }
            flagImageView.image = image
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonImit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonImit()
    }
    
    private func commonImit() {
        let bundle = Bundle(for: ExchangeField.self)
        bundle.loadNibNamed(String(describing: ExchangeField.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
