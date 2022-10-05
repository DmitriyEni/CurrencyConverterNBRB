//
//  ViewController.swift
//  NormExchange

//
//  Created by Dmitriy Eni on 26.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var stackView: UIStackView!
    
    var currencys = [Currency]()
    var fields = [ExchangeField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        NetworkManager.getRates { [weak self] result in
            guard let self = self else { return }
            self.currencys = result
            print(self.currencys)
            self.spinner.stopAnimating()
            self.stackView.spacing = 3
            
            
            self.createInfoView()
            for item in self.currencys {
                self.createInfoView(item: item)
            }
        }
    }
    
    @objc func textDidChange(textField: UITextField) {
            if textField.text == "" {
                return
            }
            
            if textField.tag == 0 {
                for field in fields {
                    guard field.inputTextField.tag != 0 else { continue }
                    guard let currency = currencys.filter({ $0.id == field.inputTextField.tag }).first else { return }
                    let result = Double(textField.text ?? "0")! / currency.rate! * Double(currency.scale!)
                    field.inputTextField.text = String(format: "%.2f", result)
                }
            } else {
                guard let currency = currencys.filter({ $0.id == textField.tag }).first else { return }
                
                    let doubleByn = Double(textField.text ?? "0")!
                
                let byn = (doubleByn * currency.rate!) / currency.scale!
                for field in fields {
                    if field.inputTextField == textField {
                        continue
                    }
                    if field.inputTextField.tag == 0 {
                        field.inputTextField.text = String(format: "%.2f", byn)
                    } else {
                        guard let currency = currencys.filter({ $0.id == field.inputTextField.tag }).first else { return }
                        let result = byn / currency.rate! * Double(currency.scale!)
                        field.inputTextField.text = String(format: "%.2f", result)
                    }
                }
            }
        }

    private func createInfoView(item: Currency? = nil) {
        let field = ExchangeField()
        field.setupWith(item)
        field.inputTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .allEvents)
//        let field = UITextField()
//        field.tag = item?.id ?? 0
//        //        field.delegate = self
//        field.addTarget(self, action: #selector(textDidChange(textField:)), for: .allEvents)
//        field.borderStyle = .roundedRect
        self.stackView.addArrangedSubview(field)
        self.fields.append(field)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            for field in fields {
                guard field.tag != 0 else { continue }
                guard let currency = currencys.filter({ $0.id == field.tag }).first else {
                    view.endEditing(true)
                    return true }
                let result = Double(textField.text ?? "0")! / currency.rate! * Double(currency.scale!)
                field.inputTextField.text =  String(format: "%.2f", result)
            }
        } else {
            guard let currency = currencys.filter({ $0.id == textField.tag }).first else {
                view.endEditing(true)
                return true }
            let byn = Double(textField.text ?? "0")! / Double(currency.scale!) * currency.rate!
            for field in fields {
                guard field.tag != 0 else {
                    field.inputTextField.text = String(format: "%.2f", byn)
                    continue
                }
                guard let currency = currencys.filter({ $0.id == field.tag }).first else {
                    view.endEditing(true)
                    return true }
                let result = byn / currency.rate! * Double(currency.scale!)
                field.inputTextField.text = String(format: "%.2f", result)
            }
        }
        
        view.endEditing(true)
        return true
    }
}
