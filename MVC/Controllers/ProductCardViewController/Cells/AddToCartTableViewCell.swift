//
//  AddToCartTableViewCell.swift
//  cerenadaApp
//
//  Created by Артем Кудрявцев on 13.12.2022.
//

import UIKit

protocol AddToCartDelegate {
    func stepper(_ stepper: UIStepper, at index: Int, didChangeValueTo newValue: Double)
    func textFieldChange(_ stepper: UIStepper, _ textField: UITextField)
}

class AddToCartTableViewCell: UITableViewCell {
    
    var delegate: AddToCartDelegate?
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 14)
        label.textColor = .systemGray
        return label
    }()
    
    let countOrderTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.1
        textField.placeholder = "-"
        textField.textColor = .systemGray
        textField.font = UIFont(name: "Helvetica", size: 14)
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return textField
    }()
    
    let stepperForCountOrder: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.transform = CGAffineTransformMakeScale(0.7, 0.7)
        stepper.autorepeat = true
        stepper.minimumValue = 0
        stepper.stepValue = 1
        stepper.maximumValue = 999
        return stepper
    }()
    
    var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.makeShadow()
        button.backgroundColor = #colorLiteral(red: 0.9072937369, green: 0.3698979914, blue: 0.4464819431, alpha: 1)
        button.setImage(UIImage(systemName: "cart.fill.badge.plus"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createViews()
        stepperForCountOrder.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        countOrderTextField.addTarget(self, action: #selector(changeTfValue), for: .editingChanged)
    }
    
    @objc func changeValue(sender: UIStepper) {
        
        let counter = Int(sender.value)
        
        if counter == 0 {
            countOrderTextField.text = ""
            countOrderTextField.placeholder = "-"
        } else {
            countOrderTextField.text = String(counter)
        }
        
        productCounter = countOrderTextField.text ?? "0"
        delegate?.stepper(stepperForCountOrder, at: stepperForCountOrder.tag, didChangeValueTo: stepperForCountOrder.value)
    }
    
    @objc func changeTfValue(sender: UITextField) {
                
        if sender.text != "" {
            stepperForCountOrder.value = Double(sender.text ?? "0.0") ?? 0.0
            
            productCounter = countOrderTextField.text ?? "0"
        }
        
        delegate?.textFieldChange(stepperForCountOrder, countOrderTextField)
    }
    
    func createViews() {
        
        addSubview(stackView)
        stackView.addArrangedSubview(sizeLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(countOrderTextField)
        stackView.addArrangedSubview(stepperForCountOrder)
        stackView.addArrangedSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            
            countOrderTextField.widthAnchor.constraint(equalToConstant: 30),
            countOrderTextField.heightAnchor.constraint(equalToConstant: 30),
                        
            addToCartButton.heightAnchor.constraint(equalToConstant: 30),
            addToCartButton.widthAnchor.constraint(equalToConstant: 60),
                        
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
}
