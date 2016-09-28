//
//  BCAlert.swift
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



class BCAlert: UIView {

    
   

    
    //重写init方法和oc一样
    override init(frame: CGRect) {
        super.init(frame: frame)
     
       
        
        
      //背景
        let backView:UIView = UIView(frame: self.frame)
        backView.backgroundColor = UIColor.blackColor()
        backView.alpha = 0.3
        self.addSubview(backView)
        
        
        let mainView:UIView = UIView(frame: CGRectMake((CGRectGetWidth(self.frame) - RealValue(270))/2, (CGRectGetHeight(self.frame) - RealValue(132))/2, RealValue(270), RealValue(132)))
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        self.addSubview(mainView)
        
        
        
        
        
        
        
    }
   
    
    
    func print(){
    
    
    
    }
      
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
