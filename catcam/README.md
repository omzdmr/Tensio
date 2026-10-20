# CatCam

Personal pet camera prototype for the Redmi Note 10 Pro.

## V1 target

- Android phone acts as the camera.
- CameraX captures the rear camera.
- A tiny local HTTP server exposes an MJPEG stream.
- Any device on the same Wi-Fi can open the stream in Safari/Chrome.
- No cloud storage and no account.
- Later: recording timeline, motion detection, Tailscale remote access, and two-way audio.

## Current phase

V1 is deliberately local-first. Remote access is added only after the local camera is stable.

Open `catcam/android-camera` in Android Studio and install it on the Redmi Note 10 Pro. Grant camera permission, start the camera, and note the phone's local IP address. From the iPhone on the same Wi-Fi, open `http://PHONE_IP:8080/`.
