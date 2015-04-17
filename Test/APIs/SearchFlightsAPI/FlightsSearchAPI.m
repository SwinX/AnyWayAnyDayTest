//
//  SearchFlightsAPI.m
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightsSearchAPI.h"
#import "AFHTTPRequestOperationManager+SharedManager.h"

#import "FlightSearchData.h"
#import "Airport.h"
#import "FlightsRequestResult.h"
#import "FlightClass.h"

@interface FlightsSearchAPI (Private)

-(NSString*)encodeFlightSearchData:(FlightSearchData*)data;
-(NSString*)encodeFlightDate:(NSDate*)date;
-(NSString*)encodeDepartureAirport:(Airport*)departure arrivalAirport:(Airport*)arrival;
-(NSString*)encodePassengerAmount:(NSUInteger)amount;
-(NSString*)encodeFlightClass:(FlightClass*)flightClass;

@end

@implementation FlightsSearchAPI

-(void)searchFlights:(FlightSearchData*)data {
    __weak FlightsSearchAPI* weakSelf = self;
    [[AFHTTPRequestOperationManager sharedManager] GET:@"api/NewRequest2/"
                                            parameters:@{
                                                         @"Route": [self encodeFlightSearchData:data],
                                                         @"_Serialize": @"JSON"
                                                        }
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                    FlightsRequestResult* result = [MTLJSONAdapter modelOfClass:[FlightsRequestResult class]
                                                                                             fromJSONDictionary:responseObject
                                                                                                          error:nil];
                                                   if (weakSelf.onFlighsSearchRequestSent) {
                                                        weakSelf.onFlighsSearchRequestSent(result);
                                                    }
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   FlightsRequestResult* result = [[FlightsRequestResult alloc] initWithError:error];
                                                   if (weakSelf.onFlighsSearchRequestSent) {
                                                       weakSelf.onFlighsSearchRequestSent(result);
                                                   }
                                               }];
}

@end

@implementation FlightsSearchAPI (Private)

-(NSString*)encodeFlightSearchData:(FlightSearchData*)data {
    NSString* encoded = @"";
    encoded = [encoded stringByAppendingString:[self encodeFlightDate:data.flightDate]];
    encoded = [encoded stringByAppendingString:[self encodeDepartureAirport:data.departure arrivalAirport:data.arrival]];
    encoded = [encoded stringByAppendingString:[self encodePassengerAmount:data.passengerAmount]];
    encoded = [encoded stringByAppendingString:[self encodeFlightClass:data.flightClass]];
    return encoded;
}

-(NSString*)encodeFlightDate:(NSDate*)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:date];
    return [NSString stringWithFormat:@"%02ld%02ld", components.day, components.month];
}

-(NSString*)encodeDepartureAirport:(Airport*)departure arrivalAirport:(Airport*)arrival {
    return [departure.code stringByAppendingString:arrival.code];
}

-(NSString*)encodePassengerAmount:(NSUInteger)amount {
    return [NSString stringWithFormat:@"AD%ldCN0IN0", (unsigned long)amount]; //encoding here children and infants too
}

-(NSString*)encodeFlightClass:(FlightClass*)flightClass {
    NSString* encoded = @"SC";
    switch (flightClass.type) {
        case FCTEconomy:
            return [encoded stringByAppendingString:@"E"];
        case FCTBusiness:
            return [encoded stringByAppendingString:@"B"];
        default:
            return [encoded stringByAppendingString:@"A"];
    }
}

@end
