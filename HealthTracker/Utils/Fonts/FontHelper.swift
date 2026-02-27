//
//  FontHelper.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import Foundation
import UIKit

enum FONTS {
    case Nunito_Light(size:CGFloat)
    case Nunito_Bold(size:CGFloat)
    case Nunito_Regular(size:CGFloat)
    case Nunito_SemiBold(size:CGFloat)
    case Nunito_ExtraBold(size:CGFloat)
    
    
    var Identifier : UIFont!{
    switch self {
        
    case.Nunito_Bold(size: let size):
        return UIFont(name: "NunitoSans-Bold", size: size)
    case.Nunito_Light(size: let size):
        return UIFont(name: "NunitoSans-Light", size: size)
    case.Nunito_Regular(size: let size):
        return UIFont(name: "NunitoSans-Regular", size: size)
    case.Nunito_SemiBold(size: let size):
        return UIFont(name: "NunitoSans-SemiBold", size: size)
    case.Nunito_ExtraBold(size: let size):
        return UIFont(name: "NunitoSans-ExtraBold", size: size)

        }
    }
}
