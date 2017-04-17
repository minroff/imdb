
#import <UIKit/UIKit.h>
#import "ASAPILoader.h"
#import "ASMyCell.h"

@interface ASViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ASAPILoaderDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView; 
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
