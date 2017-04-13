//
//  ViewController.swift
//  IDService
//
//  Created by scn孙长宁 on 2017/4/12.
//  Copyright © 2017年 scn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var idNumTextField:UITextField?  //输入证件类型 textfield
    
    @IBOutlet var idNumLabel:UILabel?  //号码label
    @IBOutlet var idBirthdayLabel:UILabel?  //生日label
    @IBOutlet var idAddressLabel:UILabel?  //地区(发证地)label
    @IBOutlet var idSexLabel:UILabel?  //性别label

    override func viewDidLoad() {
        super.viewDidLoad()
        idNumTextField?.layer.borderWidth = 1
        idNumTextField?.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickVerify() -> Void
    {
        //1 判空 判位数 判前17位是数字 最后一位是数字 或者 X
        
        if (idNumTextField?.text?.isEmpty)!  {
            ToastView.showToast(text: "请输入身份证号码！")
            return
        }
        if (idNumTextField?.text?.characters.count)! != 18  {
            ToastView.showToast(text: "请输入18位身份证号码！")
            return
        }
        if !self.isIDNumber(num: (idNumTextField?.text)!)  {
            ToastView.showToast(text: "请输入正确格式的18位身份证号码！前17位为数字，最后一位为数字或者x,x小写")
            return
        }
        //2 判定是否符合规则 
        if !IDServiceUtil.verifyIDNum(idNum: (idNumTextField?.text)!) {
            ToastView.showToast(text: "身份证号码格式不正确")
            return
        }
        
        //3 根据地区码判定所属地区 生成页面展示
        let area = IDServiceUtil.matchArea(str: (idNumTextField?.text?.substring(to: (idNumTextField?.text?.index((idNumTextField?.text?.startIndex)!, offsetBy: 6))!))!)
        if area == "" {
            ToastView.showToast(text: "抱歉！没有匹配到身份证所属地区")
        }
        else
        {
            //开始解析
            idNumLabel?.text = idNumTextField?.text
            let startIndex = idNumTextField?.text?.index((idNumTextField?.text?.startIndex)!, offsetBy: 6)
            let endIndex = idNumTextField?.text?.index((idNumTextField?.text?.startIndex)!, offsetBy: 13)
            idBirthdayLabel?.text = idNumTextField?.text?[startIndex!...endIndex!]
            idAddressLabel?.text = area
            
            let sex = Int(String((idNumTextField?.text?[(idNumTextField?.text?.index((idNumTextField?.text?.startIndex)!, offsetBy: 16))!])!))
            idSexLabel?.text = sex!%2 == 0 ? "女" : "男"
        }
    }
    
    //判断是否符合特定的格式  前17位为数字，最后一位是数字或者X
    func isIDNumber(num:String)->Bool
    {
        let idNum = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|x)$"
        let regextestIDNum = NSPredicate(format: "SELF MATCHES %@",idNum)
        if (regextestIDNum.evaluate(with: num))
        {
            return true
        }
        else
        {
            return false
        }  
    }

}

