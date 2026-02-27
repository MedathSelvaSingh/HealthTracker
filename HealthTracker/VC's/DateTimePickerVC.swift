//
//  DateTimePickerVC.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 26/02/26.
//

import UIKit

protocol DateTimePickerDelegate: AnyObject {
    func didSelectDate(_ date: Date, tag: Int)
}

enum PickerMode {
    case date
    case time
    case dateAndTime
}

class DateTimePickerVC: UIViewController {

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return picker
    }()
    
    lazy var cancelButton: CustomBTN = {
        let button = CustomBTN(title: "Cancel", bgColor: .clear, textColor: .black, radii: 0)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: CustomBTN = {
        let button = CustomBTN(title: "Done", bgColor: .clear, textColor: .blue, radii: 0)
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()

    
    weak var delegate: DateTimePickerDelegate?
    var pickerMode: PickerMode = .dateAndTime
    var selectedDate: Date = Date()
    var tagIndex: Int = 0

 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configurePicker()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        view.addSubview(containerView)
        containerView.addSubview(cancelButton)
        containerView.addSubview(doneButton)
        containerView.addSubview(datePicker)
        
        setupConstraints()
    }
    
    private func configurePicker() {
        switch pickerMode {
        case .date:
            datePicker.datePickerMode = .date
        case .time:
            datePicker.datePickerMode = .time
        case .dateAndTime:
            datePicker.datePickerMode = .dateAndTime
        }
        
        datePicker.date = selectedDate
        datePicker.maximumDate = Date()
    }
    
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handleDone() {
        delegate?.didSelectDate(datePicker.date, tag: tagIndex)
        dismiss(animated: true)
    }
}

extension DateTimePickerVC {
    
    private func setupConstraints() {
        
        containerView.anchorWith_TopLeftBottomRight_Padd(top: nil, left: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.trailingAnchor, padd: .init(top: 10, left: 10, bottom: -5, right: -10))
        containerView.anchorWith_Height(height: nil, const: 300)
        
        cancelButton.anchorWith_TopLeftBottomRight_Padd(top: nil, left: view.leadingAnchor, bottom: containerView.bottomAnchor, right: view.centerXAnchor, padd: .init(top: 0, left: 10, bottom: -10, right: -5))
        cancelButton.anchorWith_Height(height: nil, const: 30)
        
        doneButton.anchorWith_TopLeftBottomRight_Padd(top: nil, left: view.centerXAnchor, bottom: containerView.bottomAnchor, right: view.trailingAnchor, padd: .init(top: 0, left: 5, bottom: -10, right: -10))
        doneButton.anchorWith_Height(height: nil, const: 30)
        
        datePicker.anchorWith_TopLeftBottomRight_Padd(top: containerView.topAnchor, left: view.leadingAnchor, bottom: cancelButton.topAnchor, right: view.trailingAnchor, padd: .init(top: 10, left: 10, bottom: -10, right: -10))
        
    }
}
