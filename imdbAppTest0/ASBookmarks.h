
#import <Foundation/Foundation.h>
#import "ASFilmItem.h"

@interface ASBookmarks : NSObject

+( ASBookmarks* ) sharedManager; //Создаем синглтон

@property (nonatomic, strong) NSMutableArray* arrayOfBookmarks; //Создаем массив для хранения закладок
- (void) saveBookmark:(ASFilmItem*)item;                 //Метод сохранения
- (void) removeItem:(ASFilmItem*)item;//Метод удаления
@end
