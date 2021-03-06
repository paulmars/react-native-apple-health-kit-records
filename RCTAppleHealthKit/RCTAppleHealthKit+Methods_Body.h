//
//  RCTAppleHealthKit+Methods_Body.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Body)

- (void)body_getHeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getWeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getBodyMassIndexSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getBodyFatPercentageSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getLeanBodyMassSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getWaistCircumferenceSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getBasalBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getElectrodermalActivitySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
