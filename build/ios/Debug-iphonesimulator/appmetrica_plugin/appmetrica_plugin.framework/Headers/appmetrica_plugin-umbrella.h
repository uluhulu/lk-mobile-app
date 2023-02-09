#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "YMMFAppMetricaPlugin.h"
#import "YMMFAdRevenueConverter.h"
#import "YMMFAppMetricaActivator.h"
#import "YMMFAppMetricaConfigConverter.h"
#import "YMMFAppMetricaConfigConverterImplementation.h"
#import "YMMFAppMetricaImplementation.h"
#import "YMMFECommerceConverter.h"
#import "YMMFLocationConverter.h"
#import "YMMFPigeon.h"
#import "YMMFPluginErrorDetailsConverter.h"
#import "YMMFReporterImplementation.h"
#import "YMMFRevenueInfoConverter.h"
#import "YMMFStackTraceConverter.h"
#import "YMMFUserProfileConverter.h"

FOUNDATION_EXPORT double appmetrica_pluginVersionNumber;
FOUNDATION_EXPORT const unsigned char appmetrica_pluginVersionString[];

