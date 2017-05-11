//
//  AboutBallViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/2/22.
//  Copyright © 2017年 shuang. All rights reserved.
//

import UIKit

class ReleaseBallController: UIViewController {

    var backBt: UIButton?          //退出按钮
    var circleBt: UIButton?             //发布朋友圈
    var aboutBallBt: UIButton?                  //发布约球信息
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.pushAnimation()
    }
    
    func initView() {
        self.view.backgroundColor = UIColor.init(red: 224/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        self.backBt = UIButton()
        self.backBt?.setImage(UIImage(named:"wrong"), for: .normal)
        self.backBt?.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
        self.backBt?.tag = 0
        self.view.addSubview(self.backBt!)
        self.backBt?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-15)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        self.aboutBallBt = UIButton()
        self.aboutBallBt?.tag = 1
        self.aboutBallBt?.setImage(UIImage(named:"aboutBall"), for: .normal)
        self.aboutBallBt?.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
        self.aboutBallBt?.frame = CGRect.init(x:-90 , y:0, width: 90, height: 90)
        self.view.addSubview(self.aboutBallBt!)

        self.circleBt = UIButton()
        self.circleBt?.tag = 2
        self.circleBt?.setImage(UIImage(named:"circleMe"), for: .normal)
        self.circleBt?.addTarget(self, action:#selector(buttonAction(sender:)), for: .touchUpInside)
        self.circleBt?.frame = CGRect.init(x:self.view.frame.size.width + 90, y: 0, width: 90, height: 90)
        self.view.addSubview(self.circleBt!)
       
    }
    
    func buttonAction(sender: UIButton?){
        if sender?.tag == 0 {
            self.popAnimation()
        }else if sender?.tag == 1{
            let ballVc = UINavigationController(rootViewController: AboutBallVC())
            self.present(ballVc, animated: true, completion: nil)
        }else{
            let ballMessageVc =  UINavigationController(rootViewController: BallMessageVc())
            self.present(ballMessageVc, animated: true, completion: nil)
        }
        
    }
    func pushAnimation() {
       UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations:  {
                self.aboutBallBt?.frame = CGRect.init(x: self.view.frame.size.width/2-90-45, y: self.view.frame.size.height/2-45, width: 90, height: 90)
           
        }) { (completion) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.circleBt?.frame = CGRect.init(x: self.view.frame.size.width/2+45, y: self.view.frame.size.height/2-45, width: 90, height: 90)
            }, completion: nil)
        }
    }
    func popAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations:  {
            self.aboutBallBt?.frame = CGRect.init(x:-90 , y:0, width: 90, height: 90)
        }) { (completion) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.circleBt?.frame = CGRect.init(x:self.view.frame.size.width + 90, y: 0, width: 90, height: 90)
            }) {(completion) in
                
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
}
