# Hint
Environment friendly post-it messages

### Color Palette used: [Ref](http://paletton.com/#uid=33L0u0kw0w0jyC+oRxVy4oIDfjr)
Blue - #1240AB
Yellow - #FFDD39

### Third Party Libraries Used:
- Bolts _(Prerequisite for Parse)_
- CLLocationManager-blocks _(Block based CoreLocation seems much cleaner)_
- Crashlytics _(Crash reporting)_
- Fabric _(General app health/analytics)_
- IQKeyboardManager _(Makes keyboard management trivial for Prototyping)_
- Parse _(Serves as the app's backend)_
- ParseUI _(PFImageView makes setting remote image on TableViewCell much simpler)_

### Known Issues:
- If the bluetooth is switched off midway then it will retain the state before switching off the bluetooth

### TODO:
- Refresh Notes list on successful composition - _Open for Discussion_
- Move to UNUserNotifications framework _UILocalNotification deprecated in iOS 10_
- Postpone asking for location permissions _Maybe give the user some context before requesting the same_
- Adding support for multiple users _Dependency: Manual authentication_
- Review the way we are fetching notes from Parse with respect to a beacon object _Can we get the list of notes in the beacon object request itself? Or should we cache and avoid searching the beacon object in parse?_
- Move `Model Mutation` to coordinator level. _Dependency: Loading UI implementation details_

### Security Issues:
~~- Move parse configuration keys out of the Repository.~~ -> _Fixed using Cocoapods-Keys_
