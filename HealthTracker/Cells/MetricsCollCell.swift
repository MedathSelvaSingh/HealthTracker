//
//  MetricsCollCell.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 26/02/26.
//

import UIKit

class MetricsCollCell: UICollectionViewCell {
    
    lazy var contr:UIView={
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        v.backgroundColor = .red
        return v
    }()
    
    lazy var img:CustomIMG={
        let i = CustomIMG(image: .homeSelected)
        return i
    }()
    
    lazy var metricValueLbl:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "78 bpm", color: .white, align: .left, size: 12)
        lbl.font = FONTS.Nunito_Bold(size: 16).Identifier
        return lbl
    }()
    
    lazy var metricLbl:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "Cholestrol", color: .white, align: .left, size: 12)
        lbl.font = FONTS.Nunito_Regular(size: 14).Identifier
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
    }
    
    func setViews(){
        self.contentView.addSubview(contr)
        contr.addSubview(img)
        contr.addSubview(metricValueLbl)
        contr.addSubview(metricLbl)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        contr.anchorWith_TopLeftBottomRight_Padd(top: topAnchor, left:leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, padd: .init(top: 0, left: 0, bottom: 0, right: 0))
       
        img.anchorWith_TopLeftBottomRight_Padd(top: contr.topAnchor, left: contr.leadingAnchor, bottom: nil, right: nil, padd: .init(top: 10, left: 10, bottom: 0, right: 0))
        img.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 30, constHeight: 30)
        
        metricLbl.anchorWith_TopLeftBottomRight_Padd(top: nil, left: contr.leadingAnchor, bottom: contr.bottomAnchor, right: contr.trailingAnchor, padd: .init(top: 0, left: 10, bottom: -10, right: -10))
        
        metricValueLbl.anchorWith_TopLeftBottomRight_Padd(top: nil, left: contr.leadingAnchor, bottom: metricLbl.topAnchor, right: contr.trailingAnchor, padd: .init(top: 0, left: 10, bottom: -2, right: -10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
