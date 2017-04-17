
#import "ASFilmItem.h"

@implementation ASFilmItem

- (void) encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.year forKey:@"year"];
    [encoder encodeObject:self.imdbID forKey:@"imdbID"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.rated forKey:@"rated"];
    [encoder encodeObject:self.released forKey:@"released"];
    [encoder encodeObject:self.runtime forKey:@"runtime"];
    [encoder encodeObject:self.genre forKey:@"genre"];
    [encoder encodeObject:self.director forKey:@"director"];
    [encoder encodeObject:self.writer forKey:@"writer"];
    [encoder encodeObject:self.plot forKey:@"plot"];
    [encoder encodeObject:self.language forKey:@"language"];
    [encoder encodeObject:self.country forKey:@"country"];
    [encoder encodeObject:self.poster forKey:@"poster"];
    [encoder encodeObject:self.metascore forKey:@"metascore"];
    [encoder encodeObject:self.actors forKey:@"actors"];
    [encoder encodeObject:self.imdbRating forKey:@"imdbRating"];
    [encoder encodeObject:self.imdbVotes forKey:@"imdbVotes"];
    [encoder encodeObject:self.response forKey:@"response"];
}
- (id) initWithCoder:(NSCoder*)decoder {
    self.title = [decoder decodeObjectForKey:@"title"];
    self.year = [decoder decodeObjectForKey:@"year"];
    self.imdbID = [decoder decodeObjectForKey:@"imdbID"];
    self.type = [decoder decodeObjectForKey:@"type"];
    self.rated = [decoder decodeObjectForKey:@"rated"];
    self.released = [decoder decodeObjectForKey:@"released"];
    self.runtime = [decoder decodeObjectForKey:@"runtime"];
    self.genre = [decoder decodeObjectForKey:@"genre"];
    self.director = [decoder decodeObjectForKey:@"director"];
    self.writer = [decoder decodeObjectForKey:@"writer"];
    self.plot = [decoder decodeObjectForKey:@"plot"];
    self.language = [decoder decodeObjectForKey:@"language"];
    self.country = [decoder decodeObjectForKey:@"country"];
    self.poster = [decoder decodeObjectForKey:@"poster"];
    self.metascore = [decoder decodeObjectForKey:@"metascore"];
    self.actors = [decoder decodeObjectForKey:@"actors"];
    self.imdbRating = [decoder decodeObjectForKey:@"imdbRating"];
    self.imdbVotes = [decoder decodeObjectForKey:@"imdbVotes"];
    self.response = [decoder decodeObjectForKey:@"response"];
    
    return self;
}

@end
