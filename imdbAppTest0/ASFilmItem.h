
#import <Foundation/Foundation.h>

@interface ASFilmItem : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* year;
@property (nonatomic, strong) NSString* imdbID;
@property (nonatomic, strong) NSString* type;

@property (nonatomic, strong) NSString* rated;
@property (nonatomic, strong) NSString* released;
@property (nonatomic, strong) NSString* runtime;
@property (nonatomic, strong) NSString* genre;
@property (nonatomic, strong) NSString* director;
@property (nonatomic, strong) NSString* writer;
@property (nonatomic, strong) NSString* plot;
@property (nonatomic, strong) NSString* language;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* poster;
@property (nonatomic, strong) NSString* metascore;
@property (nonatomic, strong) NSString* actors;
@property (nonatomic, strong) NSString* imdbRating;
@property (nonatomic, strong) NSString* imdbVotes;
@property (nonatomic, strong) NSString* response;

- (void) encodeWithCoder:(NSCoder*)encoder;

- (id) initWithCoder:(NSCoder*)decoder;
    
@end
