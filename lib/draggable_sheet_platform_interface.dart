import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'draggable_sheet_method_channel.dart';

abstract class DraggableSheetPlatform extends PlatformInterface {
  /// Constructs a DraggableSheetPlatform.
  DraggableSheetPlatform() : super(token: _token);

  static final Object _token = Object();

  static DraggableSheetPlatform _instance = MethodChannelDraggableSheet();

  /// The default instance of [DraggableSheetPlatform] to use.
  ///
  /// Defaults to [MethodChannelDraggableSheet].
  static DraggableSheetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DraggableSheetPlatform] when
  /// they register themselves.
  static set instance(DraggableSheetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
