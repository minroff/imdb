
#import <UIKit/UIKit.h>
#import "ASMyCell.h"
#import "ASBookmarks.h"

@interface ASBookmarkedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

