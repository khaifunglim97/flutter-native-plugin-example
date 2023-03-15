#import "ImageViewController.h"
#import <flutter_native_plugin_example/flutter_native_plugin_example-Swift.h>

@implementation ImageViewControllerObjC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:false animated:true];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(btnBackPressed:)]];
    
    UILabel *thisLabel = [[UILabel alloc] initWithFrame:CGRectMake([[self view] bounds].size.width/2 - 50, [[self view] bounds].size.height/2 - 200, 100, 50)];
    [thisLabel setText:@"Written in ObjC"];
    [thisLabel setTextColor:[UIColor blackColor]];
    [thisLabel setBackgroundColor:[UIColor clearColor]];
    [thisLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 12.0f]];
    [thisLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:thisLabel];
    
    UIImageView *thisImageView = [[UIImageView alloc] initWithFrame:CGRectMake([[self view] bounds].size.width/2 - 50, [[self view] bounds].size.height/2 - 100, 100, 100)];
    thisImageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"Images/apple" ofType:@"png"]];
    [self.view addSubview:thisImageView];
    
    UIButton *btnDone = [[UIButton alloc] initWithFrame:CGRectMake([[self view] bounds].size.width/2 - 50, [[self view] bounds].size.height/2 + 150, 100, 50)];
    [btnDone setBackgroundColor:[UIColor blackColor]];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDonePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
}
- (void)btnBackPressed:(UIButton *) sender {
    [self.plugin onBackWithResult:false sender:@"Back"];
}
- (void)btnDonePressed:(UIButton *) sender {
    [self.plugin onDoneWithResult:true sender:@"Done"];
}
@end
