//
//  ViewController1.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit


class BallFormatVc: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate{
    var myblock : blockBtnClickSendValue?
    let pickerview = UIPickerView()
    var numLeft:Int = 1
    var numRight:Int = 1
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
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        let label = UILabel()
        label.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = "V"
        self.pickerview.addSubview(label)
        label.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self.pickerview)
            make.centerX.equalTo(self.pickerview)
            make.width.equalTo(50)
            make.height.equalTo(60)
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
        self.pickerview.dataSource = self
        self.pickerview.delegate = self
    }
    
    
    // MARK: - UIPickerViewDataSource, UIPickerViewDelegate
    // MARK: UIPickerViewDataSource
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 选择框列数
        return 2

    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 11
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        // 每个选择框的行高
        return 50.0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let province:String! = String(format:"%d",row + 1)
        return province
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print(component, row+1)
        if component == 0 {
            self.numLeft = row + 1
        }else{
            self.numRight = row + 1
        }
    }
    
    func deterMineButtonClick() {
        if myblock != nil
        {
            myblock!(String(format:"%d  V  %d",self.numLeft ,self.numRight))
        }
        self.navigationController?.popViewController(animated: true)

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
