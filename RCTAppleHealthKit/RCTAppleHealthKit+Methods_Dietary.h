//
//  RCTAppleHealthKit+Methods_Dietary.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Dietary)

- (void)dietary_saveFood:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_saveWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getNutritionSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
