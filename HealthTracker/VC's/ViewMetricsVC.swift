//
//  ViewMetricsVC.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import UIKit
import DGCharts
import DropDown

class ViewMetricsVC: UIViewController,ChartViewDelegate{
    
    lazy var header:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "View Metrics", color: .black, align: .center, size: 12)
        lbl.font = FONTS.Nunito_Bold(size: 24).Identifier
        return lbl
    }()
    
    lazy var txtMetrics:CustomTxtHeader={
        let txt = CustomTxtHeader(Header: "Metrics".uppercased(), placeholder: "Select metrics",image: .arrowDown)
        txt.txtfield.delegate = self
        return txt
    }()
    
    lazy var dataContr:UIView={
        let v = UIView()
        v.isHidden = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var FilterSegment:UISegmentedControl={
        let view = UISegmentedControl(items: ["Morning","Afternoon","Evening","Default"])
        view.selectedSegmentIndex = 3
        view.translatesAutoresizingMaskIntoConstraints=false
        view.selectedSegmentTintColor = .red
        view.addTarget(self, action: #selector(segmentFilterAction(_:)), for: .valueChanged)
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 0
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        view.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        return view
    }()
    
    lazy var lineChartview:LineChartView={
        let v = LineChartView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var sortBtn:CustomImgBTN={
        let btn = CustomImgBTN(img: .ascending)
        btn.tag = 0
        btn.addTarget(self, action: #selector(handleSort), for: .touchUpInside)
        return btn
    }()
    
    lazy var filterBtn:CustomImgBTN={
        let btn = CustomImgBTN(img: .filterEdit)
        btn.addTarget(self, action: #selector(handleFilter), for: .touchUpInside)
        return btn
    }()
    
    lazy var tblView:UITableView={
        let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.delegate = self
        tbl.dataSource = self
        return tbl
    }()
    
    private var IdentifierMCell = "MetricCell"
    private var mDropDown = DropDown()
    private let filterModel = HealthListViewModel()
    private var filtType = "All"
    private var valSort = ""
    private var currentDayFilter:TimeRange?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        loadTbl()
        lineChartview.delegate = self
        lineChartview.chartDescription.enabled = false
        lineChartview.legend.enabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        filterModel.fetchData()
        
    }
    
    func setupSubviews(){
        view.addSubview(header)
        view.addSubview(txtMetrics)
        view.addSubview(lineChartview)
        view.addSubview(dataContr)
        dataContr.addSubview(FilterSegment)
        dataContr.addSubview(sortBtn)
        dataContr.addSubview(filterBtn)
        dataContr.addSubview(tblView)
        
        setupLayout()
    }
    
    func loadTbl(){
        tblView.register(MetricsTableViewCell.self, forCellReuseIdentifier: IdentifierMCell)
    }
    
    @objc func segmentFilterAction(_:UISegmentedControl){
        switch (FilterSegment.selectedSegmentIndex) {
        case 0:
            currentDayFilter = .morning
            self.filterModel.applyFilters(range: self.currentDayFilter, sortOrder: self.valSort, metricType: self.txtMetrics.txtfield.text ?? "")
            self.tblView.reloadData()
            break
        case 1:
            currentDayFilter = .afternoon
            self.filterModel.applyFilters(range: self.currentDayFilter, sortOrder: self.valSort, metricType: self.txtMetrics.txtfield.text ?? "")
            self.tblView.reloadData()
            break
        case 2:
            currentDayFilter = .evening
            self.filterModel.applyFilters(range: self.currentDayFilter, sortOrder: self.valSort, metricType: self.txtMetrics.txtfield.text ?? "")
            self.tblView.reloadData()
            break
        case 3:
            currentDayFilter = .none
            self.filterModel.applyFilters(range: self.currentDayFilter, sortOrder: self.valSort, metricType: self.txtMetrics.txtfield.text ?? "")
            self.tblView.reloadData()
            break
        default:
            currentDayFilter = .none
            self.filterModel.applyFilters(range: self.currentDayFilter, sortOrder: self.valSort, metricType: self.txtMetrics.txtfield.text ?? "")
            self.tblView.reloadData()
            break
        }
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
                self?.txtMetrics.txtfield.text = item
                self?.filterModel.applyFilters(range: self?.currentDayFilter, sortOrder: self!.valSort, metricType: item)
                self?.loadChartData()
                self?.tblView.reloadData()
            }
        }
    }
    

    @objc func handleFilter(){
        
        let filData = [
            "Today",
            "All"
        ]

        mDropDown.dataSource = filData
        mDropDown.anchorView = self.filterBtn
        mDropDown.bottomOffset = CGPoint(x: 0, y:(mDropDown.anchorView?.plainView.bounds.height)!)
        mDropDown.width = CGFloat(150)
        mDropDown.direction = .bottom
        mDropDown.show()
        
        mDropDown.selectionAction={ [weak self] (index: Int, item: String) in
            if index == 0{
                self?.filterModel.applyFilters(range: self?.currentDayFilter, sortOrder: self!.valSort, metricType: self?.txtMetrics.txtfield.text ?? "",filterType: item)
                self?.tblView.reloadData()
            }else{
                self?.filterModel.applyFilters(range: self?.currentDayFilter, sortOrder: self!.valSort, metricType: self?.txtMetrics.txtfield.text ?? "",filterType: item)
                self?.tblView.reloadData()
            }
        }
    }
    
    @objc func handleSort(){
        
        if sortBtn.tag == 0{
            self.valSort = "ascending"
            sortBtn.tag = 1
            sortBtn.setImage(.descending, for: .normal)
            self.filterModel.applyFilters(range: self.currentDayFilter, sortOrder: self.valSort, metricType: self.txtMetrics.txtfield.text ?? "")
            self.tblView.reloadData()
        }else{
            self.valSort = "descending"
            sortBtn.tag = 0
            sortBtn.setImage(.ascending, for: .normal)
            self.filterModel.applyFilters(range: self.currentDayFilter, sortOrder: self.valSort, metricType: self.txtMetrics.txtfield.text ?? "")
            self.tblView.reloadData()
        }
    }
    
    private func loadChartData() {
    
        let type = self.txtMetrics.txtfield.text ?? ""
        let allData = filterModel.filteredEntries
                    .filter { $0.metricType == type }
                    .sorted { $0.timestamp ?? Date() < $1.timestamp ?? Date() }
        
        if allData.isEmpty{
            lineChartview.data = nil
            self.dataContr.isHidden = true
            return
        }else{
            self.dataContr.isHidden = false
        }
       
        var entries: [ChartDataEntry] = []
        
        for (index, item) in allData.enumerated() {
            let entry = ChartDataEntry(
                x: item.timestamp?.timeIntervalSince1970 ?? 0,
                y: item.metricValue ?? 0
            )
            entries.append(entry)
        }
        
        setChart(entries: entries)
    }
    
    private func setChart(entries: [ChartDataEntry]) {
        let type = self.txtMetrics.txtfield.text ?? ""
        let dataSet = LineChartDataSet(entries: entries, label: type)
        
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = true
        dataSet.circleRadius = 4
        dataSet.lineWidth = 2
        dataSet.drawValuesEnabled = false
        
        dataSet.setColor(.systemRed)
        dataSet.setCircleColor(.systemRed)
        
        let data = LineChartData(dataSet: dataSet)
        
        lineChartview.data = data
        lineChartview.rightAxis.enabled = false
        lineChartview.xAxis.drawGridLinesEnabled = false
        lineChartview.leftAxis.drawGridLinesEnabled = false
        lineChartview.animate(xAxisDuration: 1.2)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        lineChartview.xAxis.valueFormatter = DefaultAxisValueFormatter { value, _ in
            let date = Date(timeIntervalSince1970: value)
            return formatter.string(from: date)
        }
    }

 
   
}

extension ViewMetricsVC:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtMetrics.txtfield{
            self.handleDropdown(sender: textField)
            return false
        }
       
        return true
    }
}

extension ViewMetricsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterModel.filteredEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierMCell, for: indexPath) as! MetricsTableViewCell
        
        if !filterModel.filteredEntries.isEmpty{
            let data = filterModel.filteredEntries[indexPath.row]
            cell.metricValueLbl.text = "\(data.metricValue ?? 0)"
            cell.timeLbl.text = formatDate(data.timestamp ?? Date())
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension ViewMetricsVC{
    func setupLayout(){
        
        header.anchorWith_TopLeftBottomRight_Padd(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 10, left: 30, bottom: 0, right: -30))
    
        txtMetrics.anchorWith_TopLeftBottomRight_Padd(top: header.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 10, left: 20, bottom: 0, right: -20))
        
        lineChartview.anchorWith_TopLeftBottomRight_Padd(top: txtMetrics.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 30, left: 20, bottom: 0, right: -20))
        lineChartview.anchorWith_Height(height: nil, const: 150)
        
        dataContr.anchorWith_TopLeftBottomRight_Padd(top: lineChartview.bottomAnchor, left: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.trailingAnchor, padd: .init(top: 0, left: 0, bottom: -80, right: 0))
        
        FilterSegment.anchorWith_TopLeftBottomRight_Padd(top: dataContr.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, padd: .init(top: 10, left: 50, bottom: 0, right: -50))
        FilterSegment.anchorWith_Height(height: nil, const: 30)
        
        sortBtn.anchorWith_XY_TopLeftBottomRight_Padd(x: nil, y: FilterSegment.centerYAnchor, top: nil, left: nil, bottom: nil, right: view.trailingAnchor, padd: .init(top: 0, left: 0, bottom: 0, right: -10))
        sortBtn.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 30, constHeight: 30)
        
        filterBtn.anchorWith_XY_TopLeftBottomRight_Padd(x: nil, y: FilterSegment.centerYAnchor, top: nil, left: view.leadingAnchor, bottom: nil, right: nil, padd: .init(top: 0, left: 10, bottom: 0, right: 0))
        filterBtn.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 30, constHeight: 30)
        
        tblView.anchorWith_TopLeftBottomRight_Padd(top: sortBtn.bottomAnchor, left: dataContr.leadingAnchor, bottom: dataContr.bottomAnchor, right: dataContr.trailingAnchor, padd: .init(top: 10, left: 20, bottom: 0, right: -20))
       
    }
}


