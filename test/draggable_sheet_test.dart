import 'package:flutter_test/flutter_test.dart';
import 'package:draggable_sheet/draggable_sheet.dart';
import 'package:draggable_sheet/draggable_sheet_platform_interface.dart';
import 'package:draggable_sheet/draggable_sheet_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDraggableSheetPlatform
    with MockPlatformInterfaceMixin
    implements DraggableSheetPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DraggableSheetPlatform initialPlatform = DraggableSheetPlatform.instance;

  test('$MethodChannelDraggableSheet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDraggableSheet>());
  });

  test('getPlatformVersion', () async {
    DraggableSheet draggableSheetPlugin = DraggableSheet();
    MockDraggableSheetPlatform fakePlatform = MockDraggableSheetPlatform();
    DraggableSheetPlatform.instance = fakePlatform;

    expect(await draggableSheetPlugin.getPlatformVersion(), '42');
  });
}
