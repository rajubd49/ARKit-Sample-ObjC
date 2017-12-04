# ARKit-Sample-ObjC
ARKit sample application is written in Objective C with features of Add, Remove, Scale, Move, Shapshot for single and multiple objects with plane/surface detection, reset session and AR support checking.

![Shapshot](https://preview.ibb.co/iUVoUb/IMG_0080.jpg)

![GIF 1](![F1TdlB](https://i.makeagif.com/media/12-04-2017/F1TdlB.gif))

![GIF 2](![nIe9jw](https://i.makeagif.com/media/12-04-2017/nIe9jw.gif))

## Features

* Plane/Surface detection
* Add single and multiple objects
* Remove single and multiple objects
* Scale/Zoom objects
* Move objects
* Take shapshot
* Reset session
* World tracking support checking

## User Control

* Plane can be detect with enough light and bare minimum time to hold on a surface.
* Object can be add using Tap gesture. Object will be added on the position where using tap but must be after detecting plane.
* Object can be remove using tapping an object on scene if any and use remove button.
* Object can be scale/zoom using Pinch gesture.
* Object can be move using Pan gesture. Though this feature is not perfect yet.
* Object can be change using the bottom plus and selecting specific object.
* Object can take shapshot of the scene view using capture button.
* Reset session can be done using top right reset button.

## Requirements

* Xcode 9.0
* iOS 11
* Device with A9 or better chip for ARWorldTrackingSessionConfiguration

> Note: The app automatically detects if your device supports the ARWorldTrackingSessionConfiguration. If not, it will use the less immersive ARSessionConfiguration, which is to be supported by all devices. However, at the current time (Beta 3), ARSessionConfiguration is also only supported by devices with an A9 or better chip. **This means you need an iPhone 6S or better to use ARKit at the current time.**

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Download

Simply navigate to your directory of interest, then clone.

```bash
$ git clone https://github.com/rajubd49/ARKit-Sample-ObjC.git
```

Finally, open the `*.xcodeproj` file and build to your [supported device](#requirements)

## Thanks

Special thanks to

* [Mark Dawson](https://github.com/markdaws)

## License

ARKit-Sample-ObjC is released under the MIT License. [See LICENSE](https://github.com/rajubd49/ARKit-Sample-ObjC/blob/master/LICENSE) for details.
