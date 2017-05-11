//
//  BallMessageVc.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/11.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class BallMessageVc: UIViewController ,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var myblock : blockBtnClickSendValue?
    let textview = UITextView()
    var backBt: UIButton?
    var selectImage: UIButton?
    var photoGraph: UIButton?
    var postImage:UIImage?
    private var netWorkApi = NetWorkApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView()  {
        
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 240/255.0, green: 255.0/255.0, blue: 240/255.0, alpha: 1.0)
        let navView = UIView()
        navView.backgroundColor = UIColor.init(colorLiteralRed: 240/255.0, green: 255.0/255.0, blue: 240/255.0, alpha: 1.0)
        self.view.addSubview(navView)
        navView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(64)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginController.tapView))
        self.view.addGestureRecognizer(tap)
        self.textview.layer.borderWidth = 1  //边框粗细
        self.textview.font = UIFont.systemFont(ofSize: 18)
        self.textview.returnKeyType = .done
        //self.textview.textColor = UIColor.blue
        self.automaticallyAdjustsScrollViewInsets = false
        self.textview.textContainerInset=UIEdgeInsets(top: 0,left: 0,bottom: 1,right: 0)
        self.textview.layer.borderColor = UIColor.gray.cgColor //边框颜色
        self.view.addSubview(self.textview)
        self.textview.snp.makeConstraints{ (make) in
            make.top.equalTo(self.view).offset(64+10)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view.snp.centerY).offset(-120)
        }
        let deterMine = UIButton()
        deterMine.setTitle("发布", for: .normal)
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
        self.backBt = UIButton()
        self.backBt?.setTitle("取消", for: .normal)
        self.backBt?.titleLabel?.textColor = UIColor.red
        self.backBt?.addTarget(self, action: #selector(backBtClick), for: .touchUpInside)
        navView.addSubview(self.backBt!)
        self.backBt?.snp.makeConstraints{ (make) in
            make.left.equalTo(navView).offset(15)
            make.centerY.equalTo(navView)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        self.selectImage = UIButton()
        self.selectImage?.layer.cornerRadius = 8.0
        self.selectImage?.setImage(UIImage(named:"selectImage"), for: .normal)
        self.selectImage?.addTarget(self, action: #selector(selectImageClick), for: .touchUpInside)
        self.view.addSubview(self.selectImage!)
        self.selectImage?.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view).offset(10)
            make.bottom.equalTo(self.view.snp.centerY).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        self.photoGraph = UIButton()
        self.photoGraph?.setImage(UIImage(named:"photoGraph"), for: .normal)
        self.photoGraph?.addTarget(self, action: #selector(photoGraphClick), for: .touchUpInside)
        self.view.addSubview(self.photoGraph!)
        self.photoGraph?.snp.makeConstraints{ (make) in
            make.left.equalTo((self.selectImage?.snp.right)!).offset(10)
            make.top.equalTo(self.selectImage!)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    
        
    }
    func initData() {
        
    }
    func deterMineButtonClick() {
        if (self.postImage != nil)&&(self.textview.text.characters.count > 0){
            self.netWorkApi.resertBallMessage(message: self.textview.text, user_id: "4deTDaA8", image: self.postImage!,  block: {(json: Dictionary)-> Void in
                print(json)
                let status = json["status"] as! String
                if status == "1006"{
                    print("插入成功")
                }
                else if status == "1005"{
                    //无数据
                    print("插入失败")
                }else{
                    
                }
            })

        }else if (self.postImage == nil){
            print("照片为空")
        }else{
           print("文字为空")
        }
        
    }
    
    func tapView() {
        self.textview.resignFirstResponder()
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        let range = NSRange(location: 0, length: 0)
        textView.selectedRange = range
    }

    func backBtClick() {
        self.dismiss(animated: true, completion: nil)
    }
    func selectImageClick(){
        openAlbum()
    }
    func photoGraphClick(){
        openCamera()
    }
    //打开相册
    func openAlbum(){
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            //            picker.allowsEditing = editSwitch.on
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            //创建图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self 
            //设置来源
            picker.sourceType = UIImagePickerControllerSourceType.camera
            //允许编辑
            picker.allowsEditing = true
            //打开相机
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
        }else{
            debugPrint("找不到相机")
        }
    }
    
    //选择图片成功后代理
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.postImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        //DispatchQueue.main.async(execute: {
            self.selectImage?.setImage(self.postImage, for: .normal)
      //  })
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    
}
