//
//  CustomViews.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import Foundation
import UIKit

class CustomTxtHeader:UIView{
    
    lazy var header:UILabel={
        let lbl = UILabel()
        lbl.setCustomLBL(str: "", color: .black, align: .center, size: 12)
        lbl.font = FONTS.Nunito_Regular(size: 14).Identifier
        lbl.backgroundColor = .white
        return lbl
    }()
    
    lazy var txtfield:CustomTextfield={
        let txt = CustomTextfield(placeholder: "")
        return txt
    }()
    
    lazy var img:CustomImgBTN={
        let img = CustomImgBTN(img: nil)
        return img
    }()
    
    required init(Header:String,placeholder:String,image:UIImage?=nil) {
        super.init(frame: .zero)
    
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints=false
        self.isUserInteractionEnabled = true
        self.header.text = " \(Header) "
        self.txtfield.setPlaceholder(str: placeholder, color: .gray)
        self.img.setImage(image, for: .normal)
        
        self.addSubview(txtfield)
        self.addSubview(header)
        
        txtfield.anchorWith_TopLeftBottomRight_Padd(top: self.topAnchor, left: self.leadingAnchor, bottom: self.bottomAnchor, right: self.trailingAnchor, padd: .init(top: 10, left: 0, bottom: 0, right: 0))
        txtfield.anchorWith_Height(height: nil, const: 40)
        
        if image != nil{
            self.addSubview(img)
            
            img.anchorWith_XY_TopLeftBottomRight_Padd(x: nil, y: txtfield.centerYAnchor, top: nil, left: nil, bottom: nil, right: txtfield.trailingAnchor, padd: .init(top: 0, left: 0, bottom: 0, right: -10))
            img.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 20, constHeight: 20)
        }
        
        header.anchorWith_TopLeftBottomRight_Padd(top: txtfield.topAnchor, left: txtfield.leadingAnchor, bottom: nil, right: nil, padd: .init(top: -9, left: 10, bottom: 0, right: 0))
        
        self.anchorWith_Height(height: nil, const: 60)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextfield:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.blue.cgColor
        self.textColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.gray.cgColor
        self.textColor = .black
    }
}

class CustomTextfield:UITextField{
    
    lazy var sep:UIView={
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints=false
        return view
    }()
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 20, y: bounds.origin.y, width: bounds.width - 50, height: bounds.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 20, y: bounds.origin.y , width: bounds.width - 50, height: bounds.height)
    }
    
    required init(placeholder:String) {
        super.init(frame: .zero)
        
        self.setPlaceholder(str: placeholder, color: .lightGray)
        self.translatesAutoresizingMaskIntoConstraints=false
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        self.textColor = .black
        self.textAlignment = .left
        self.font = FONTS.Nunito_Regular(size: 14).Identifier
        self.delegate = self

        self.addSubview(sep)
        
        self.anchorWith_Height(height: nil, const: 50)
        
        sep.anchorWith_TopLeftBottomRight_Padd(top: nil, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor,padd: .init(top: 0, left: 0, bottom: -1, right: 0))
        sep.anchorWith_Height(height: nil, const: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomImgBTN:UIButton{
    
    required init(img:UIImage?) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints=false
        self.setImage(img, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.startAnimatingPressActions()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class CustomBTN:UIButton{
    
    required init(title:String,bgColor:UIColor,textColor:UIColor,radii:CGFloat,isLine:Bool?=false) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if title != ""{
            self.setTitle(title, for: .normal)
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.blue.cgColor,UIColor.red.cgColor]
        gradientLayer.locations = [0.0, 2.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.addSublayer(gradientLayer)
        
        self.backgroundColor = bgColor
        self.setTitleColor(textColor, for: .normal)
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        
        self.titleLabel?.font = FONTS.Nunito_Bold(size: 16).Identifier
    
        self.layer.cornerRadius = radii
        self.startAnimatingPressActions()
        
//        if DeviceModel.systemDarkTheme(){
//            if bgColor == COLORS.Black{
//                self.backgroundColor = COLORS.White.Identifier
//            }
//            if bgColor == COLORS.White{
//                self.backgroundColor = COLORS.Black.Identifier
//            }
//        }
//        
//        if DeviceModel.systemDarkTheme(){
//            if textColor == COLORS.Black{
//                self.setTitleColor(COLORS.White.Identifier, for: .normal)
//            }else{
//                self.setTitleColor(COLORS.Black.Identifier, for: .normal)
//            }
//        }
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: title,
                                                            attributes: yourAttributes)
        if isLine == true{
            self.setAttributedTitle(attributeString, for: .normal)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CustomCollectionView:UICollectionView{
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled = true
        self.bounces = false
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CustomIMG:UIImageView{
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        if image != nil{
            self.image = image
        }
        self.translatesAutoresizingMaskIntoConstraints=false
        self.contentMode = .scaleToFill
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
