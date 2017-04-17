
#import "ASViewController.h"
#import "ASFilmItem.h"
#import "ASFilmLoader.h"
#import "ASFilmViewController.h"
#import "ASBookmarkedViewController.h"
#import "EGOCache.h"
#import "EGOImageView.h"

@interface ASViewController () {
    ASAPILoader* _loader;               //объект для работы с API
    ASFilmLoader* _filmLoader;          //загрузчик фильма
    NSMutableArray* _items;             //массив данных о фильме
    UIActivityIndicatorView* _activity; //индикатор активности
    NSInteger totalCount;
    UILabel* _emptyLabel;
}

@end

@implementation ASViewController

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.delegate = self;     //делегат tableView ----> ASViewController
    _tableView.dataSource = self;   //делегат dataSource ----> ASViewController
    
    _loader = [[ASAPILoader alloc] initWithSearchRequest];
    _loader.delegate = self;
    
    _filmLoader = [[ASFilmLoader alloc] initWithSearchRequest];
    _filmLoader.delegate = self;
    
    _items = [NSMutableArray new];
    
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activity.center = self.view.center;
    _activity.hidesWhenStopped = YES;
    [self.view addSubview:_activity];//////////------------
    
    _emptyLabel = [UILabel new];
    _emptyLabel.textColor = [UIColor grayColor];
    _emptyLabel.textAlignment = NSTextAlignmentCenter;
    _emptyLabel.text = @"Нет результатов";
    [_emptyLabel sizeToFit];
    _emptyLabel.center = CGPointMake(roundf(CGRectGetWidth(self.view.frame)/2), 160);
    [self.view addSubview:_emptyLabel];
    _emptyLabel.hidden = YES;
    
}




- (void) loader:(id)loader recieveData:(NSData *)data {
    
    if (loader == _loader) //если APIloader
    {
        NSError *error;
        id resp = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSArray *dataArray;
        
        dataArray = [(NSDictionary*)resp objectForKey:@"Search"];
        totalCount = dataArray.count;
        if (dataArray.count != 0) {
            for (NSDictionary* dict in dataArray)
            {
                [_filmLoader loadFilmForId:[dict objectForKey:@"imdbID"]];
            }
        } else {
            [_activity stopAnimating];
            _emptyLabel.hidden = NO;
        }
        
    }
    else if (loader == _filmLoader) //если FilmLoader
    {
        NSError *error;
        id resp = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSDictionary *dataDict = (NSDictionary*) resp;
        
        [_items addObject:[self processDataArray:dataDict]];
        if (_items.count == totalCount){
            [_activity stopAnimating];
            [_tableView reloadData];
        }
    }
    
}

- (void) loader:(id)loader didFailWithError:(NSError *)error {
	if (loader == _loader) {
		[_activity stopAnimating];
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
}


- (ASFilmItem*) processDataArray:(NSDictionary*) dict {
    
    ASFilmItem* item = [ASFilmItem new];
    
    item.title = [dict objectForKey:@"Title"]; //
    item.year = [dict objectForKey:@"Year"];   //
    item.imdbID = [dict objectForKey:@"imdbID"];
    item.type = [dict objectForKey:@"Type"];
    
    item.rated = [dict objectForKey:@"Rated"];
    item.released = [dict objectForKey:@"Released"];
    item.runtime = [dict objectForKey:@"Runtime"];
    item.genre = [dict objectForKey:@"Genre"];
    item.director = [dict objectForKey:@"Director"];
    item.writer = [dict objectForKey:@"Writer"];
    item.plot = [dict objectForKey:@"Plot"]; //
    item.language = [dict objectForKey:@"Language"];
    item.country = [dict objectForKey:@"Country"]; //
    item.poster = [dict objectForKey:@"Poster"];   //
    item.metascore = [dict objectForKey:@"Metascore"];
    item.actors = [dict objectForKey:@"Actors"];
    item.imdbRating = [dict objectForKey:@"imdbRating"];
    item.imdbVotes = [dict objectForKey:@"imdbVotes"];
    item.response = [dict objectForKey:@"Response"];
    
    return item;
}

//подсчитываем кол-во ячеек
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    

    cell.titleLabel.text = [(ASFilmItem*)_items[indexPath.row] title]; //выводим название
    
    NSString* detailTextCountry = [(ASFilmItem*)_items[indexPath.row] country];
    NSString* year = [(ASFilmItem*)_items[indexPath.row] year];
    NSString* detailText = [NSString stringWithFormat:@"%@ - %@", detailTextCountry, year];
    cell.countryOrYearLabel.text = detailText;
    

	if (![(EGOImageView*)cell.posterImg placeholderImage]) {
		[(EGOImageView*)cell.posterImg setPlaceholderImage:[UIImage imageNamed:@"noPosterSmall.jpg"]];
	}
    [(EGOImageView*)cell.posterImg setImageURL:[NSURL URLWithString:[(ASFilmItem*)_items[indexPath.row] poster]]];


    cell.plot.text = [(ASFilmItem*)_items[indexPath.row] plot]; //выводим описание
    [cell.plot sizeToFit];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    ASBookmarks* bmks = [ASBookmarks sharedManager];
    BOOL flag = NO;
    for (ASFilmItem* film in bmks.arrayOfBookmarks) {
        if ([film.imdbID isEqualToString:[(ASFilmItem*)_items[indexPath.row] imdbID]]) {
            flag = YES;
            break;
        }
    }
    
    if (flag) {
        cell.mark.image = [UIImage imageNamed:@"mark.png"];
        
    } else {
        cell.mark.image = nil;
        
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASMyCell* cell = (ASMyCell*)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    CGFloat height = 0;
    height += CGRectGetMaxY(cell.plot.frame);
    height += 5.0f;
    return height;
}



 - (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{ //ответное действие на клик по ячейке
     ASFilmViewController* movieVC = [self.storyboard instantiateViewControllerWithIdentifier:@"movieId"];
     movieVC.item = (ASFilmItem*)_items[indexPath.row];
     
     [self.navigationController pushViewController:movieVC animated:YES];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
 }


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _emptyLabel.hidden = YES;
    _items = [[NSMutableArray alloc] init]; //удаляем старые фильмы
    [_tableView reloadData];
    
    [_activity startAnimating];
    [_loader loadDataWithSearchKey:searchBar.text];
    [searchBar endEditing:YES];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;//чтобы не было видно таблицу
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

@end
