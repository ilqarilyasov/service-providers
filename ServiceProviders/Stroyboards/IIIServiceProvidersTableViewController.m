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
@property (nonatomic, strong) NSArray<IIIServiceProvider *> *providers;

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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

// MARK: - Properties

- (void)setProviders:(NSArray<IIIServiceProvider *> *)providers
{
    _providers = [providers copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
