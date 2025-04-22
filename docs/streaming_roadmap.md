# Video Streaming Fundamentals

# 🎥 1-Week Video Streaming Study Roadmap for Flutter

**Goal:**  
Understand the fundamentals of video streaming and apply them to build a Flutter video streaming app template.

---

## ✅ Overview

| Day | Focus | Topics |
|-----|-------|--------|
| 1 | Fundamentals | Streaming vs Download, HLS, DASH, ABR |
| 2 | Codecs & Formats | MP4, H.264, H.265, AAC, VP9 |
| 3 | Hosting & Delivery | CDNs, Firebase, Mux, AWS |
| 4 | Flutter Frontend | video_player, chewie, buffering |
| 5 | Backend Options | Firebase, Mux API, RTMP |
| 6 | Security & Monetization | Token access, encryption, DRM basics |
| 7 | Mini Project | Build a streaming Flutter app |

---

## 📅 Day-by-Day Plan

### 🟢 Day 1: Fundamentals of Video Streaming

**Topics to Learn:**
- Streaming vs Progressive Download
- Streaming protocols: HLS, DASH, RTMP
- Bitrate, Resolution, Latency, Buffering
- Adaptive Bitrate Streaming (ABR)

**Resources:**
- [Video Streaming Fundamentals – Mux](https://www.mux.com/learn/video-streaming)
- [HLS vs DASH – Wowza Blog](https://www.wowza.com/blog/hls-vs-dash)
- [YouTube: How Streaming Works (3 min)](https://www.youtube.com/watch?v=fj7rxsOCo4A)

---

### 🟡 Day 2: Video File Formats & Codecs

**Topics to Learn:**
- Video Containers: MP4, MKV, MOV
- Video Codecs: H.264, H.265, VP9, AV1
- Audio Codecs: AAC, Opus

**Resources:**
- [Streaming Media: Codecs & Containers Guide](https://www.streamingmedia.com/Articles/ReadArticle.aspx?ArticleID=128945)
- [YouTube: Video Compression Explained](https://www.youtube.com/watch?v=tT9Eh8wNMkw)

---

### 🟠 Day 3: Hosting and Delivery

**Topics to Learn:**
- Hosting Options (Firebase, S3, Cloudflare)
- Transcoding
- Using Mux, AWS MediaConvert, Firebase HLS

**Resources:**
- [Mux Docs](https://docs.mux.com/)
- [Firebase HLS Streaming Guide](https://dev.to/melvin2016/streaming-videos-in-flutter-using-firebase-and-hls-4be9)

---

### 🔵 Day 4: Frontend in Flutter

**Topics to Learn:**
- Flutter `video_player` package
- Custom UI with `chewie`
- Buffering, full-screen toggle, network video playback

**Resources:**
- [video_player Flutter Package](https://pub.dev/packages/video_player)
- [chewie Flutter Package](https://pub.dev/packages/chewie)
- [Medium: Flutter + HLS](https://medium.flutterdevs.com/flutter-video-player-using-hls-c8f24f7f41d7)

---

### 🟣 Day 5: Backend or No-Backend Options

**Topics to Learn:**
- Firebase Storage + HLS
- Mux API for upload & playback
- Self-hosted: nginx + RTMP + ffmpeg

**Resources:**
- [Mux Video Upload Guide](https://docs.mux.com/guides/video/upload-files)
- [YouTube: Firebase + HLS Setup](https://www.youtube.com/watch?v=ROqqgM1uU1k)

---

### 🟤 Day 6: Security & Monetization Basics

**Topics to Learn:**
- Token-based video access
- HLS Encryption basics
- DRM (Widevine, FairPlay) – surface level
- Monetization Models

**Resources:**
- [Mux Playback Authorization](https://docs.mux.com/guides/video/configure-playback-authorization)
- [HLS Encryption 101 – Streamroot Blog](https://blog.streamroot.io/hls-encryption-video-delivery/)

---

### ⚪ Day 7: Practice – Build a Mini App

**What to Build:**
- Flutter app with a video player using HLS
- Add:
  - Fullscreen toggle
  - Custom controls (`chewie`)
  - Error handling

**Optional:** Stream your own video from Firebase or Mux

---

## 🔍 Optional Deep Dive Topics (Post-Week)

- DRM: Widevine, FairPlay, PlayReady
- Live streaming architecture
- Video analytics (Mux Data, Firebase Analytics)

---