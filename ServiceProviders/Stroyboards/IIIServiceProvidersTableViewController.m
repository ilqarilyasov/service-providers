//
//  IIIServiceProvidersTableViewController.m
//  ServiceProviders
//
//  Created by Ilgar Ilyasov on 6/13/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

#import "IIIServiceProvidersTableViewController.h"
#import "ServiceProviders-Swift.h"

@interface IIIServiceProvidersTableViewController ()

@property (nonatomic,strong) IIIServiceAPI *serviceAPI;
@property (nonatomic,strong) NSArray<IIIServiceProvider *> *providers;

@end

@implementation IIIServiceProvidersTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _serviceAPI = [[IIIServiceAPI alloc] init];
    [self.serviceAPI fetchServiceProvidersWithCompletion:^(NSArray<IIIServiceProvider *> * providers, NSError * error) {
        if (error) {
            NSLog(@"Error: %@",error);
            //Show alert
        }
        self.providers = providers;
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.providers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IIIServiceProviderTableViewCell *providerCell = [tableView dequeueReusableCellWithIdentifier:@"ServiceProviderCell" forIndexPath:indexPath];
    
    IIIServiceProvider *provider = self.providers[indexPath.row];
    providerCell.provider = provider;
    
    return providerCell;
}


- (IBAction)didSortServiceProviders:(UIBarButtonItem *)sender {
    UIAlertController *actionSheet = [UIAlertController
                                alertControllerWithTitle:@"Sort Service Providers"
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sortByName = [UIAlertAction
                                 actionWithTitle:@"Sort by name"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     NSLog(@"You pressed button one");
                                     
                                     NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
                                     self.providers = [self.providers sortedArrayUsingDescriptors:@[sortDescriptor]];
                                     
                                                          }];
    
    UIAlertAction *sortByGrade = [UIAlertAction
                                  actionWithTitle:@"Sort by grade"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {
                                      
                                      NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"overallGrade" ascending:YES];
                                      self.providers = [self.providers sortedArrayUsingDescriptors:@[sortDescriptor]];
                                      
                                                           }];
    
    UIAlertAction *sortByReviewCount = [UIAlertAction
                                        actionWithTitle:@"Sort by review count"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"reviewCount" ascending:NO];
                                            self.providers = [self.providers sortedArrayUsingDescriptors:@[sortDescriptor]];
                                            
                                                          }];
    
    [actionSheet addAction:sortByName];
    [actionSheet addAction:sortByGrade];
    [actionSheet addAction:sortByReviewCount];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowProviderDetail"]) {
        IIIServiceProviderDetailViewController * detailVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        IIIServiceProvider *provider = self.providers[indexPath.row];
        detailVC.provider = provider;
    }
}

#pragma mark - Setter

- (void)setProviders:(NSArray<IIIServiceProvider *> *)providers
{
    _providers = [providers copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
