import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'draggable_sheet_platform_interface.dart';

/// An implementation of [DraggableSheetPlatform] that uses method channels.
class MethodChannelDraggableSheet extends DraggableSheetPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('draggable_sheet');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
