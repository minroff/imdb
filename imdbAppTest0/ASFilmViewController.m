
#import "ASFilmViewController.h"
#import "ASBookmarks.h"
#import "Social/Social.h"
#import "EGOImageView.h"



@interface ASFilmViewController ()

@end

@implementation ASFilmViewController

@synthesize titleLab;
@synthesize yearCountry;
@synthesize imaga;
@synthesize plotLab;
@synthesize act;
@synthesize bookmarkIndicator;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ASBookmarks* bmks = [ASBookmarks sharedManager];
    BOOL flag = NO;
    
    for (ASFilmItem* film in bmks.arrayOfBookmarks) {
        if ([film.imdbID isEqualToString:self.item.imdbID]) { //self.item.imdbID фильм из ячейки
            flag = YES;
            break;
        }
    }

    if (flag) {
        self.bookmarkIndicator.image = [UIImage imageNamed:@"bmark.png"];
    }
    else
    {
        self.bookmarkIndicator.image = nil;
    }
    
    
    self.navigationItem.title = self.item.title;
    
    
    
    NSMutableString* dash = [NSMutableString new];
    NSMutableString* scopka1 = [NSMutableString new];
    NSMutableString* scopka2 = [NSMutableString new];
    NSMutableString* newString = [NSMutableString new];
    
    NSMutableString* dateGenreEct = [NSMutableString new];
    
    [dash appendString:@" - "];
    [scopka1 appendString:@" ("];
    [scopka2 appendString:@")"];
    [newString appendString:@"\n"];
    
    
    NSMutableString* runTime  = [NSMutableString stringWithString:self.item.runtime];
    NSMutableString* genre    = [NSMutableString stringWithString:self.item.genre];
    NSMutableString* country  = [NSMutableString stringWithString:self.item.country];
    NSMutableString* released = [NSMutableString stringWithString:self.item.released];
    
    [dateGenreEct appendString:runTime];
    [dateGenreEct appendString:dash];
    [dateGenreEct appendString:genre];
    [dateGenreEct appendString:dash];
    [dateGenreEct appendString:released];
    [dateGenreEct appendString:scopka1];
    [dateGenreEct appendString:country];
    [dateGenreEct appendString:scopka2];
    
    
    
    NSMutableString* rateDirEct = [NSMutableString new];
    
    
    NSMutableString* raringPre = [NSMutableString new];
    NSMutableString* directorPre = [NSMutableString new];
    NSMutableString* writersPre = [NSMutableString new];
    NSMutableString* typePre = [NSMutableString new];
    
    [raringPre appendString:@"Rating: "];
    [directorPre appendString:@"Director: "];
    [writersPre appendString:@"Writers: "];
    [typePre appendString:@"Type: "];
    
    NSMutableString* rating  = [NSMutableString stringWithString:self.item.rated];
    NSMutableString* director  = [NSMutableString stringWithString:self.item.director];
    NSMutableString* writers  = [NSMutableString stringWithString:self.item.writer];
    NSMutableString* type  = [NSMutableString stringWithString:self.item.type];
    
    [rateDirEct appendString:raringPre];
    [rateDirEct appendString:rating];
    
    [rateDirEct appendString:newString];
    
    [rateDirEct appendString:directorPre];
    [rateDirEct appendString:director];
    
    [rateDirEct appendString:newString];
    
    [rateDirEct appendString:writersPre];
    [rateDirEct appendString:writers];
    
    [rateDirEct appendString:newString];
    
    [rateDirEct appendString:typePre];
    [rateDirEct appendString:type];
    
    
    
    
    
    NSMutableString* shotDiscription = [NSMutableString new];
    NSMutableString* discription = [NSMutableString stringWithString:self.item.plot];
    NSMutableString* discPre = [NSMutableString stringWithString:@"Short description: \n"];
    
    [shotDiscription appendString:discPre];
    [shotDiscription appendString:discription];
    
    
    
    
    
    
    self.titleLab.text = _item.title;
    self.yearCountry.text = dateGenreEct;
    self.act.text = rateDirEct;
    self.plotLab.text = shotDiscription;
    
    [(EGOImageView*)self.imaga setPlaceholderImage:[UIImage imageNamed:@"noPoster.jpg"]];
    [(EGOImageView*)self.imaga setImageURL:[NSURL URLWithString:[self.item poster]]];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionSheet:)]; // инициализания кнопки navigationItem right
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

   }

- (void) setItem:(ASFilmItem *)item {
    _item = item;
}


- (IBAction)actionSheet:(id)sender {
    [super viewDidLoad];
    
    

    ASBookmarks* bmks = [ASBookmarks sharedManager];
    BOOL flag = NO;
    
    for (ASFilmItem* film in bmks.arrayOfBookmarks) {
        if ([film.imdbID isEqualToString:self.item.imdbID]) { //self.item.imdbID фильм из ячейки
            flag = YES;
            break;
        }
    }
    
    NSString* bookmark = [NSString new];
    if (!flag) {
        bookmark = @"Add bookmark";
    }
    else {
        bookmark = @"Remove bookmark";
    }

    
    UIActionSheet *actSheet = [[UIActionSheet alloc] initWithTitle:@"Share"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:@"Facebook share"
                                                 otherButtonTitles:@"Twitter share", @"Email share", bookmark, nil];
    actSheet.DestructiveButtonIndex = 3;
    
    [actSheet showInView:self.view];
}



#pragma mark - MFMailComposeViewController Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            // TODO: Успешно отправлено
            break;
        case MFMailComposeResultCancelled:
            // TODO: Отменено пользователем
            break;
        case MFMailComposeResultFailed:
            // TODO: Произошла ошибка
            break;
        case MFMailComposeResultSaved:
            // TODO: Сохранено как черновик
            break;
        default:
            break;
    }
    // Убираем окно
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *clickedButtonString = [NSString stringWithFormat:@"Кнопка по индексу %d была нажата",buttonIndex];
    NSLog(@"%@", clickedButtonString);
    switch (buttonIndex) {
        case 0: {
            SLComposeViewController *composeController = [SLComposeViewController
                                                          composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [composeController setInitialText:self.item.title];
            [composeController addImage:self.imaga.image];
            [composeController addURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://www.imdb.com/title/%@",self.item.imdbID]]];
            
            [self presentViewController:composeController
                               animated:YES completion:nil];
            
            
            
            
            
            
            
            break;
        }
        case 1: {
            
            SLComposeViewController *composeController = [SLComposeViewController
                                                          composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            [composeController setInitialText:self.item.title];
            [composeController addImage:self.imaga.image];
            [composeController addURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://www.imdb.com/title/%@",self.item.imdbID]]];
            
            [self presentViewController:composeController
                               animated:YES completion:nil];
            
            
            break;
        }
        case 2: {
            
            NSData * posterData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.item.poster]];
            
            
            // Проверяем, настроен ли почтовый клиент на отправку почту
            if ([MFMailComposeViewController canSendMail]) {
                
                // Создаем контроллер
                MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
                // Делегатом будем мы
                mailController.mailComposeDelegate = self;
                [mailController addAttachmentData:posterData mimeType:@"image/png" fileName:@"poster"];
                // Тема письма
                [mailController setSubject:@"Enjoy the movie"];
                // Текст письма
                NSMutableString* body = [NSMutableString new];
                [body appendString:self.item.title];
                [body appendString:@"\nhttp://www.imdb.com/title/%@"];
                [body appendString:self.item.imdbID];
                
                
                [mailController setMessageBody:body isHTML:NO];
                // Если объект создан
                if (mailController) {
                    // Показываем контроллер
                    [self presentViewController:mailController animated:YES completion:nil];
                }
                
            } else {
                // TODO: Обработка ошибки
            }
            
            
            break;
        }
        case 3: {
            ASBookmarks* bmks = [ASBookmarks sharedManager];
            BOOL flag = NO;
            
            for (ASFilmItem* film in bmks.arrayOfBookmarks) {
                if ([film.imdbID isEqualToString:self.item.imdbID]) { //self.item.imdbID фильм из ячейки
                    flag = YES;
                    break;
                }
            }
            
            if (!flag) {
                [bmks saveBookmark:self.item];
                self.bookmarkIndicator.image = [UIImage imageNamed:@"bmark.png"];

            } else {
                [bmks removeItem:self.item];
                self.bookmarkIndicator.image = nil;

            }
            
            NSLog(@"bmarks count:%zd", bmks.arrayOfBookmarks.count);
            break;
        }
        default:
            break;
    }
    
    
}

@end
