//
//  JHCircularImageVc_swift.swift
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

import UIKit

@objc class JHCircularImageVc_swift: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建ImageView
        let paintImageView = CircularImageView(frame: self.view.bounds)
        paintImageView.contentMode = .ScaleAspectFill
        
        
        // 加载图片
        paintImageView.configureImageViewWithImageURL("http://g.hiphotos.baidu.com/image/pic/item/ae51f3deb48f8c547a9c532e38292df5e0fe7f60.jpg", animated: true)
        paintImageView.backgroundColor = UIColor.whiteColor()
        self.view .addSubview(paintImageView)
        
    }


}
