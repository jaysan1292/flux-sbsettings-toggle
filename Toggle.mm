#import <Foundation/Foundation.h>
#import <notify.h>

#define kFluxPrefsLocation @"/var/mobile/Library/Preferences/org.herf.flux.plist"
#define kEnableKey @"enable"

extern "C" BOOL isEnabled() {
	NSMutableDictionary* pref = [NSMutableDictionary dictionaryWithContentsOfFile:kFluxPrefsLocation];
	return [[pref objectForKey:kEnableKey] boolValue];
}

extern "C" void setState(BOOL enabled) {
	NSMutableDictionary* pref = [NSMutableDictionary dictionaryWithContentsOfFile:kFluxPrefsLocation];

	[pref setValue:[NSNumber numberWithBool:enabled] forKey:kEnableKey];
	[pref writeToFile:kFluxPrefsLocation atomically:YES];

	notify_post("org.herf.flux-enable");
}

extern "C" BOOL isCapable() { return YES; }

extern "C" BOOL getStateFast() { return isEnabled(); }

extern "C" float getDelayTime() { return 0.5f; }
