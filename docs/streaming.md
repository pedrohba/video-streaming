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

### Bitrate

- **Definition:**  
  Bitrate is the amount of data transmitted per second in a video or audio stream. It’s usually measured in **kilobits per second (kbps)** or **megabits per second (Mbps)**.

- **Example:**  
  A video streaming at 3000 kbps means 3,000 kilobits of video data are delivered per second.

- **Impact on Quality:**  
  - Higher bitrate = better quality (more detail, fewer compression artifacts)
  - But also = more bandwidth consumption

- **In Practice:**  
  Adaptive streaming adjusts bitrate dynamically to match user bandwidth (e.g., HLS, DASH).

### Resolution

- **Definition:**  
  The dimensions of the video in pixels — **width × height** (e.g., 1920×1080).

- **Common Resolutions:**
  - 480p: 854×480 (SD)
  - 720p: 1280×720 (HD)
  - 1080p: 1920×1080 (Full HD)
  - 4K: 3840×2160 (Ultra HD)

- **Impact on Quality:**  
  Higher resolution = clearer image, especially on larger screens — but also requires higher bitrate.

- **In Practice:**  
  Streaming platforms offer multiple resolutions and choose one based on the user’s device and network.

### Buffering

- **Definition:**  
  Buffering is the process of preloading video data before it's played to prevent interruptions.

- **Types:**
  - **Initial buffering**: Before playback begins
  - **Re-buffering**: Happens when the video pauses to load more data mid-playback

- **Impact on User Experience:**  
  - Buffering ensures smooth playback.
  - Too much = delays, poor experience.
  - Too little = frequent pauses, especially on unstable networks.

- **In Practice:**  
  Apps balance **buffer size vs. latency**: larger buffer = smoother, but slower to start or react.

### Latency

- **Definition:**  
  The time it takes for video data to travel from the source (server or encoder) to the viewer.

- **Measured in:** Seconds or milliseconds.

- **Types:**
  - **Playback Latency**: Delay between real-world event and playback
  - **Network Latency**: Time taken for data to travel across the network

- **Impact on Use Cases:**
  - **Live sports / events:** Need low latency (1–5s)
  - **Video calls:** Ultra-low latency (<1s)
  - **VOD (Netflix/YouTube):** Can tolerate higher latency (10–30s)

- **In Practice:**  
  Protocol choice (e.g., HLS vs. WebRTC) greatly affects latency.

### How They Work Together

| Concept     | Description                          | Affects                        | Trade-Offs                                |
|-------------|--------------------------------------|--------------------------------|-------------------------------------------|
| **Bitrate** | Data per second (kbps/Mbps)          | Quality & bandwidth            | High bitrate = better quality, more data  |
| **Resolution** | Size of video frame (pixels)      | Visual clarity & bitrate need  | Higher resolution = higher bitrate        |
| **Buffering** | Preloading data                    | Smoothness of playback         | Big buffer = smooth, but more delay       |
| **Latency** | Delay between send and receive       | Real-time interactivity        | Lower = better for live/real-time         |


--- 

## Adaptive Bitrate Streaming (ABR)

### What is ABR?

**Adaptive Bitrate Streaming (ABR)** is a streaming technique where the video quality **automatically adjusts** based on the viewer's **network conditions**, **device capabilities**, and **current bandwidth**.

Instead of delivering one single version of a video, the server provides **multiple renditions** of the same video at different **resolutions and bitrates**.

### How It Works

1. **Encoding**:  
   The source video is encoded into **multiple versions** (e.g., 240p @ 300kbps, 720p @ 2000kbps, 1080p @ 4000kbps).

2. **Segmenting**:  
   Each version is broken into **small chunks** (usually 2–10 seconds each).

3. **Manifest File**:  
   A **playlist or manifest file** (e.g., `.m3u8` for HLS or `.mpd` for DASH) lists all available streams and their chunks.

4. **Playback**:  
   The player downloads the manifest, picks a starting quality, and **monitors bandwidth and device performance** in real-time.

5. **Switching**:  
   As conditions change, the player **seamlessly switches** between quality levels — without interrupting playback.

### Protocols That Support ABR

- ✅ **HLS** (HTTP Live Streaming)  
- ✅ **MPEG-DASH**  
- ✅ **Microsoft Smooth Streaming**  
- ✅ **CMAF** (Common Media Application Format)  
- ❌ **RTMP** (No native ABR)

### Benefits of ABR

- **Smooth playback** with fewer buffering interruptions  
- **Optimized experience** across devices and networks  
- **Bandwidth efficiency**, especially on mobile or poor networks  
- **Global reach** with scalable delivery via CDNs

### Challenges

- Requires **transcoding** to multiple versions  
- **Storage** and **processing cost** increases  
- **Accurate bandwidth estimation** is crucial  
- Needs a **smart media player** to handle switching logic

### Example

Imagine a user watching a video:

- At home on Wi-Fi → gets 1080p @ 4000kbps  
- Moves to 4G network → player switches to 720p @ 2000kbps  
- Enters a low-signal area → switches to 480p @ 1000kbps

All this happens **automatically**, with **no manual intervention** and **no interruption** in playback.

---

## 🔧 Transcoding Explained

### What is Transcoding?

**Transcoding** is the process of converting a **source video** into multiple **formats**, **resolutions**, and **bitrates** to make it suitable for playback across different devices, platforms, and network conditions.

It’s a key part of **Adaptive Bitrate Streaming (ABR)**.

### How Transcoding Works

The process generally involves **three steps**:

#### 1. Decoding
- The original (often high-quality) video is **decoded** — i.e., decompressed to raw video/audio streams.
- This allows for further modification or re-encoding.

#### 2. Processing
- The raw stream may be:
  - **Resized** (e.g., 1080p → 720p)
  - **Compressed** to adjust bitrate
  - Enhanced or filtered (e.g., de-noising, adjusting frame rate)

#### 3. Encoding
- The processed video is **re-encoded** into different formats and bitrates.
- Typically encoded using codecs like **H.264**, **H.265**, or **VP9**.

### Example Output Renditions

| Resolution | Bitrate     | Codec   |
|------------|-------------|---------|
| 2160p (4K) | 8000 kbps   | H.264   |
| 1080p      | 4500 kbps   | H.264   |
| 720p       | 2500 kbps   | H.264   |
| 480p       | 1000 kbps   | H.264   |

These versions are used in **ABR** to deliver the right quality based on the viewer's network.

### Tools and Services for Transcoding

- **FFmpeg** – Open-source CLI tool (highly customizable)
- **Cloud Services:**
  - AWS Elastic Transcoder
  - AWS Elemental MediaConvert
  - Google Transcoder API
  - Azure Media Services
  - Cloudinary / Mux / BunnyStream

### Why It’s Resource-Intensive

- High **CPU/GPU** usage
- Significant **processing time**
- Increased **storage** (for each rendition)
- Network **bandwidth** (especially with cloud-based services)

This is why many platforms offload transcoding to the **cloud**.

### Transmuxing vs Transcoding

| Feature        | Transcoding                            | Transmuxing                             |
|----------------|----------------------------------------|------------------------------------------|
| What it does   | Converts video **codec, resolution, bitrate** | Changes **container format only** (e.g., `.mp4` → `.ts`) |
| Resource cost  | High                                   | Low                                      |
| Use case       | Adaptive streaming, optimization       | Streaming protocol compatibility         |

---

## 📦 Video Containers Overview

### What is a Video Container?

A **video container** is a file format that **packages** multiple multimedia components into a single file. It usually contains:

- 📹 Video stream(s)
- 🔊 Audio stream(s)
- 💬 Subtitles / Closed Captions
- 📝 Metadata (e.g., codec info, duration)

> The container does **not** dictate how the media is encoded — that's the job of the **codec**.

Think of it like a **zip file**:

- The container is the **zip**
- Inside: video, audio, subtitles, etc. (each may use different codecs)

### Popular Video Containers

| Format | File Extension | Common Use Cases | Notes |
|--------|----------------|------------------|-------|
| MP4    | `.mp4`         | Streaming, mobile, web | Most universal; supports H.264, H.265 |
| MKV    | `.mkv`         | Archiving, high-quality video | Highly flexible; supports many codecs |
| WebM   | `.webm`        | HTML5 video, modern browsers | Open-source; optimized for web |
| AVI    | `.avi`         | Legacy systems | Limited features; mostly outdated |
| MOV    | `.mov`         | Apple/QuickTime | High-quality; not as portable |
| FLV    | `.flv`         | Flash-based players | Legacy only; deprecated |
| TS     | `.ts`          | Streaming (HLS) | Segmentable; used for live/VOD delivery |


### Container vs Codec

| Element      | Role                        | Example       |
|--------------|-----------------------------|---------------|
| **Container** | Packages the streams        | MP4, MKV, MOV |
| **Codec**     | Compresses and decodes streams | H.264, VP9, AAC |

An `.mp4` file might contain **H.264 video** and **AAC audio**.

- Not all containers support all codecs.
- Compatibility varies by browser/device:
  - `.mp4` (H.264/AAC) → ✅ Universal support
  - `.mkv` (VP9/Opus) → ❌ May not work on Safari or iOS

### Transmuxing (Repackaging)

**Transmuxing** changes the container **without re-encoding** the streams.

Example using `ffmpeg`:
```bash
ffmpeg -i input.mkv -c copy output.mp4
```

- No quality loss
- Much faster than transcoding

---

## Video Codecs

### What is a Codec?

A **codec** (short for **co**der/**dec**oder) is a technology used to **compress** and **decompress** digital video (and audio) files.

- **Encoding**: Compresses raw video to reduce file size.  
- **Decoding**: Decompresses the video for playback.

Without codecs, video files would be **too large** to store or stream efficiently.

### How It Works

1. **Capture/Raw**: Camera records raw footage (huge size).  
2. **Encode**: Codec compresses the footage into a smaller file (e.g., H.264).  
3. **Store/Stream**: Compressed file is stored or delivered via network.  
4. **Decode**: Device/player decompresses for playback in real time.

---

### Popular Video Codecs

| Codec        | Efficiency         | Quality       | Compatibility                   | Use Cases                         |
|--------------|--------------------|---------------|---------------------------------|-----------------------------------|
| **H.264**    | ✅ High            | ✅ Good       | ✅ Universal                     | Streaming, mobile, web            |
| **H.265**    | 🔝 Higher          | 🔝 Better     | ⚠️ Less universal (patented)     | 4K/HDR video, modern devices      |
| **VP9**      | ✅ High            | ✅ Good       | ✅ Web (Chrome, Firefox; not Safari) | YouTube, WebM format            |
| **AV1**      | 🔝 Very high       | 🔝 Excellent  | 🔄 Growing (newer browsers/devices) | YouTube, Netflix, future-proof   |
| **MPEG-2**   | ⚠️ Low             | ⚠️ Medium     | ✅ Legacy                        | DVDs, broadcast TV                |
| **ProRes**   | ❌ Low (less compressed) | 🔝 High  | ❌ Niche (Apple-centric)         | Professional editing, Post-production |


Comparison Example (Same Quality Target)

| Codec   | Approx. File Size | Decode Speed    | Support                        |
|---------|-------------------|-----------------|-------------------------------|
| **H.264** | 100 MB          | Fast            | ✅ Everywhere                  |
| **H.265** | ~50 MB          | Medium          | ⚠️ Limited browser support     |
| **AV1**   | ~40 MB          | Slower          | 🚧 Emerging support            |

### Tools for Working with Codecs

- **FFmpeg** – CLI for converting, compressing, inspecting codecs  
- **HandBrake** – GUI tool for re-encoding videos  
- **MediaInfo** – Detailed codec/container metadata  
- **Shaka Packager** – Packaging video for ABR delivery

Choosing the Right Codec

- **Compatibility**: Will it play across your target devices/browsers?  
- **Bandwidth**: Lower bitrates for limited networks.  
- **Quality**: Maintain visual fidelity at target resolution.  
- **Encoding Time**: Faster vs. slower encode performance.  
- **Licensing**: Patent/royalty considerations (e.g., H.264/H.265).

---

## Audio Codecs

### What is an Audio Codec?

An **audio codec** is an algorithm that **compresses** and **decompresses** digital audio data:

- **Encoding**: Reduces raw audio size by removing or encoding data efficiently.  
- **Decoding**: Reconstructs the compressed audio for playback.

### How It Works

1. **Raw Audio**: Captured as uncompressed PCM (large file sizes).  
2. **Encode**: Codec applies **lossy** or **lossless** compression. **Lossy**: Discards some audio data for smaller files (e.g., MP3, AAC, Opus). **Lossless**: Preserves all audio data (e.g., FLAC, ALAC).
3. **Store/Stream**: Compressed file is delivered or stored.  
4. **Decode**: Player decompresses audio in real time for listening.

### Types of Audio Codecs

#### 1. Lossy Compression

| Codec         | Extension | Typical Use          | Quality    | Efficiency    |
|---------------|-----------|----------------------|------------|---------------|
| **MP3**       | `.mp3`    | Music, podcasts      | ✅ Good    | ✅ High       |
| **AAC**       | `.aac`    | Streaming, mobile    | ✅ Very Good | ✅ High     |
| **Ogg Vorbis**| `.ogg`    | Web, gaming          | ✅ Good    | ✅ High       |
| **Opus**      | `.opus`   | VoIP, low-latency    | 🔝 Excellent | 🔝 Very High |

#### 2. Lossless Compression

| Codec       | Extension | Typical Use         | Quality      | Efficiency    |
|-------------|-----------|---------------------|--------------|---------------|
| **FLAC**    | `.flac`   | Music archiving     | 🔝 Excellent | ✅ Medium     |
| **ALAC**    | `.m4a`    | Apple ecosystem     | 🔝 Excellent | ✅ Medium     |
| **WAV**     | `.wav`    | Editing, pro audio  | 🔝 Excellent | ⚠️ Low        |


### Popular in Streaming

| Codec    | Platforms              | Notes                            |
|----------|------------------------|----------------------------------|
| **AAC**  | YouTube, Spotify, Apple Music | Universal web & mobile support |
| **MP3**  | Podcasts, legacy audio | Very broad compatibility         |
| **Opus** | WhatsApp, Discord      | Optimized for low-latency comms  |

### Codec vs Container

| Element     | Role                              | Example             |
|-------------|-----------------------------------|---------------------|
| **Codec**   | Compresses/decompresses audio     | `AAC`, `MP3`, `Opus`|
| **Container** | Bundles audio, video, metadata  | `.m4a`, `.m4b`, `.wav` |

> An `.m4a` file can contain **AAC** (lossy) or **ALAC** (lossless).

### Tools for Working with Audio Codecs

- **FFmpeg** – CLI for converting & inspecting codecs  
- **Audacity** – GUI audio editing/encoding  
- **MediaInfo** – Detailed codec/container metadata  

Choosing the Right Audio Codec

- **Compatibility**: Supported by your target devices/browsers  
- **Bandwidth/Size**: Smaller files for constrained networks
- **Quality**: Lossless for archiving; good lossy for streaming  
- **Latency**: Opus for real-time communications  
- **Licensing**: Consider patent/royalty requirements  

