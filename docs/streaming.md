# Video Streaming Fundamentals

## Difference between Prossive Download vs Streaming

### Progressive Download

**How it works:**  
A video file is downloaded from a server to the user’s device progressively—starting to play as soon as enough data is buffered.

**Key Characteristics:**
- The video file is stored temporarily (or permanently) on the user’s device.
- Playback starts after a portion is downloaded.
- Users can seek to already downloaded parts but not to future parts until they're downloaded.

**Pros:**
- Simple to implement (just like downloading a file and playing it).
- No special server or protocol needed—can be served via regular web servers.

**Cons:**
- No adaptive quality (same resolution throughout).
- Not optimized for varying bandwidth conditions.
- Can result in buffering if the connection is slow.
- Difficult to protect content (can be downloaded easily).

**Example:**  
A user clicks a video link, and their browser/media player starts downloading the `.mp4` file and begins playing it once enough of it is buffered.


### Streaming (True Streaming)

**How it works:**  
Video is sent in small chunks over time, and playback happens almost instantly as data is received, without downloading the full file.

**Key Characteristics:**
- No full file is stored on the user's device.
- Uses specialized protocols like **HLS (HTTP Live Streaming)**, **DASH (Dynamic Adaptive Streaming over HTTP)**, or **RTMP**.
- Often includes **adaptive bitrate streaming (ABR)**.

**Pros:**
- Smooth playback with adaptive quality (based on network conditions).
- Lower storage usage on the client side.
- Easier to apply content protection (DRM, tokenized access, encryption).
- Better suited for live streaming.

**Cons:**
- Slightly higher setup complexity (requires segmenting, manifest files, CDN/CDN-like delivery).
- Requires a media server or video platform to prepare the stream (e.g., Mux, AWS MediaConvert).

**Example:**  
Netflix, YouTube, and Twitch all use streaming. If your connection drops, the video automatically drops resolution without stopping playback.


### Quick Comparison Table

| Feature                     | Progressive Download | Streaming (HLS/DASH)     |
|-----------------------------|----------------------|---------------------------|
| File Downloaded?           | Yes (partially/full) | No (chunked delivery)     |
| Requires Special Protocols? | No                   | Yes (HLS, DASH, RTMP)     |
| Adaptive Quality            | ❌                   | ✅                         |
| Buffering Control           | ❌                   | ✅                         |
| Live Streaming Capable      | ❌                   | ✅                         |
| Easy to Implement           | ✅                   | ⚠️ Slightly more complex   |
| Better for Large Audiences  | ❌                   | ✅                         |

---

## Streaming protocols (HLS/DASH/RTMP/WebRTC)

Streaming protocols define **how video data is transmitted** from a server to a viewer’s device in real-time or near real-time. They handle splitting video files into chunks, managing delivery speed, buffering, and adapting to network changes.


### 1. HLS (HTTP Live Streaming)

- **Developed by:** Apple  
- **How it works:** Breaks video into small `.ts` chunks and uses a `.m3u8` manifest file to list available segments.  
- **Adaptive Bitrate:** ✅ Yes  
- **Supported on:** All Apple devices, modern browsers, Android, smart TVs  
- **Latency:** Medium (5–30 seconds)  
- **Use cases:** VOD (video on demand), live streaming, mobile streaming

**Pros:**
- Widely supported
- Works over standard HTTP/CDNs
- Supports encryption & DRM

**Cons:**
- Higher latency for live streams (unless using Low-Latency HLS)


### 2. MPEG-DASH (Dynamic Adaptive Streaming over HTTP)

- **Developed by:** MPEG (open standard)  
- **How it works:** Similar to HLS, but uses `.mp4` chunks and a `.mpd` manifest file.  
- **Adaptive Bitrate:** ✅ Yes  
- **Supported on:** Most modern browsers (but not natively on Safari/iOS)  
- **Latency:** Medium  
- **Use cases:** High-quality streaming on non-Apple platforms

**Pros:**
- Open and codec-agnostic
- Advanced features (e.g. multiple audio tracks, captions)

**Cons:**
- Not natively supported on iOS/Safari
- Setup is more complex than HLS


### 3. RTMP (Real-Time Messaging Protocol)

- **Developed by:** Adobe  
- **How it works:** Low-latency protocol using a persistent TCP connection to transmit audio/video data.  
- **Adaptive Bitrate:** ❌ No  
- **Supported on:** OBS, encoders, older Flash-based systems  
- **Latency:** Low (2–5 seconds)  
- **Use cases:** Live video ingest (e.g. sending streams to YouTube Live, Twitch)

**Pros:**
- Very low latency
- Reliable for live stream ingestion

**Cons:**
- Requires a media server
- Deprecated in modern playback (no native browser support)


### 4. WebRTC (Web Real-Time Communication)

- **Developed by:** Google + W3C  
- **How it works:** Peer-to-peer protocol for real-time communication  
- **Adaptive Bitrate:** ✅ Yes  
- **Supported on:** Most modern browsers  
- **Latency:** Ultra-low (sub-second)  
- **Use cases:** Video calls, conferencing, real-time apps (telemedicine, customer support)

**Pros:**
- Ultra-low latency
- Peer-to-peer direct connection
- Built into browsers

**Cons:**
- Harder to scale (peer-to-peer → not CDN-friendly)
- Complex to implement for large audiences


### Comparison Table

| Protocol   | Latency       | Adaptive Bitrate | Use Case                   | Notes                                 |
|------------|---------------|------------------|-----------------------------|----------------------------------------|
| **HLS**    | Medium (5–30s)| ✅ Yes            | VOD, Live                   | Best compatibility, especially on iOS |
| **DASH**   | Medium        | ✅ Yes            | VOD, Live                   | Open standard, not iOS native          |
| **RTMP**   | Low (2–5s)    | ❌ No             | Live stream ingestion       | Still used to send live to platforms   |
| **WebRTC** | Ultra-low     | ✅ Yes            | Video calls, real-time apps | Peer-to-peer, not for large audiences  |

---

## Concepts: Bitrate, Resolution, Buffering, Latency
## Adaptive Bitrate Streaming (ABR)