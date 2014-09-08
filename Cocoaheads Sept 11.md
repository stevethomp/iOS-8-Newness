#iOS 8 & Xcode 6:  
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

#Open settings URL
```objectivec
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
```

UIApplicationOpenSettingsURLString

---

#Now, Xcode!

---

Asset libraries: pdf, vector, jpeg

---
Xcode 6 lets you search within storyboards, and will highlight matches in the storyboard, and opens the hierarchy to the right point

image names, and button labels, text, also custom classes

---

Also, global search includes storyboards

---

Blocks debugging

---

#Thank you!

Steven Thompson
@stevethomp

https://github.com/stevethomp/iOS-8-Newness