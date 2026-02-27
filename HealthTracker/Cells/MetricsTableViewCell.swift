//
//  MetricsTableViewCell.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 26/02/26.
//

import UIKit

class MetricsTableViewCell: UITableViewCell {
    
    lazy var contr:UIView={
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var metricValueLbl:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "", color: .black, align: .left, size: 12)
        lbl.font = FONTS.Nunito_Regular(size: 16).Identifier
        return lbl
    }()
    
    lazy var timeLbl:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "", color: .black, align: .right, size: 12)
        lbl.font = FONTS.Nunito_Regular(size: 16).Identifier
        return lbl
    }()
    
   
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        
        tbSetupView()
    }
    
    func tbSetupView(){
        
        self.contentView.addSubview(contr)
        contr.addSubview(metricValueLbl)
        contr.addSubview(timeLbl)
        
       
        tbSetupLayout()
    }
    
    func tbSetupLayout(){
        
        contr.anchorWith_TopLeftBottomRight_Padd(top: topAnchor, left: leadingAnchor, bottom:bottomAnchor , right: trailingAnchor, padd: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        metricValueLbl.anchorWith_XY_TopLeftBottomRight_Padd(x: nil, y: contr.centerYAnchor, top: nil, left: contr.leadingAnchor, bottom: nil, right: nil, padd: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        timeLbl.anchorWith_XY_TopLeftBottomRight_Padd(x: nil, y: contr.centerYAnchor, top: nil, left: nil, bottom: nil, right: contr.trailingAnchor, padd: .init(top: 0, left: 0, bottom: 0, right: -10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
