#import <Foundation/Foundation.h>
#import <notify.h>

extern "C" BOOL isEnabled() {
	FILE* ps;
	char output[256];

	ps = popen("ps ax|grep flux", "r");

	while (fgets(output, 256, ps) != NULL) {
		NSString* out = [NSString stringWithCString:output encoding:NSASCIIStringEncoding];
		NSRange running = [out rangeOfString:@"/usr/libexec/flux"];

		if(running.location != NSNotFound) return YES;
	}
	return NO;
}

extern "C" void setState(BOOL enabled) {
	if(enabled) {
		notify_post("com.jaysan1292.fluxon");
	} else {
		notify_post("com.jaysan1292.fluxoff");
	}
}

extern "C" BOOL isCapable() { return YES; }

extern "C" BOOL getStateFast() { return isEnabled(); }

extern "C" float getDelayTime() { return 0.5f; }
