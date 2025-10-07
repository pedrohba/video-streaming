import 'package:flutter_test/flutter_test.dart';
import 'package:video_streaming/video_streaming.dart';
import 'package:video_streaming/video_streaming_platform_interface.dart';
import 'package:video_streaming/video_streaming_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVideoStreamingPlatform
    with MockPlatformInterfaceMixin
    implements VideoStreamingPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VideoStreamingPlatform initialPlatform = VideoStreamingPlatform.instance;

  test('$MethodChannelVideoStreaming is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVideoStreaming>());
  });

  test('getPlatformVersion', () async {
    VideoStreaming videoStreamingPlugin = VideoStreaming();
    MockVideoStreamingPlatform fakePlatform = MockVideoStreamingPlatform();
    VideoStreamingPlatform.instance = fakePlatform;

    expect(await videoStreamingPlugin.getPlatformVersion(), '42');
  });
}
