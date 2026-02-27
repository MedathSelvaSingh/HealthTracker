//
//  ViewController.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var logo:UIImageView={
        let l = UIImageView()
        l.image = .healthTracker
        l.contentMode = .scaleAspectFit
        l.translatesAutoresizingMaskIntoConstraints=false
        return l
    }()
    
    lazy var healthIcon:UIImageView={
        let l = UIImageView()
        l.image = .healthIcon
        l.contentMode = .scaleToFill
        l.translatesAutoresizingMaskIntoConstraints=false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: { [self] in
            self.expand()
            UIView.transition(with: view, duration: 1,options: .transitionCrossDissolve, animations: {
                self.logo.image = nil
                self.healthIcon.image = nil
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    let customTabBar = CustomTabBarController()
                    customTabBar.selectedIndex = 0
                    UIApplication.shared.windows.first?.rootViewController = customTabBar
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                })
            })
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .white
    }

    func setupViews(){
        view.addSubview(logo)
        view.addSubview(healthIcon)
        
        setupLayout()
    }
    
    func expand() {

       let expandAnim = CABasicAnimation(keyPath: "transform.scale")
        let expandScale = (UIScreen.main.bounds.size.height/self.healthIcon.frame.size.height)*2
       expandAnim.fromValue            = 1.0
        expandAnim.toValue              = max(expandScale,100.0)
       expandAnim.timingFunction       = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
       expandAnim.duration             = 0.4
        expandAnim.fillMode             = .forwards
       expandAnim.isRemovedOnCompletion  = true

        healthIcon.layer.add(expandAnim, forKey: expandAnim.keyPath)
       
       CATransaction.commit()
   }
    
     func shakeAnimation() {
        let keyFrame = CAKeyframeAnimation(keyPath: "position")
        let point = self.healthIcon.layer.position
        
        keyFrame.values = [
            NSValue(cgPoint: point),
            NSValue(cgPoint: CGPoint(x: point.x - 10, y: point.y)),
            NSValue(cgPoint: CGPoint(x: point.x + 10, y: point.y)),
            NSValue(cgPoint: CGPoint(x: point.x - 10, y: point.y)),
            NSValue(cgPoint: CGPoint(x: point.x + 10, y: point.y)),
            NSValue(cgPoint: CGPoint(x: point.x - 10, y: point.y)),
            NSValue(cgPoint: CGPoint(x: point.x + 10, y: point.y)),
            NSValue(cgPoint: point)
        ]
        
        keyFrame.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        keyFrame.duration = 0.7
        
        self.healthIcon.layer.add(keyFrame, forKey: "shake")
    }
    
}

extension ViewController{
    func setupLayout(){
        logo.anchorWith_XY_TopLeftBottomRight_Padd(x: view.centerXAnchor, y: view.centerYAnchor, top: nil, left: nil, bottom: nil, right: nil, padd: .init(top: 0, left: 5, bottom: 0, right: -5))
        logo.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 200, constHeight: 50)
        
        healthIcon.anchorWith_XY_TopLeftBottomRight_Padd(x: logo.centerXAnchor, y: nil, top: nil, left: nil, bottom: logo.topAnchor, right: nil, padd: .init(top: 0, left: 0, bottom: -5, right: 0))
        healthIcon.anchorWith_WidthHeight(width: nil, height: nil, constWidth: 50, constHeight: 50)
    }
}

