import 'dart:math';

import 'package:draggable_sheet/draggable_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:draggable_sheet/draggable_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var list = List.generate(10, (index) {
    return (
      Colors.primaries[Random().nextInt(Colors.primaries.length)]
          .withOpacity(1),
      index,
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100 + kBottomNavigationBarHeight,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 100,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Padding(
                            padding: EdgeInsets.all(0),
                            child: Text("Enter the number of cards"),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            // height: 0,
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.start,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (value) {
                          final intValue = int.tryParse(value) ?? 1;
                          setState(() {
                            list = List.generate(intValue, (index) {
                              return (
                                Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)]
                                    .withOpacity(1),
                                index
                              );
                            });
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: () {
              final mediaQuery = MediaQuery.of(context);
              final height = mediaQuery.size.height;
              return DraggableSheet(
                minHeight:
                    (kBottomNavigationBarHeight * 2 + (0.25 * height)) / height,
                maxHeight: 1,
                itemHeight: 0.25 * height,
                list: List.generate(list.length, (index) {
                  return (
                    HomeProfileItemView(
                      index: index,
                      itemHeight: 0.25 * height,
                      item: list[index],
                    ),
                    index
                  );
                }),
                didSelectItem: (index) {
                  var tempList = List<(Color, int)>.from(list);
                  final tempSelectedItem = tempList[index];
                  tempList.removeAt(index);
                  tempList.insert(tempList.length, tempSelectedItem);
                  setState(() {
                    list = tempList;
                  });
                },
              );
            }(),
          ),
        ],
      ),
    );
  }
}

class HomeProfileItemView extends StatefulWidget {
  const HomeProfileItemView({
    super.key,
    required this.index,
    required this.itemHeight,
    required this.item,
    this.onTap,
  });

  final int index;
  final double itemHeight;
  final (Color, int) item;
  final void Function()? onTap;

  @override
  State<HomeProfileItemView> createState() => _HomeProfileItemViewState();
}

class _HomeProfileItemViewState extends State<HomeProfileItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: widget.itemHeight,
          child: Container(
            decoration: BoxDecoration(
              color: widget.item.$1,
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.item.$2.toString(),
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
