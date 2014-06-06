#import <Foundation/Foundation.h>

#define KimballinDatabaseAvailable @"KimballinDatabaseAvailable"

@interface KimballinDatabase : NSObject

+ (KimballinDatabase *)sharedDefaultKimballinDatabase;
+ (KimballinDatabase *)sharedKimballinDatabaseWithName:(NSString *)name;

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (void)fetch;

@end
