//
//  ToastView.swift
//  IDService
//
//  Created by scn孙长宁 on 2017/4/12.
//  Copyright © 2017年 scn. All rights reserved.
//

import UIKit

class ToastView: NSObject {

    static func showToast(text : String) -> Void {
        let keyWindow = UIApplication.shared.keyWindow
        
        let contentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        contentLabel.text = text
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 13.0)
        contentLabel.textColor = UIColor.white
        contentLabel.layer.cornerRadius = 5.0
        contentLabel.layer.masksToBounds = true
        contentLabel.textAlignment = .center
        contentLabel.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.7)
        
        let height = self.heightForString(str: text, font: contentLabel.font, textWidth: 300)
        contentLabel.frame = CGRect(x: 0, y: 0, width: 300, height: height+20)
        contentLabel.center = (keyWindow?.center)!
        
        keyWindow?.addSubview(contentLabel)
        
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            contentLabel.removeFromSuperview()
        }
    }
    
    static func heightForString(str : String ,font: UIFont,textWidth : CGFloat) -> CGFloat {
        let normalText: NSString = str as NSString
        let size = CGSize(width: textWidth, height: 1000)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        return stringSize.height
    }
    
}
