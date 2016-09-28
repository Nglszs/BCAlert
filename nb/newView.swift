//
//  newView.swift
//  nb
//
//  Created by Jack on 16/8/26.
//  Copyright © 2016年 毕研超. All rights reserved.
//

import UIKit

@objc protocol clickButtonDelegate:NSObjectProtocol
{

    optional func clickSureButton(button:UIButton)


}




class newView: UIView {

    weak var dele:clickButtonDelegate?
     var showImage:UIImageView?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let backView:UIView = UIView(frame: self.frame)
        backView.alpha = 0.3
        backView.backgroundColor = UIColor.blackColor()
        self.addSubview(backView)
       
       
       self.showImage = UIImageView(frame: CGRectMake(0, 100, 100, 100))
        
        
        let test = [UIImage(named:"loading_gold_1")!,UIImage(named:"loading_gold_2")!,UIImage(named:"loading_gold_4")!,UIImage(named:"loading_gold_6")!,UIImage(named:"loading_gold_8")!,UIImage(named:"loading_gold_10")!,UIImage(named:"loading_gold_12")!]
        self.showImage!.animationImages = test
        showImage!.animationDuration = 1;
        showImage!.animationRepeatCount = 100
        showImage!.startAnimating()
        self.addSubview(showImage!)
    
        
        let lable: UILabel = UILabel(frame: CGRectMake(0, 100,200, 100))
        lable.center = self.center;
        lable.text = "当前应用无法访问"
        lable.textAlignment = .Center
        lable.backgroundColor = UIColor.cyanColor()
        self.addSubview(lable)
        
        
        let clickButton:UIButton =  UIButton(type: UIButtonType.Custom)
        clickButton.frame = CGRectMake(0, CGRectGetMaxY(lable.frame), self.frame.size.width, 50)
        clickButton.backgroundColor = UIColor.greenColor();
        clickButton.setTitle("确定", forState: UIControlState.Normal)
        clickButton.setTitle("点击了按钮", forState: .Highlighted)
        clickButton.addTarget(self, action: Selector("buttonClick:"), forControlEvents:.TouchUpInside)
        
        
        
        self.addSubview(clickButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func buttonClick(button:UIButton) {
    
        print("点击了按钮");
        self.showImage?.stopAnimating()
        
        self.dele?.clickSureButton!(button)
       
    }
    
}
