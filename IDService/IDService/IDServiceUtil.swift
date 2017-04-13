//
//  IDServiceUtil.swift
//  IDService
//
//  Created by scn孙长宁 on 2017/4/12.
//  Copyright © 2017年 scn. All rights reserved.
//

import UIKit

class IDServiceUtil: NSObject {
    
    //校验身份证
    static func verifyIDNum(idNum : String) -> Bool {
        //1 前17位加权求和
        let arr = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]
        var sum : Int = 0;
        
        for index in 0...16
        {
            let i:Int = arr[index]
            let num = Int(String(idNum[idNum.index(idNum.startIndex, offsetBy: index)]))
            sum += (i * num!)
        }
        //2 求模
        let mod = sum % 11
        //3 生成校验码
        let dic:[Int:String] = [0:"1",1:"0",2:"x",3:"9",4:"8",5:"7",6:"6",7:"5",8:"4",9:"3",10:"2"]
        let verifyCode = dic[mod]!

        if verifyCode==String(idNum[idNum.index(before: idNum.characters.endIndex)])  {
            return true
        }
        return false
    }
    //查询发证地
    static func matchArea(str : String) -> String {
        let path = Bundle.main.path(forResource: "IDArea", ofType: nil)
    
        do{
            
            let data = try NSData(contentsOfFile: path!, options: .mappedIfSafe)
            let dic = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as! NSDictionary
            let area = dic.object(forKey: str)
            if area != nil {
                return area as! String
            }
            else
            {
                return ""
            }
        }
        catch
            {
                print("数据源有误，请检查")
        }
        return ""
    }
}
