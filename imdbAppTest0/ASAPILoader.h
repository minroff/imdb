
#import <Foundation/Foundation.h>

@protocol ASAPILoaderDelegate <NSObject>  //Протокол для обработки пришедших данных

- (void) loader:(id)loader recieveData:(NSData*)data; //Если получаем данные
- (void) loader:(id)loader didFailWithError:(NSError*)error; //Если получаем ошибку

@end

@interface ASAPILoader : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSData *_responseData;  //Получаемые данные
    NSURLConnection *_connection; //Соединение
}

@property (nonatomic, weak) id<ASAPILoaderDelegate>delegate; //Делегат для протокола ASAPILoaderDelegate
- (id) initWithSearchRequest;   //Инициализируем запрос
- (void) loadDataWithSearchKey:(NSString*)key; //Загрузка для ключевого слова

@end
