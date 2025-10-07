import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_streaming_platform_interface.dart';

/// An implementation of [VideoStreamingPlatform] that uses method channels.
class MethodChannelVideoStreaming extends VideoStreamingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('video_streaming');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
