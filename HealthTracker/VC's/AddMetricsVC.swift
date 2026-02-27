//
//  AddMetricsVC.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import UIKit
import CoreData
import DropDown

class AddMetricsVC: UIViewController {
    
    lazy var header:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "Add Metrics", color: .black, align: .center, size: 12)
        lbl.font = FONTS.Nunito_Bold(size: 24).Identifier
        return lbl
    }()
    
    lazy var txtMetrics:CustomTxtHeader={
        let txt = CustomTxtHeader(Header: "Metrics".uppercased(), placeholder: "Select metrics",image: .arrowDown)
        txt.txtfield.delegate = self
        return txt
    }()
    
    lazy var metricPlaceholder:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "Select heart value", color: .black, align: .center, size: 12)
        lbl.font = FONTS.Nunito_Bold(size: 16).Identifier
        return lbl
    }()
    
    lazy var metricContr:UIView={
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        return v
    }()

    lazy var metricPicker:UIPickerView={
        let a = UIPickerView()
        a.backgroundColor = .clear
        return a
    }()
    
    lazy var metricUnitLbl:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "PPM", color: .black, align: .left, size: 12)
        lbl.font = FONTS.Nunito_Regular(size: 12).Identifier
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var addMinusContr:UIView={
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 25
        v.backgroundColor = UIColor.hexToColor(hex: "#F0F3F6")
        return v
    }()
    
    lazy var minusBtn:CustomImgBTN={
        let btn = CustomImgBTN(img: .minusIcon)
        return btn
    }()
    
    lazy var addBtn:CustomImgBTN={
        let btn = CustomImgBTN(img: .addIcon)
        return btn
    }()
    
    lazy var txtDatenTime:CustomTxtHeader={
        let txt = CustomTxtHeader(Header: "Date and Time".uppercased(), placeholder: "Select date and time",image: nil)
        txt.txtfield.delegate = self
        return txt
    }()
    
    lazy var saveBtn:CustomBTN={
        let btn = CustomBTN(title: "Save", bgColor: .systemBlue, textColor: .white, radii: 10)
        btn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return btn
    }()
    
    private var mDropDown = DropDown()
    var currentMetric = ""
    var range = Array(1...100)
    var selectedRange = 0
    var sysRange = Array(70...200)
    var diasRange = Array(40...130)
    var selSysRange = 0
    var selDiasRange = 0
    var selDate:Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupPickerView()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtMetrics.txtfield.text = ""
        changeMetricsUI()
        self.txtDatenTime.txtfield.text = formatDate(Date())
    }
    
    func setupSubviews(){
        view.addSubview(header)
        view.addSubview(txtMetrics)
        
        view.addSubview(metricPlaceholder)
        view.addSubview(metricContr)
        metricContr.addSubview(metricPicker)
        metricContr.addSubview(metricUnitLbl)
        
        view.addSubview(txtDatenTime)
        view.addSubview(saveBtn)
        
        setupLayout()
    }
}

extension AddMetricsVC{
    
    func setupPickerView() {
        metricPicker.delegate = self
        metricPicker.dataSource = self
        metricPicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func tapGesture(){
        self.view.endEditing(true)
    }
    
    @objc func handleDropdown(sender:UITextField){
        if sender == txtMetrics.txtfield{
            let metrics = [
                "Heart Rate",
                "Water Intake",
                "Steps",
                "Cholesterol Levels",
                "Sleep",
                "Body Temperature"
            ]
            
            mDropDown.dataSource = metrics
            mDropDown.anchorView = sender
            mDropDown.bottomOffset = CGPoint(x: 0, y:(mDropDown.anchorView?.plainView.bounds.height)!)
            mDropDown.width = sender.frame.width
            mDropDown.direction = .bottom
            mDropDown.show()
            
            mDropDown.selectionAction={ [weak self] (index: Int, item: String) in
                self?.metricContr.isHidden = false
                self?.txtMetrics.txtfield.text = item
                self?.changeMetricsUI()
            }
        }
    }
    
    @objc func handleSave(){
        if currentMetric != "" && selectedRange != 0{
            CoreDataHelp.addOrUpdateMetric(type:currentMetric, value: Double(selectedRange), date: selDate ?? Date())
        }else{
            self.makeToast(strMessage: "Select metric or metric value")
        }
    }
    
    func changeMetricsUI(){
        
        let c = self.txtMetrics.txtfield.text ?? ""
        
        switch c{
        case "Heart Rate":
            self.metricPlaceholder.text = "Select PPM value"
            self.metricUnitLbl.text = "PPM"
            range = Array(30...200)
            metricPicker.reloadAllComponents()
            currentMetric = "Heart Rate"
            break
        case "Water Intake":
            self.metricPlaceholder.text = "Select Water intake"
            self.metricUnitLbl.text = "L"
            range = Array(1...10)
            metricPicker.reloadAllComponents()
            currentMetric = "Water Intake"
        case "Steps":
            self.metricPlaceholder.text = "Select Steps"
            self.metricUnitLbl.text = "Steps"
            range = Array(0...100000)
            metricPicker.reloadAllComponents()
            currentMetric = "Steps"
            break
        case "Cholesterol Levels":
            self.metricPlaceholder.text = "Select level"
            self.metricUnitLbl.text = "mg/dL"
            range = Array(100...400)
            metricPicker.reloadAllComponents()
            currentMetric = "Cholesterol Levels"
            break
        case "Sleep":
            self.metricPlaceholder.text = "Select sleep hours"
            self.metricUnitLbl.text = "hours"
            range = Array(0...24)
            metricPicker.reloadAllComponents()
            currentMetric = "Sleep"
            break
        case "Body Temperature":
            self.metricPlaceholder.text = "Select temperature"
            self.metricUnitLbl.text = "°F"
            range = Array(95...108)
            metricPicker.reloadAllComponents()
            currentMetric = "Body Temperature"
            break
        default:
            self.metricPlaceholder.text = ""
            currentMetric = ""
            metricContr.isHidden = true
            break
        }
    }
}

extension AddMetricsVC:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtMetrics.txtfield{
            self.handleDropdown(sender: textField)
            return false
        }
        
        if textField == txtDatenTime.txtfield{
            let pickerVC = DateTimePickerVC()
            pickerVC.modalPresentationStyle = .overFullScreen
            pickerVC.modalTransitionStyle = .crossDissolve
            pickerVC.pickerMode = .dateAndTime
            pickerVC.delegate = self
            present(pickerVC, animated: true)
            return false
        }
        return true
    }
}

extension AddMetricsVC:DateTimePickerDelegate{
    func didSelectDate(_ date: Date, tag: Int) {
        print(date,tag)
        self.txtDatenTime.txtfield.text = formatDate(date)
        self.selDate = date
    }
    
    
}

extension AddMetricsVC: UIPickerViewDelegate, UIPickerViewDataSource,UIPickerViewAccessibilityDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return range.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(range[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let label = UILabel()
            label.text = "\(range[row])"
            label.textAlignment = .center
            return label
        }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRange = range[row]
        pickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
}

extension AddMetricsVC{
    func setupLayout(){
        
        header.anchorWith_TopLeftBottomRight_Padd(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 10, left: 20, bottom: 0, right: -20))
        
        txtMetrics.anchorWith_TopLeftBottomRight_Padd(top: header.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 30, left: 20, bottom: 0, right: -20))
        
        metricPlaceholder.anchorWith_TopLeftBottomRight_Padd(top: txtMetrics.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 20, left: 20, bottom: 0, right: -20))
        
        metricContr.anchorWith_TopLeftBottomRight_Padd(top: metricPlaceholder.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 10, left: 20, bottom: 0, right: -20))
        metricContr.anchorWith_Height(height: nil, const: 300)
        
        metricPicker.anchorWith_XY_TopLeftBottomRight_Padd(x: metricContr.centerXAnchor, y: nil, top: metricContr.topAnchor, left: nil, bottom: nil, right: nil,padd: .init(top: -50, left: 0, bottom: 0, right: 0))
        metricPicker.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 100, constHeight: 300)
        
        metricUnitLbl.anchorWith_XY_TopLeftBottomRight_Padd(x: nil, y: metricPicker.centerYAnchor, top: nil, left: metricPicker.trailingAnchor, bottom: nil, right: nil,padd: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        txtDatenTime.anchorWith_TopLeftBottomRight_Padd(top: metricContr.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 20, left: 20, bottom: 0, right: -20))
        
        saveBtn.anchorWith_TopLeftBottomRight_Padd(top: nil, left: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.trailingAnchor, padd: .init(top: 0, left: 30, bottom: -90, right: -30))
        saveBtn.anchorWith_Height(height: nil, const: 50)
       
    }
}
