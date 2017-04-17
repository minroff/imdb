
#import <UIKit/UIKit.h>
#import "ASFilmItem.h"
#import <MessageUI/MessageUI.h>

@interface ASFilmViewController :UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    UILabel* titleLab;
    UILabel* yearCountry;
    UIImageView* imaga;
    UILabel* plotLab;
    UILabel* act;
    UIImageView *bookmarkIndicator;
}

@property (nonatomic, strong) ASFilmItem* item;

@property (nonatomic, retain) IBOutlet UILabel *titleLab;
@property (nonatomic, retain) IBOutlet UILabel *yearCountry;
@property (nonatomic, retain) IBOutlet UILabel *act;
@property (nonatomic, retain) IBOutlet UILabel *plotLab;
@property (nonatomic, retain) IBOutlet UIImageView *imaga;

@property (nonatomic, retain) IBOutlet UIImageView *bookmarkIndicator;

- (IBAction)actionSheet:(id)sender;






@end
