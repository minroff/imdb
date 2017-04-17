
#import "ASBookmarks.h"

@implementation ASBookmarks

+( ASBookmarks* ) sharedManager
{
    static ASBookmarks* sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once( &predicate, ^{
        sharedInstance = [ [ self alloc ] init ];
    } );
    return sharedInstance;
}

- (id) init {
    [self reloadBmarks];
    return [super init];
}

- (void) saveBookmark:(ASFilmItem*)item {  //Добавляем в массив
    [_arrayOfBookmarks addObject:item];
    [self sync];
}

- (void) sync {     //Метод сохранения в память
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:_arrayOfBookmarks];//Архивируем массив с закладками
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"bookmarks"]; //Сохраняем в память архив
 //   [self reloadBmarks]; мешал добавлять в память и убирать и сохранять все
}

- (void) reloadBmarks { //Загрузка из памяти
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"bookmarks"]; //Вытаскиваем из памяти
    _arrayOfBookmarks = [NSKeyedUnarchiver unarchiveObjectWithData:data]; //Деархивируем
    if (!_arrayOfBookmarks) {  //Если ничего не вытащили, то создаем массив с нуля
        _arrayOfBookmarks = [NSMutableArray new];
    }
}

- (void)removeItem:(ASFilmItem *)item { //Удаляем из памяти
  
    [_arrayOfBookmarks removeObject:item];
    [self sync];
}


@end
