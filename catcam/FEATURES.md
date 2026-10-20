# CatCam Feature Plan

Benchmarked: AlfredCamera, Petcube, Furbo and Tapo.

## Core features to include
- Live view
- Continuous local rolling recording
- Playback/timeline
- Motion and sound events
- Notifications
- Two-way audio
- Low-light mode
- Digital zoom
- Snapshots and clips
- Detection zones and schedules
- Device/storage/network status
- App lock/private access
- Multi-camera-ready architecture

## Pet features
- Pet/cat/person event labels
- Meow/sound events
- Daily highlights
- Activity timeline
- Event thumbnails

## What CatCam deliberately avoids
- Mandatory cloud subscription
- Vendor account
- Cloud-only recording
- Ads
- Artificial feature gates

## Build order

### V1
1. Modern Android camera screen
2. Local live stream
3. Rolling recording
4. Timeline/playback
5. Local snapshots/clips
6. Storage management

### V1.5
1. Motion detection
2. Sound detection
3. Event timeline
4. Notifications
5. Low-light enhancement
6. Digital zoom

### V2
1. Private remote access via Tailscale
2. Two-way audio
3. iPhone notifications
4. Detection zones
5. Schedules
6. Camera health dashboard
7. PWA install experience

### V3
1. On-device cat/person detection
2. Meow classification
3. Daily activity summary
4. Smart event filtering
5. Multiple cameras

## UI
Dark-first, premium, quiet and modern. Live video is the primary surface. Controls are one-tap. Timeline uses event markers rather than a giant file list. No old-school CCTV control-panel look.
