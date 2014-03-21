//
//  DetailViewController.h
//  SmartStore_Test
//
//  Created by テラスカイ on 2014/03/20.
//  Copyright (c) 2014年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFRestAPI.h"

@interface DetailViewController : UIViewController <SFRestDelegate>

- (id) initWithName:(NSString *)nameLabel
                 id:(NSString *)idLabel;

@end
