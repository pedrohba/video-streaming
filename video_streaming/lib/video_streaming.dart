
import 'video_streaming_platform_interface.dart';

class VideoStreaming {
  Future<String?> getPlatformVersion() {
    return VideoStreamingPlatform.instance.getPlatformVersion();
  }
}
