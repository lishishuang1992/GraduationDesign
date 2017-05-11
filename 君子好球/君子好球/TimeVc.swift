//
//  ViewController1.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit


class TimeVc: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate{
    var myblock : blockBtnClickSendValue?
    let pickerview = UIPickerView()
    var year:String = "2017"
    var month:String = "01"
    var day:String = "01"
    var time:String = "1"
    var branch:String = "00"
    var yearArray:Array<String> = []
    var monthArray:Array<String> = []
    var dayArray:Array<String> = []
    var timeArray:Array<String> = []
    var branchArray:Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initView()
        self.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView()  {
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 240/255.0, green: 240.0/255.0, blue: 240/255.0, alpha: 1.0)
        self.view.addSubview(self.pickerview)
        self.pickerview.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(200)
        }
        let deterMine = UIButton()
        deterMine.setTitle("确定", for: .normal)
        deterMine.setTitleColor(UIColor.red, for: .normal)
        deterMine.layer.cornerRadius = 8.0
        deterMine.backgroundColor = UIColor.init(red: 192/255.0, green: 255/255.0, blue: 62/255.0, alpha: 1.0)
        deterMine.addTarget(self, action: #selector(deterMineButtonClick), for: .touchUpInside)
        self.view.addSubview(deterMine)
        deterMine.snp.makeConstraints{ (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.bottom.equalTo(self.view).offset(-120)
        }
        
    }
    func initData() {
        for i in 2017...2050{
            self.yearArray.append(String(format:"%d",i))
        }
        for i in 1...12{
            self.monthArray.append(String(format:"%d",i))
        }
        for i in 1...30{
            self.dayArray.append(String(format:"%d",i))
        }
        for i in 1...24{
            self.timeArray.append(String(format:"%d",i))
        }
        for i in 0...60{
            self.branchArray.append(String(format:"%d",i))
        }

        //print(self.yearArray,self.month,self.dayArray,self.timeArray,self.branchArray)
        self.pickerview.dataSource = self
        self.pickerview.delegate = self
    }
    
    
    // MARK: - UIPickerViewDataSource, UIPickerViewDelegate
    // MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 选择框列数
        return 5
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == 0 {
            return self.yearArray.count
        }else if component == 1 {
            return self.monthArray.count
        }
        else if component == 2 {
            return self.dayArray.count
        }
        else if component == 3 {
            return self.timeArray.count
        }
        else{
            return self.branchArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        // 每个选择框的行高
        return 50.0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if component == 0 {
            return self.yearArray[row]
        }else if component == 1 {
            return self.monthArray[row]
        }
        else if component == 2 {
            return self.dayArray[row]
        }
        else if component == 3 {
            return self.timeArray[row]
        }
        else{
            return self.branchArray[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if component == 0 {
            self.year = self.yearArray[row]
        }else if component == 1 {
            self.month = self.monthArray[row]
        }
        else if component == 2 {
            self.day = self.dayArray[row]
        }
        else if component == 3 {
            self.time = self.timeArray[row]
        }
        else{
            self.branch = self.branchArray[row]
        }

    }
    
    func deterMineButtonClick() {
        if myblock != nil
        {
            myblock!(String(format:"%@-%@-%@ %@:%@",self.year,self.month,self.day,self.time,self.branch))
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lable=UILabel()
        lable.sizeToFit()
        lable.font = UIFont.systemFont(ofSize: 18)
        if(component==0){
            lable.text = self.yearArray[row]
            return lable
        }else if component == 1 {
            //lable.font = UIFont.systemFont(ofSize: 13)
            lable.text = self.monthArray[row]
            return lable
        }
        else if component == 2 {
            //lable.font = UIFont.systemFont(ofSize: 13)
            lable.text = self.dayArray[row]
            return lable
        }
        else if component == 3 {
            //lable.font = UIFont.systemFont(ofSize: 13)
            lable.text = self.timeArray[row]
            return lable
        }
        else{
            lable.text = self.branchArray[row]
            return lable
        }
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
