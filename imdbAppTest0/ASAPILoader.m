
#import "ASAPILoader.h"

@implementation ASAPILoader

- (id)initWithSearchRequest {
    _responseData = [NSData new]; //Инициализируем получаемые данные
    
    return [self init];
}

- (void) loadDataWithSearchKey:(NSString *)key {
    NSString* urlString = [NSString stringWithFormat:@"http://www.omdbapi.com/?s=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL* url = [NSURL URLWithString:urlString]; //переводим ссылку в url
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f]; //Создаем запрос по url
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //Создаем соединение по запросу
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    _responseData = data; //Записываем полученные данные

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.delegate loader:self recieveData:_responseData];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate loader:self didFailWithError:error]; //Обработка ошибки
}

@end
