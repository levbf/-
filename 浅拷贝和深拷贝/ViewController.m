//
//  ViewController.m
//  浅拷贝和深拷贝
//
//  Created by levbf on 2017/3/20.
//  Copyright © 2017年 levbf. All rights reserved.
//


/*************************
 深拷贝：新对象，地址不同，内容相同
 浅拷贝：原来的对象，地址相同。
 copy/mutableCopy NSString
 copy/mutableCopy NSMutableString
 copy NSObject
 NSMutableCopy NSObject
 *************************/
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    /********************copy/mutableCopy NSString*********************************/
    NSString* strSourceHello = @"Hello";
    //  NSString* strCopyHello = [self copyMethod:strSourceHello];
    NSString* strCopyHello = [strSourceHello copy];//地址相同
    NSString* strMutableHello =[strSourceHello mutableCopy];//地址不同，内容相同
    NSLog(@"strSourceHello:%p,strCopyHello:%p,strMutableHello:%p",strSourceHello,strCopyHello,strMutableHello);
    //strSourceHello:0x103676098,strCopyHello:0x103676098,strMutableHello:0x608000262cc0

    //结论:mutableCopy拷贝出来的对象为NSMutableString ，NSMutableArray，NSMutableDictionary
    //不可变对象copy拷贝出来的对象为NSString，NSArray，NSDictionary，地址拷贝，
    //可变对象copy拷贝出来的对象为不可变对象
    //不可变对象mutablecopy拷贝出来为不可变对象
    
    /********************copy/mutableCopy NSMutableString**************************/
    NSMutableString * nmstr= [[NSMutableString alloc]initWithString:@"World"];
    NSString *strImutable = [nmstr copy];
    NSMutableString *NMstrCopy= [nmstr copy];
    NSMutableString *NMstrMutable= [nmstr mutableCopy];
    NSLog(@"str:%p, strImable:%p,strMutable:%p",nmstr,strImutable,NMstrMutable);
    //nmstr:0x600000266480, strImable:0xa0000646c726f575,strMutable:0x6000002664c0
//    NSString *string = [strImutable stringByAppendingString:@"123"];//不可变字符串，
//    [NMstrCopy appendString:@"123"];//error
    
    [NMstrMutable appendString:@"123"];//可变字符串
    NSLog(@"strImutable:%@,NMstrCopy:%@,strMutable:%@",strImutable,NMstrCopy,NMstrMutable);
    //strImutable:World,strMutable:World123
    
    //结论:NSMutableString对象，copy和mutableCopy拷贝出来的都是新对象，属于深拷贝
    
    /**************************copy/mutableCopy NSObject**************************/
    ViewController *vc = [[ViewController alloc]init];
    vc.name = @"HelloWorld";
    ViewController *vcCopy = [vc copy];//没有重写-(id)copyWithZone:(NSZone *)zone这个方法分配空间会闪退
    NSLog(@"vc:%@,copy:%@",vc,vcCopy);//vc:<ViewController: 0x7fe0615082e0>,copy:<ViewController: 0x7fe0615085f0>
    NSLog(@"vcName:%@,copyName:%@",vc.name,vcCopy.name);
    //深拷贝
    
    ViewController *vcMutableCopy= [vc mutableCopy];//没有重写-(id)mutableCopyWithZone:(NSZone *)zone这个方法申请空间会闪退
    NSLog(@"vc:%@,mutableCopy:%@",vc,vcMutableCopy);//vc:<ViewController: 0x7fe0615082e0>,mutableCopy:<ViewController: 0x7fe061407790>
    NSLog(@"vcName:%@,MutablecopyName:%@",vc.name,vcMutableCopy.name);
    
    
    //copy返回不可变对象，mutablecopy返回可变对象
    NSArray* arrayValue= [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSArray* arrayCopy = [arrayValue copy];
    NSArray * arraymutablecopy = [arrayValue mutableCopy];
    arrayCopy  = nil;
    NSLog(@"arrayValue:%@,arrayCopy:%@",arrayValue,arrayCopy);
    
    NSLog(@"array:%p,arrayCopy:%p,arraymutablecopy:%p",arrayValue,arrayCopy,arraymutablecopy);
//    array:0x60000004b280,arrayCopy:0x60000004b280,arraymutablecopy:0x608000047830
    
    
//    NSMutableArray *marray = [arrayValue copy];//error
    NSMutableArray *marray = [arrayValue mutableCopy];
    
    [marray addObject:@"de"];
    [marray removeObjectAtIndex:0];
    NSLog(@"arrayValue:%@,marray:%@",arrayValue,marray);
    //arrayValue:(1,2,3) marray:(2,3,de)
    //copy指针拷贝，mutableCopy拷贝一个新的副本，对原来的没有影响
    
    
    //@property NSString copy
    NSMutableString *string = [NSMutableString stringWithFormat:@"hello"];
    ViewController *vcName = [[ViewController alloc]init];
    vcName.name = string;
    [string appendString:@"world"];//不能改变vcName.name的值，因为copy新的不可变对象
    NSLog(@"vcName.name:%p,string:%p",vcName.name,string);
    //vcName:hello
    
    //@property NSMutableString copy
    vcName.mname=string;
    [string appendString:@"world"];//可以改变vcName.mname的指，因为copy新的可改变对象
//    [vcName.mname appendString:@"world"];//error
    NSLog(@"vcName.mname:%@",vcName.mname);
    //vcName.mname:helloworld
    
    //@property strong
    NSMutableString *string2 = [NSMutableString stringWithFormat:@"hello"];
    vc.strongName =string2;
    [string2 appendString:@"world"];
    NSLog(@"strongName:%@",vc.strongName);
     //strongName:helloworld
    
    NSString *pt = @"abc";
    //@property assign
    
    //@property retain
    vc.retainName = pt;
    NSLog(@"retainName:%p,pt:%p",vc.retainName,pt);//retainName:0x10becc350,pt:0x10becc350
    //@property copy
    vc.name = pt;
    NSLog(@"name:%p,pt:%p",vc.name,pt);//name:0x10905b350,pt:0x10905b350
    
    //
    NSString *strSource = @"123";//源对象为不可变对象
    NSString* newcopy = [strSource copy];
    NSMutableString *newstr = [strSource copy];
    NSString *newNMCopy = [strSource mutableCopy];
    NSMutableString *newNMStr = [strSource mutableCopy];
    NSLog(@"strSource:%p",strSource);//strSource:0x10afa5110
    NSLog(@"newcopy:%p,newstr:%p,newNWCopy:%p,newNMStr:%p",newcopy,newstr,newNMCopy,newNMStr);
//    newcopy:0x10afa5110,newstr:0x10afa5110,newNWCopy:0x60800007ecc0,newNMStr:0x60800007ed80
    
    strSource = @"abc";
    NSLog(@"newcopy:%@,newstr:%@,newNWCopy:%@,newNMStr:%@",newcopy,newstr,newNMCopy,newNMStr);
    //newcopy:123,newstr:123,newNWCopy:123,newNMStr:123
    
    NSMutableString *strNMSource = [[NSMutableString alloc]initWithString:@"123"];//源对象为可变
    NSString* Nnewcopy = [strNMSource copy];
    NSMutableString *Nnewstr = [strNMSource copy];
    NSString *NnewNMCopy = [strNMSource mutableCopy];
    NSMutableString *NnewNMStr = [strNMSource mutableCopy];
    NSLog(@"strNMSource:%p",strNMSource);//strNMSource:0x60800007ed00
    NSLog(@"Nnewcopy:%p,Nnewstr:%p,NnewNWCopy:%p,NnewNMStr:%p",Nnewcopy,Nnewstr,NnewNMCopy,NnewNMStr);
//    Nnewcopy:0xa000000003332313,Nnewstr:0xa000000003332313,NnewNWCopy:0x60800007edc0,NnewNMStr:0x60800007ee00
    
    strNMSource = [[NSMutableString alloc]initWithString:@"abc"];
     NSLog(@"Nnewcopy:%@,Nnewstr:%@,NnewNWCopy:%@,NnewNMStr:%@",Nnewcopy,Nnewstr,NnewNMCopy,NnewNMStr);
//    Nnewcopy:123,Nnewstr:123,NnewNWCopy:123,NnewNMStr:123
    
    
    
    

}
-(id)copyWithZone:(NSZone *)zone
{
    ViewController *vc = [[ViewController allocWithZone:zone]init];
//    vc.name =  self.name;//没有这个复制，新对象属性为空 vcName:HelloWorld,copyName:(null)
    return  vc;
    return @"world";
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    ViewController *vc =[[ViewController allocWithZone:zone]init];
    vc.name = self.name;//没有这个复制，新对象属性为空 vcName:HelloWorld,MutablecopyName:(null)
    return vc;
}

-(void)setName:(NSString *)name
{
    _name = [name copy];
}
-(void)setMname:(NSMutableString *)mname
{
    _mname = [mname copy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
