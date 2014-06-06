#import "KimballinDatabase.h"
#import "StaffMember.h"
#import "Event.h"

@interface KimballinDatabase()
@property (nonatomic, readwrite, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation KimballinDatabase

+ (KimballinDatabase *)sharedDefaultKimballinDatabase
{
    return [self sharedKimballinDatabaseWithName:@"KimballinDatabase_DEFAULT"];
}

+ (KimballinDatabase *)sharedKimballinDatabaseWithName:(NSString *)name
{
    static NSMutableDictionary *databases = nil;
    if (!databases) databases = [[NSMutableDictionary alloc] init];
    
    KimballinDatabase *database = nil;
    
    if ([name length]) {
        database = databases[name];
        if (!database) {
            database = [[self alloc] initWithName:name];
            databases[name] = database;
        }
    }
    
    return database;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        if ([name length]) {
            NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                 inDomains:NSUserDomainMask] firstObject];
            url = [url URLByAppendingPathComponent:name];
            UIManagedDocument *document = [[UIManagedDocument alloc] initWithFileURL:url];
            if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
                [document openWithCompletionHandler:^(BOOL success) {
                    if (success) self.managedObjectContext = document.managedObjectContext;
                }];
            } else {
                [document saveToURL:url
                   forSaveOperation:UIDocumentSaveForCreating
                  completionHandler:^(BOOL success) {
                      if (success) {
                          self.managedObjectContext = document.managedObjectContext;
                          [self fetch];
                      }
                      
                  }];
            }
        } else {
            self = nil;
        }
    }
    return self;
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    [[NSNotificationCenter defaultCenter] postNotificationName:KimballinDatabaseAvailable object:self];
}

- (void)fetch
{
    if (self.managedObjectContext) {

        NSString *staffMemberPath = [[NSBundle mainBundle] pathForResource:@"StaffMembers" ofType:@"plist"];
        NSArray *staffMemberArray = [NSArray arrayWithContentsOfFile:staffMemberPath];
        for (NSDictionary *dict in staffMemberArray) {
            @try {
                StaffMember *staffMember = [NSEntityDescription insertNewObjectForEntityForName:@"StaffMember" inManagedObjectContext:self.managedObjectContext];
                staffMember.name = [dict objectForKey:@"name"];
                staffMember.email = [dict objectForKey:@"email"];
                staffMember.phone = [dict objectForKey:@"phone"];
                staffMember.position = [dict objectForKey:@"position"];
                staffMember.room = [dict objectForKey:@"room"];
                staffMember.imageName = [dict objectForKey:@"imageName"];
                
                NSError *err = nil;
                [self.managedObjectContext save:&err];
            } @catch (NSException * ex) {
                NSLog(@"Exception: %@", ex);
            }
    
        }
        
        NSString *eventsPath = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"];
        NSArray *eventsArray = [NSArray arrayWithContentsOfFile:eventsPath];
        for (NSDictionary *dict in eventsArray) {
            @try {
                Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
                event.name = [dict objectForKey:@"name"];
                event.location = [dict objectForKey:@"location"];
                event.startTime = [dict objectForKey:@"startTime"];
                event.endTime = [dict objectForKey:@"endTime"];
                event.latitude = [dict objectForKey:@"latitude"];
                event.longitude = [dict objectForKey:@"longitude"];
                
                NSError *err = nil;
                [self.managedObjectContext save:&err];
            } @catch (NSException *ex) {
                NSLog(@"Exception: %@", ex);
            }
        }
        
    }
}

@end
