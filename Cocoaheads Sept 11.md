#iOS 8:  
######the little things

---

##We won't talk about: 

- HealthKit
- HomeKit
- Touch ID
- Extensions
- CloudKit
- Handoff
- Metal

---

#What about the small things?


---
#isOperatingSystemAtLeastVersion

import Foundation

let yosemite = NSOperatingSystemVersion(majorVersion: 10, minorVersion: 10, patchVersion: 0)
NSProcessInfo().isOperatingSystemAtLeastVersion(yosemite) // false

							nshipster

---
#majorRadius

UITouch *touch = [touches lastObject];
touch.majorRadius; // 20

---

View Debugging

---

Interface builder change properties

use my custom switch

---

active constraints

---

camera control

---

Where did UIAlertView go?

---

Asset libraries: pdf, vector, jpeg

---

#Open settings URL
```objectivec
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
```

UIApplicationOpenSettingsURLString

---

#Thank you!

Steven Thompson
@stevethomp

https://github.com/stevethomp/iOS-8-Newness