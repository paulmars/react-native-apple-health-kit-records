//
//  RCTAppleHealthKit+Methods_Mindfulness.m
//  RCTAppleHealthKit
//
//


#import "RCTAppleHealthKit+Methods_Mindfulness.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Sleep)


- (void)mindfulness_saveMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double value = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    
    if(startDate == nil || endDate == nil){
        callback(@[RCTMakeError(@"startDate and endDate are required in options", nil, nil)]);
        return;
    }
    
    if (@available(iOS 10.0, *)) {
        HKCategoryType *type = [HKCategoryType categoryTypeForIdentifier: HKCategoryTypeIdentifierMindfulSession];
        HKCategorySample *sample = [HKCategorySample categorySampleWithType:type value:value startDate:startDate endDate:endDate];
        
        
        
        [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
            if (!success) {
                callback(@[RCTJSErrorFromNSError(error)]);
                return;
            }
            callback(@[[NSNull null], @(value)]);
        }];
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)mindfulness_getMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    double limit = [RCTAppleHealthKit doubleFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:HKSampleSortIdentifierEndDate
                                            ascending:NO
                                            ];
    
    if (@available(iOS 10.0, *)) {
        HKCategoryType *type = [HKCategoryType categoryTypeForIdentifier: HKCategoryTypeIdentifierMindfulSession];
        NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
        
        HKSampleQuery *query = [[HKSampleQuery alloc]
                                initWithSampleType:type
                                predicate:predicate
                                limit: limit
                                sortDescriptors:@[timeSortDescriptor]
                                resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
            
            if (error != nil) {
                NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", error);
                callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", error, nil)]);
                return;
            }
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:(10)];
            
            for (HKQuantitySample *sample in results) {
                NSLog(@"sample for mindfulsession %@", sample);
                NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];
                
                NSDictionary *elem = @{
                    @"startDate" : startDateString,
                    @"endDate" : endDateString,
                };
                
                [data addObject:elem];
            }
            callback(@[[NSNull null], data]);
        }
                                ];
        [self.healthStore executeQuery:query];
    } else {
        // Fallback on earlier versions
        callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", nil, nil)]);
    }
}

- (void)mindfulness_getSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    
    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    
    
    [self fetchSleepCategorySamplesForPredicate:predicate
                                          limit:limit
                                     completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
    }];
    
}



@end
