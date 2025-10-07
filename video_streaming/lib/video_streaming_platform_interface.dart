import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'video_streaming_method_channel.dart';

abstract class VideoStreamingPlatform extends PlatformInterface {
  /// Constructs a VideoStreamingPlatform.
  VideoStreamingPlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoStreamingPlatform _instance = MethodChannelVideoStreaming();

  /// The default instance of [VideoStreamingPlatform] to use.
  ///
  /// Defaults to [MethodChannelVideoStreaming].
  static VideoStreamingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VideoStreamingPlatform] when
  /// they register themselves.
  static set instance(VideoStreamingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
