//
//  Extensions.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import Foundation
import UIKit
import Toast_Swift

extension UIView{
    
    func anchorWith_XY_Padd(x:NSLayoutXAxisAnchor?,y:NSLayoutYAxisAnchor?,padd:UIEdgeInsets = .zero){
        
        if x != nil{
            centerXAnchor.constraint(equalTo: x!, constant: padd.left).isActive=true
        }
        if y != nil{
            centerYAnchor.constraint(equalTo: y!, constant: padd.top).isActive=true
        }
    }
    
    func anchorWith_XY_TopLeftBottomRight_Padd(x:NSLayoutXAxisAnchor?,y:NSLayoutYAxisAnchor?,top:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,right:NSLayoutXAxisAnchor?,padd:UIEdgeInsets = .zero){
        
        if x != nil{
            centerXAnchor.constraint(equalTo: x!, constant: padd.left).isActive=true
        }
        if y != nil{
            centerYAnchor.constraint(equalTo: y!, constant: padd.top).isActive=true
        }
        
        if top != nil{
            topAnchor.constraint(equalTo: top!, constant: padd.top).isActive=true
        }
        if left != nil{
            leadingAnchor.constraint(equalTo: left!, constant: padd.left).isActive=true
        }
        if bottom != nil{
            bottomAnchor.constraint(equalTo: bottom!, constant: padd.bottom).isActive=true
        }
        if right != nil{
            trailingAnchor.constraint(equalTo: right!, constant: padd.right).isActive=true
        }
    }
    
    func anchorWith_TopLeftBottomRight_Padd(top:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,right:NSLayoutXAxisAnchor?,padd:UIEdgeInsets = .zero){
        
        if top != nil{
            topAnchor.constraint(equalTo: top!, constant: padd.top).isActive=true
        }
        if left != nil{
            leadingAnchor.constraint(equalTo: left!, constant: padd.left).isActive=true
        }
        if bottom != nil{
            bottomAnchor.constraint(equalTo: bottom!, constant: padd.bottom).isActive=true
        }
        if right != nil{
            trailingAnchor.constraint(equalTo: right!, constant: padd.right).isActive=true
        }
        
    }
    
    func anchorWith_WidthHeight(width:NSLayoutDimension?,height:NSLayoutDimension?,constWidth:CGFloat?,constHeight:CGFloat?){
        
        if width != nil && constWidth != nil{
            widthAnchor.constraint(equalTo: width!, multiplier: constWidth!).isActive=true
        }
        else if constWidth != nil{
            widthAnchor.constraint(equalToConstant: constWidth!).isActive=true
        }
        
        if height != nil && constHeight != nil{
            heightAnchor.constraint(equalTo: height!, multiplier: constHeight!).isActive=true
        }
        else if constHeight != nil{
            heightAnchor.constraint(equalToConstant: constHeight!).isActive=true
        }
        
    }
    
    func anchorWith_Width(width:NSLayoutDimension?,const:CGFloat){
        if width != nil{
            widthAnchor.constraint(equalTo: width!, multiplier: const).isActive=true
        }
        else{
            widthAnchor.constraint(equalToConstant: const).isActive=true
        }
    }
    
    func anchorWith_Height(height:NSLayoutDimension?,const:CGFloat){
        if height != nil{
            heightAnchor.constraint(equalTo: height!, multiplier: const).isActive=true
        }
        else{
            heightAnchor.constraint(equalToConstant: const).isActive=true
        }
    }
}


extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
    }
    
}

extension UITextField{
    
    func addDoneButtonOnKeyboard() {
       
       let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
       doneToolbar.barStyle = .default

       let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

       let items = [flexSpace, done]
       doneToolbar.items = items
       doneToolbar.sizeToFit()

       self.inputAccessoryView = doneToolbar
   }
    
    @objc fileprivate func doneButtonAction() {
        self.resignFirstResponder()
    }
    
    func setPlaceholder(str:String,color:UIColor){
        self.attributedPlaceholder = NSAttributedString(string: str,attributes: [NSAttributedString.Key.foregroundColor: color]) 
    }
    
}

extension UILabel{
    
    func setCustomLBL(str:String,color:UIColor,align:NSTextAlignment,size:CGFloat){
        
        self.translatesAutoresizingMaskIntoConstraints=false
        self.text = str
        self.textAlignment = align
        self.textColor = color
        self.numberOfLines = 0
    }
}

extension UIColor{
    public static func hexToColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIViewController{
    //MARK:- Alert/Toast
    func makeToast(strMessage:String,position:ToastPosition = .bottom){
        if let tabBarController = self.tabBarController as? CustomTabBarController {
            tabBarController.setCustomTabBarHidden(true)
        }
        var style=ToastStyle()
        style.messageAlignment = .center
        self.view.makeToast(strMessage, duration: 3.0, position:position,style:style,completion: {didTap in 
            if let tabBarController = self.tabBarController as? CustomTabBarController {
                tabBarController.setCustomTabBarHidden(false)
            }
        })
    }
}


public func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy • h:mm a"
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.current
    return formatter.string(from: date)
}

public func formatDateToday(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, dd MMM"
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.current
    return formatter.string(from: date)
}
