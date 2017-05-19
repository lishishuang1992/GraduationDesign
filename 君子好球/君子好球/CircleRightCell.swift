//
//  CircleRightCell.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import Kingfisher
protocol CircleRightCellDelegate:NSObjectProtocol {
    func praiseBtClick(sender:UIButton)
    func headImageBtClick(sender:UIButton)
    func shareBtClick(sender:UIButton)
}
class CircleRightCell: UITableViewCell {
    weak var delegate:CircleRightCellDelegate?
    var index:Int = 0
    var headImageBt = UIButton()
    var nickname = UILabel()
    var time = UILabel()
    var contentText = UILabel()
    var zanText = UILabel()
    var backImageView = UIImageView()
    var pointPraise = UILabel()
    var praiseBt = UIButton ()
    var shareBt = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI() {
        //头像
        self.headImageBt = UIButton()
        self.headImageBt.layer.cornerRadius = 8
        self.headImageBt.addTarget(self, action:#selector(headImageBtClick(sender:)), for: .touchUpInside)
        self.addSubview(self.headImageBt)
        self.headImageBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(65/2.0)
            make.width.equalTo(65/2.0)
        }
        //昵称
        self.nickname = UILabel()
        self.nickname.backgroundColor = UIColor.clear
        self.nickname.textColor = UIColor.red
        self.nickname.font = UIFont.systemFont(ofSize: 13)
        self.nickname.textAlignment = .left
        self.addSubview(self.nickname)
        self.nickname.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self.headImageBt)
            make.left.equalTo(headImageBt.snp.right).offset(10)
            make.width.equalTo(90/2.0)
        }
        //时间
        self.time = UILabel()
        self.time.backgroundColor = UIColor.clear
        self.time.textColor = UIColor.red
        self.time.font = UIFont.systemFont(ofSize: 12)
        self.time.textAlignment = .right
        self.addSubview(self.time)
        self.time.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self.headImageBt.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.equalTo(200)
        }
        self.contentText = UILabel()
        self.contentText.font = UIFont.systemFont(ofSize: 14)
        self.contentText.numberOfLines = 0
        self.addSubview(self.contentText)
        self.contentText.snp.makeConstraints { (make) in
            make.top.equalTo(self.headImageBt.snp.bottom).offset(10)
            make.left.equalTo(self.nickname)
            make.right.equalTo(self).offset(-20)
        }
        //背景图
        self.backImageView = UIImageView()
        self.addSubview(self.backImageView)
        self.backImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(self.contentText.snp.bottom).offset(10)
            make.left.equalTo(self.contentText)
            make.right.equalTo(self.contentText)
            make.height.equalTo(0)
        }
        //点赞按钮
        self.praiseBt = UIButton()
        self.praiseBt.setImage(UIImage(named:"heart_gray"), for: .normal)
        self.praiseBt.addTarget(self, action:#selector(praiseBtClick(sender:)), for: .touchUpInside)
        self.addSubview(self.praiseBt)
        self.praiseBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.contentText)
            make.top.equalTo(self.backImageView.snp.bottom).offset(5)
            make.height.equalTo(40/2.0)
            make.width.equalTo(40/2.0)
        }
        //点赞数
        self.pointPraise = UILabel()
        self.pointPraise.backgroundColor = UIColor.clear
        self.pointPraise.textColor = UIColor.red
        self.pointPraise.font = UIFont.systemFont(ofSize: 10)
        self.pointPraise.textAlignment = .center
        self.addSubview(self.pointPraise)
        self.pointPraise.snp.makeConstraints{ (make) in
            make.left.equalTo(self.praiseBt.snp.right).offset(10)
            make.centerY.equalTo(self.praiseBt)
            make.width.equalTo(30/2.0)
        }
        
        //分享按钮
        self.shareBt = UIButton()
        self.shareBt.setImage(UIImage(named:"share"), for: .normal)
        self.shareBt.addTarget(self, action:#selector(shareBtClick(sender:)), for: .touchUpInside)
        addSubview(self.shareBt)
        self.shareBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.pointPraise.snp.right).offset(15)
             make.centerY.equalTo(self.praiseBt)
            make.height.equalTo(40/2.0)
            make.width.equalTo(40/2.0)
        }
        self.zanText = UILabel()
        self.zanText.text = ""
        self.zanText.font = UIFont.systemFont(ofSize: 14)
        self.zanText.numberOfLines = 0
        self.addSubview(self.zanText)
        self.zanText.snp.makeConstraints { (make) in
            make.top.equalTo(self.shareBt.snp.bottom).offset(5)
            make.left.equalTo(self.nickname)
            make.right.equalTo(self).offset(-20)
        }
    }
    
    func praiseBtClick(sender:UIButton) {
        sender.tag = self.index
        self.delegate?.praiseBtClick(sender: sender)
    }
    func headImageBtClick(sender:UIButton) {
        sender.tag = self.index
        self.delegate?.headImageBtClick(sender: sender)
    }
    func shareBtClick(sender:UIButton) {
        sender.tag = self.index
        self.delegate?.shareBtClick(sender: sender)
    }

    func postData(hotCellModel :CircleHotCellModel ) {
        self.headImageBt.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: hotCellModel.user_image)! as URL), for: .normal)
        self.nickname.text = hotCellModel.user_name
        self.time.text = hotCellModel.current_time
        self.contentText.text = hotCellModel.contentText
        for zanUser in hotCellModel.zanUser{
            self.zanText.text = String(format:"%@,%@",self.zanText.text!,zanUser["user_name"] as! String)
        }
        self.backImageView.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string: (hotCellModel.imageUrlArray[0]))! as URL), placeholder: nil, options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler:{ (image, error, cacheType, imageURL) -> () in
            DispatchQueue.main.async(execute: {
                self.backImageView.snp.updateConstraints { (make) in
                   make.height.equalTo(((self.frame.size.width)-10-180/2.0)/(image?.size.width)!*(image?.size.height)!)
                }
            })
        })
        self.pointPraise.text = hotCellModel.pointPraise
    }
    
    //计算文字的高度
    func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width:width,height:900)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.height
    }

}
