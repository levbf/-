//
//  ViewController.h
//  浅拷贝和深拷贝
//
//  Created by levbf on 2017/3/20.
//  Copyright © 2017年 levbf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSCopying,NSMutableCopying>
{
    NSArray* array;
}
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSMutableString *mname;
@property(nonatomic,strong)NSString* strongName;
@property(nonatomic,retain)NSString* retainName;

@end

