
#import <Foundation/Foundation.h>
#import "ASAPILoader.h"

@interface ASFilmLoader : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    NSData *_responseData;  //Получаемые данные
    NSURLConnection *_connection; //Соединение
}

- (id) initWithSearchRequest;   //Инициализируем запрос
- (void) loadFilmForId:(NSString*) ID;
@property (nonatomic, weak) id<ASAPILoaderDelegate>delegate; //Делегат для протокола ASAPILoaderDelegate

@end
