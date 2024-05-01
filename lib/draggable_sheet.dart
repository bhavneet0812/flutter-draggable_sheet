// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

class DraggableSheet extends StatefulWidget {
  const DraggableSheet({
    super.key,
    required this.minHeight,
    required this.maxHeight,
    required this.itemHeight,
    required this.list,
    required this.didSelectItem,
  });

  final double minHeight;
  final double maxHeight;
  final double itemHeight;
  final List<(Widget widget, int index)> list;
  final void Function(int index) didSelectItem;
  @override
  State<DraggableSheet> createState() => DraggableSheetState();
}

class DraggableSheetState extends State<DraggableSheet> {
  final draggableScrollController = DraggableScrollableController();
  ScrollController? scrollController;
  late final minHeight = widget.minHeight;
  late final dragOffset = minHeight.obs;
  late final maxHeight = widget.maxHeight;

  late final itemHeight = widget.itemHeight;

  List<(Widget, int)> get list => widget.list;
  int get len => list.length;

  double get offset => dragOffset.value;
  double get percent => (offset - minHeight) / (maxHeight - minHeight);
  bool get isOpened => percent > 0.1;
  double get scrollableHeight => (itemHeight * len) + (len * 10);

  @override
  void initState() {
    draggableScrollController.addListener(() {
      percent.printInfo();
      dragOffset.value = draggableScrollController.size;
    });

    super.initState();
  }

  /// Get Transition Value
  double _getValue(num min, num max, double percent) {
    final diff = max - min;
    final increaseValue = diff * percent;
    return min + increaseValue;
  }

  /// Total Height
  double? get totalHeight {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    return scrollableHeight < height
        ? _getValue(minHeight * height, height, percent)
        : null;
  }

  /// Bottom Padding
  double bottomPadding(int i) {
    return _getValue(
      max(140 - ((len - i) * 20), 80),
      (itemHeight * i) + (10 * i),
      percent,
    );
  }

  /// Side Padding
  double sidePadding(int i) {
    return _getValue(0 + ((len - i) * 20), 20, percent);
  }

  /// Vertical Padding
  double get verticalPadding {
    return _getValue(0, kBottomNavigationBarHeight, percent);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: false,
      flipY: true,
      child: DraggableScrollableSheet(
        controller: draggableScrollController,
        maxChildSize: 1,
        minChildSize: minHeight,
        initialChildSize: minHeight,
        snap: true,
        snapSizes: [minHeight, 1],
        builder: (context, scrollController) {
          this.scrollController = scrollController;
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Obx(() {
                  return SizedBox(
                    height: totalHeight,
                    child: Container(
                      color: Colors.transparent,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: _getValue(0, 4, percent),
                          sigmaY: _getValue(0, 4, percent),
                        ),
                        child: Container(
                          height: totalHeight,
                          padding: EdgeInsets.symmetric(
                            vertical: verticalPadding,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: _getValue(
                                minHeight * MediaQuery.of(context).size.height,
                                scrollableHeight,
                                percent,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: List.generate(len, (i) {
                                  return Obx(() {
                                    return Positioned(
                                      bottom: bottomPadding(i),
                                      left: sidePadding(i),
                                      right: sidePadding(i),
                                      height: itemHeight,
                                      child: _buildFlipCard(i),
                                    );
                                  });
                                }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Build Flip Card
  Widget _buildFlipCard(int i) {
    return Transform.flip(
      flipY: true,
      child: GestureDetector(
        onTap: (isOpened || (i < len - 1))
            ? () async {
                await scrollController?.animateTo(
                  0,
                  duration: 300.milliseconds,
                  curve: Curves.ease,
                );
                draggableScrollController.animateTo(
                  minHeight,
                  duration: 300.milliseconds,
                  curve: Curves.ease,
                );
                widget.didSelectItem(i);
              }
            : null,
        child: ClipRRect(
          child: widget.list[i].$1,
        ),
      ),
    );
  }
}
