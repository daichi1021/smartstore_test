//
//  DetailViewController.m
//  SmartStore_Test
//
//  Created by テラスカイ on 2014/03/20.
//  Copyright (c) 2014年 Test. All rights reserved.
//

#import "DetailViewController.h"
#import "SmartStoreInterface.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (nonatomic, strong) NSString *idData;
@property (nonatomic, strong) NSString *nameData;

@end

@implementation DetailViewController

- (id) initWithName:(NSString *)nameLabel
                 id:(NSString *)idLabel
{
    self = [super init];
    if(self) {
        _nameData = nameLabel;
        _idData = idLabel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Name Edit";
    
    UIBarButtonItem *saveButton =
    [[UIBarButtonItem alloc] initWithTitle:@" Save "
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(pressSaveButton)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    _nameField.text = _nameData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pressSaveButton
{
    NSDictionary *fields  = @{@"Name": _nameField.text};
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForUpdateWithObjectType:@"Account"
                                                                               objectId:_idData
                                                                                 fields:fields];
    [[SFRestAPI sharedInstance] send:request delegate:self];
}


#pragma mark - SFRestAPIDelegate

- (void)request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error
{
    //通信エラーが発生した場合の処理
    if([error code] == -1009){
        [self tempDataUpdate];
    }
    NSLog(@"request:didFailLoadWithError: %@", error);
}

- (void)tempDataUpdate
{
    NSDictionary *updateobj  = @{@"Name": _nameField.text, @"Id": _idData};
    [[[SmartStoreInterface alloc] init] upsertAccount:updateobj];
}

@end
