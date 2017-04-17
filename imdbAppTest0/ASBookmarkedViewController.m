
#import "ASBookmarkedViewController.h"
#import "ASViewController.h"
#import "ASFilmItem.h"
#import "ASFilmViewController.h"
#import "EGOImageView.h"


@interface ASBookmarkedViewController () {
    
    NSMutableArray* _items;
    UILabel* _emptyLabel;
}

@end

@implementation ASBookmarkedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    ASBookmarks* bookmarks = [ASBookmarks sharedManager];
    
    _items = [NSMutableArray new];
    _items = bookmarks.arrayOfBookmarks;
    
    [_tableView reloadData];
    
    _emptyLabel = [UILabel new];
    _emptyLabel.textColor = [UIColor grayColor];
    _emptyLabel.textAlignment = NSTextAlignmentCenter;
    _emptyLabel.text = @"Нет закладок";
    [_emptyLabel sizeToFit];
    _emptyLabel.center = CGPointMake(roundf(CGRectGetWidth(self.view.frame)/2), 160);
    [self.view addSubview:_emptyLabel];
    _emptyLabel.hidden = YES;
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = _items.count;
    _emptyLabel.hidden = count != 0;
    return _items.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASMyCell* cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];

    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ASMyCell"owner:self options:nil];
    cell = [nib objectAtIndex:0];

    cell.titleLabel.font = [UIFont systemFontOfSize:20];
    cell.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.titleLabel.numberOfLines = 0;

    cell.titleLabel.text = [(ASFilmItem*)_items[indexPath.row] title];
    
	NSString* detailTextCountry = [(ASFilmItem*)_items[indexPath.row] country];
    NSString* year = [(ASFilmItem*)_items[indexPath.row] year];
    NSString* detailText = [NSString stringWithFormat:@"%@ - %@", detailTextCountry, year];
    cell.countryOrYearLabel.text = detailText;
    
	
	if (![(EGOImageView*)cell.posterImg placeholderImage]) {
		[(EGOImageView*)cell.posterImg setPlaceholderImage:[UIImage imageNamed:@"noPosterSmall.jpg"]];
	}
    [(EGOImageView*)cell.posterImg setImageURL:[NSURL URLWithString:[(ASFilmItem*)_items[indexPath.row] poster]]];
    
    //Выводим описание
    cell.plot.text = [(ASFilmItem*)_items[indexPath.row] plot];
    [cell.plot sizeToFit];

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASMyCell* cell = (ASMyCell*)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    CGFloat height = 0;
    height += CGRectGetMaxY(cell.plot.frame);
    height += 5.0f;
    return height;
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{ 
    ASFilmViewController* movieVC = [self.storyboard instantiateViewControllerWithIdentifier:@"movieId"];
    movieVC.item = (ASFilmItem*)_items[indexPath.row];
    
    [self.navigationController pushViewController:movieVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;//чтобы не было видно таблицу
}

@end