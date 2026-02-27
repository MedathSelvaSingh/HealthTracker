//
//  DashboardVC.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import UIKit


class DashboardVC: UIViewController {
        
    lazy var header:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "Good Morning..!", color: .black, align: .left, size: 24)
        lbl.font = FONTS.Nunito_ExtraBold(size: 24).Identifier
        return lbl
    }()
    
    lazy var subHeader:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "", color: .lightGray, align: .left, size: 16)
        lbl.font = FONTS.Nunito_Bold(size: 16).Identifier
        return lbl
    }()
    
    lazy var profileImg:CustomIMG={
        let img = CustomIMG(image: .healthIcon)
        return img
    }()
    
    lazy var menuColl:UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.delegate = self
        coll.dataSource = self
        coll.translatesAutoresizingMaskIntoConstraints = false
        return coll
    }()
    
    private var IdentifierMColl = "metricCellColl"
    private let filterHealthModel = HealthListViewModel()
    
    private let metrics = [
        "Heart Rate",
        "Water Intake",
        "Steps",
        "Cholesterol Levels",
        "Sleep",
        "Body Temperature"
    ]
    
    private let metricsVal = [
        "PPM",
        "L",
        "Steps",
        "mg/dL",
        "hours",
        "°F"
    ]
    
    private let metricsColor = [
    "F2545B",
    "735CDD",
    "2196F3",
    "5E548E",
    "F4A261",
    "4CAF50"
    ]
    
    private let metricsImage:[UIImage]=[.heartrate,.water,.steps,.cholosetrol,.sleep,.temperature]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadColl()
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        filterHealthModel.fetchData()
        menuColl.reloadData()
        self.subHeader.text = formatDateToday(Date())
    }
    
    func setupSubviews(){
        
        view.addSubview(header)
        view.addSubview(subHeader)
        view.addSubview(profileImg)
        view.addSubview(menuColl)
    
        setupLayout()
    }
    
    func loadColl(){
        menuColl.register(MetricsCollCell.self, forCellWithReuseIdentifier: IdentifierMColl)
    }
}

extension DashboardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return metrics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdentifierMColl, for: indexPath) as! MetricsCollCell
        
        let metric = metrics[indexPath.row]
        let metricUnit = metricsVal[indexPath.row]
        let metricColor = metricsColor[indexPath.row]
        let metricImg = metricsImage[indexPath.row]
        cell.metricLbl.text = metric
        let metricVal = Int(filterHealthModel.getRecentData(type: metric) ?? 0)
        cell.metricValueLbl.text = "\(metricVal) \(metricUnit)"
        cell.contr.backgroundColor = UIColor.hexToColor(hex: metricColor)
        cell.img.image = metricImg
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wdth = (UIScreen.main.bounds.width - 60) / 2
        return CGSize(width:wdth , height: 150)
    }
}

extension DashboardVC{
    func setupLayout(){
       
        header.anchorWith_TopLeftBottomRight_Padd(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: nil, right: nil, padd: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        subHeader.anchorWith_TopLeftBottomRight_Padd(top: header.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: nil, padd: .init(top: 2, left: 20, bottom: 0, right: 0))
        
        profileImg.anchorWith_TopLeftBottomRight_Padd(top: header.topAnchor, left: nil, bottom: nil, right: view.trailingAnchor, padd: .init(top: 0, left: 0, bottom: 0, right: -20))
        profileImg.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 50, constHeight: 50)
        
        menuColl.anchorWith_TopLeftBottomRight_Padd(top: subHeader.bottomAnchor, left: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.trailingAnchor, padd: .init(top: 30, left: 20, bottom: -50, right: -20))
        
    }
}

