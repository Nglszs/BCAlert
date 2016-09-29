//
//  CustomAlert.swift
//  nb
//
//  Created by Jack on 16/9/28.
//  Copyright © 2016年 毕研超. All rights reserved.
//

import UIKit

//适配

let kScreenWidth = UIScreen.mainScreen().bounds.width
let Multiplier:CGFloat = kScreenWidth / 375
func RealValue(v:CGFloat)->CGFloat {
    
    
    return v * Multiplier
}



@objc protocol ClickAlertDelegate:NSObjectProtocol
{
    
    optional func clickAlertButton(button:UIButton)
    
    
}


public class CustomAlert: UIView {
    
    var alertWindow = UIWindow()
    let mainView = UIView() //承载内容View
    let tipLabel = UILabel()
    let contentLabel = UILabel()
    let cancelButton = UIButton.init(type: UIButtonType.Custom)
    let sureButton   = UIButton.init(type: UIButtonType.Custom)
    
    
   weak  var delegate:ClickAlertDelegate!
    
  
    
    //重写init方法和oc一样
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
      
        
        //背景
        let backView:UIView = UIView(frame: self.frame)
        backView.backgroundColor = UIColor.blackColor()
        backView.alpha = 0.35
        self.addSubview(backView)
        
        
        mainView.frame = CGRectMake((CGRectGetWidth(self.frame) - 270)/2, (CGRectGetHeight(self.frame) - 132)/2, 270, 132)
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        self.addSubview(mainView)
        
        
        tipLabel.frame = CGRectMake(0, 16, mainView.frame.size.width, 16)
        tipLabel.font = UIFont.systemFontOfSize(16)
        tipLabel.textAlignment = .Center
        mainView.addSubview(tipLabel)
        
        
        
        contentLabel.frame = CGRectMake(18, CGRectGetMaxY(tipLabel.frame) + 7, 270 - 36, 50)
        contentLabel.font = UIFont.systemFontOfSize(14)
        contentLabel.textAlignment = .Center
        contentLabel.numberOfLines = 0
        mainView.addSubview(contentLabel)
        
       
        
        cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 7, 270/2 - 1, 44)
        cancelButton.tag = 0
       
        cancelButton.setTitleColor(Color(r: 173, g: 142, b: 101, a: 1), forState: UIControlState.Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        cancelButton.addTarget(self, action: Selector("buttonClick:"), forControlEvents:.TouchUpInside)
        mainView.addSubview(cancelButton)

      
        
        sureButton.frame = CGRectMake(270/2, CGRectGetMaxY(contentLabel.frame) + 7,270/2, 44)
        sureButton.tag = 1
        sureButton.setTitleColor(Color(r: 173, g: 142, b: 101, a: 1), forState: UIControlState.Normal)
        sureButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        sureButton.addTarget(self, action: Selector("buttonClick:"), forControlEvents:.TouchUpInside)
        mainView.addSubview(sureButton)
        
        
     
        
    }
    
   

    //赋值方法
    public func setAlert(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?,delegate:AnyObject?){
    
     let isShow = NSUserDefaults.standardUserDefaults().boolForKey("SwiftIsShowAlert")
       
        if isShow {
          
            return
        }
        
        
        self.delegate = delegate as? ClickAlertDelegate
        self.tipLabel.text = title
        self.contentLabel.text = message
        self.cancelButton.setTitle(cancelButtonTitle, forState: .Normal)
        self.sureButton.setTitle(sureButtonTitle, forState: .Normal)
    
      
        let attributes = [NSFontAttributeName: contentLabel.font]
        let size = contentLabel.text!.boundingRectWithSize(CGSizeMake(270 - 36, 0), options: NSStringDrawingOptions.UsesLineFragmentOrigin , attributes:attributes, context: nil) //获取文本宽高
        
        
        contentLabel.frame = CGRectMake(16, CGRectGetMaxY(tipLabel.frame) + 7, 270 - 32, size.height);
        
        
       //分割线
        let lineImage:UIImageView = UIImageView(frame: CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, 270, 0.5))
        lineImage.backgroundColor = Color(r: 228, g: 228, b: 228, a: 1)
        
        mainView.addSubview(lineImage)
        
       
        let lineImage1:UIImageView = UIImageView(frame: CGRectMake(270/2 - 1, CGRectGetMaxY(contentLabel.frame) + 16 , 0.5, 44))
        lineImage1.backgroundColor = Color(r: 228, g: 228, b: 228, a: 1)
        mainView.addSubview(lineImage1)
        
        
        
        
        cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame)  + 16, 270/2 - 1, 44);
        sureButton.frame = CGRectMake(270/2, CGRectGetMaxY(contentLabel.frame)  + 16,270/2, 44);

    
        
        if (title == nil) {
            tipLabel.hidden = true;
            contentLabel.frame = CGRectMake(16, 16, mainView.frame.size.width - 32, size.height);
            
            lineImage.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, 270, 0.5);
            lineImage1.frame = CGRectMake(270/2 - 1, CGRectGetMaxY(contentLabel.frame) + 16, 0.5, 44);
            
            if (sureButtonTitle == nil) {
                lineImage1.hidden = true;
                sureButton.hidden = true;
                cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width, 44);
                
            }else{
                
                cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width/2 - 1, 44);
                sureButton.frame = CGRectMake(mainView.frame.size.width/2, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width/2, 44);
                
            }
            
        }
        
        if (sureButtonTitle == nil) {
            sureButton.hidden = true;
            lineImage1.hidden = true;
            cancelButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width, 44);
        }
        
        if (cancelButtonTitle == nil) {
            cancelButton.hidden = true;
            lineImage1.hidden = true;
            sureButton.frame = CGRectMake(0, CGRectGetMaxY(contentLabel.frame) + 16, mainView.frame.size.width, 44);
        }
        

        
        let height:CGFloat =  CGRectGetMaxY(contentLabel.frame) + 44 + 16
        
         mainView.frame = CGRectMake((CGRectGetWidth(self.frame) - 270)/2, (CGRectGetHeight(self.frame) - height)/2, 270, height);
        
        
        
        //这里可以按照自己需求加上动画，这里不再写
        self.alertWindow.frame = self.frame
        self.alertWindow.backgroundColor = UIColor.clearColor()
        self.alertWindow.windowLevel = UIWindowLevelAlert + 1;
        
        self.alertWindow.addSubview(self);
        self.alertWindow.makeKeyAndVisible()
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "SwiftIsShowAlert")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    
    func buttonClick(sender: UIButton) {
        
      
        if self.delegate != nil && self.delegate.respondsToSelector("clickAlertButton:"){
            self.delegate.clickAlertButton!(sender)
        }
        
        
       self.shutAlert()
        
        
    }
   

    func shutAlert() {
    
    
        
        self.removeFromSuperview()
        self.alertWindow.resignKeyWindow()
     
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "SwiftIsShowAlert")
        NSUserDefaults.standardUserDefaults().synchronize()
    
    }
    
   
    func Color(r r: CGFloat, g:CGFloat, b:CGFloat, a: CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    
    //获取字符串高度
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    


}
