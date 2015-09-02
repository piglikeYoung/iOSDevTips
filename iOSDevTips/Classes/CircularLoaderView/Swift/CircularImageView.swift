//
//  CircularImageView.swift
//  iOSDevTips
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {

    let progressIndicatorView = CircularLoaderView(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.progressIndicatorView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageViewWithImageURL(sUrl : NSString, animated : Bool) {
        
        let url = NSURL(string: sUrl as String)
        if animated {
            progressIndicatorView.frame = bounds
            progressIndicatorView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            
            // 下载图片
            self.sd_setImageWithURL(url, placeholderImage: nil, options: .RetryFailed , progress: { [weak self](receivedSize, expectedSize) -> Void in
                self!.progressIndicatorView.progress = CGFloat(receivedSize)/CGFloat(expectedSize)
                }) { [weak self](image, error, _, _) -> Void in
                    self!.progressIndicatorView.reveal()
            }
        } else {
            progressIndicatorView.frame = CGRectZero
            self.sd_setImageWithURL(url)
        }
    }
}
