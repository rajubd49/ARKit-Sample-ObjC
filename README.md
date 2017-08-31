# ARKit-Sample-ObjC
ARKit sample application written in Objective C with features of Add, Remove, Scale, Move single and multiple objects with plane detection, reset session and support checking.

![](http://oi68.tinypic.com/wh1ff7.jpg)

![](https://media.giphy.com/media/3ov9jU9vIOHvTWqsCI/giphy.gif)

## Features

* Plane detection
* Add single and multiple objects
* Remove single and multiple objects
* Scale/Zoom objects
* Move objects
* Reset session
* World tracking support checking

## User Control

* Plane can be detect with enough light and bare minimum time to hold on a surface.
* Object can be add using Tap gesture. Object will be added on the position where using tap but must must be after detecting plane.
* Object can be remove using Long Press gesture for 0.5 second.
* Object can be scale/zoom using Pinch gesture.
* Object can be move using Pan gesture. Though this feature is not perfect yet.
* Object can be change using the bottom plus and selecting specific object.
* Reset session can be done using top right reset button.

## Requirements

* Xcode 9.0 Beta 3
* iOS 11 Beta 3
* Device with A9 or better chip for ARWorldTrackingSessionConfiguration

> Note: The app automatically detects if your device supports the ARWorldTrackingSessionConfiguration. If not, it will use the less immersive ARSessionConfiguration, which is to be supported by all devices. However, at the current time (Beta 3), ARSessionConfiguration is also only supported by devices with an A9 or better chip. **This means you need an iPhone 6S or better to use ARKit at the current time.**

## Communication

- If you **found a bug**, open an issue after checking the [FAQ](#faq).
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Download

Simply navigate to your directory of interest, then clone.

```bash
$ git clone https://github.com/rajubd49/ARKit-Sample-ObjC.git
```

Finally, open the `*.xcodeproj` file and build to your [supported device](#requirements)

## FAQ

### I am getting the ARSessionConfiguration and ARWorldTrackingSessionConfiguration error:

`ARSessionConfiguration renamed to ARConfiguration and ARWorldTrackingSessionConfiguration renamed to ARWorldTrackingConfiguration in iOS 11 beta 5`

---

## Thanks

Special thanks to

* [Mark Dawson](https://github.com/markdaws)

## License

ARShooter is released under the MIT License. [See LICENSE](https://github.com/rajubd49/ARKit-Sample-ObjC/blob/master/LICENSE) for details.
