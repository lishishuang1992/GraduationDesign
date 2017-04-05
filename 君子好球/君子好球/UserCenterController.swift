//
//  UserCenterController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import SnapKit
class UserCenterController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let cellID = "reuseIdentifier"
    let headView = UserCenterHeadView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.title = "用户中心"
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellID)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 0
        }else{
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) 
        if indexPath.section == 0 {
        
        }else if indexPath.section == 1{
            let message = UILabel()
            if indexPath.row == 0 {
                message.text = "查看收到的赞"
            }else{
                message.text = "查看发布的动态"
            }
            message.frame = CGRect(x :0,y :0,width :100,height :80)
            cell.contentView.addSubview(message)
        }
         return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200
        }else{
            return 40
        }
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            self.headView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
            self.headView.backgroundColor = UIColor.gray
            self.headView.nameBt.titleLabel?.text = "小明"
            self.headView.addTargetNameBt(target: self, action:#selector(nameBtClick), for: .touchUpInside)
            self.headView.addTargetUserAvatar(target: self, action: #selector(userAvatarClick), for: .touchUpInside)
            self.headView.sinceAndReleaseNum(numSince: "1", numRelease: "2")
        }else if section == 1 {
            return nil
        }
        return self.headView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let rootView = UIView()
        if section == 0 {
            
        }else{
            rootView.frame = CGRect(x:0 , y: 0, width: self.view.frame.size.width/2, height: 100)
            let exitLogin = UIButton()
            exitLogin.frame = CGRect(x:self.view.frame.size.width/2-40 ,y:60 ,width: 80,height:80)
            exitLogin.backgroundColor = UIColor.orange
            exitLogin.titleLabel?.text = "退出登录"
            exitLogin.addTarget(self, action:#selector(exitLoginClick), for:.touchUpInside)
            rootView.addSubview(exitLogin)

        }
        return rootView
    }

    
    func userAvatarClick() {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.sourceType = .savedPhotosAlbum
        pickerController.delegate = self
        present(pickerController, animated: true) { 
            
        }
        
    }
    
    func nameBtClick() {
        
    }
    
    
    func exitLoginClick() {
        
    }
    
    
    
    // UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.headView.userAvatar.setImage(image, for: .normal)
        dismiss(animated: true) {
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    
        dismiss(animated: true) { 
        }
    
    }
}
