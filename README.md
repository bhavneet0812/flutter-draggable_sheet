
# Draggable Sheet

`Draggable Sheet` is a Flutter package that enables developers to implement a customizable, interactive bottom sheet with a dynamic height adjustment and an elegant item display. It extends typical draggable sheet functionalities with more sophisticated control over its behaviour, providing richer user interaction.

# <img src="https://github.com/bhavneet0812/flutter-draggable_sheet/blob/main/assets/DraggableSheet.gif" width="300px" />

## Features

- **Dynamic Height Adjustment**: Adjust the bottom sheet height based on content or predefined limits.
- **Item Interaction**: Tap items to interact or select, with the sheet responding to the context.
- **Custom Animation and Snapping**: Smooth animations and optional snapping at different heights.
- **Responsive Design**: Adapts to different screen sizes and orientations.

## Installation

To add `Draggable Sheet` to your Flutter project, edit your `pubspec.yaml` file:

```yaml
dependencies:
  draggable_sheet: ^1.0.1+1
```

Then, import the package in your Dart code:

```dart
import 'package:draggable_sheet/draggable_sheet.dart';
```

## Usage

This package provides a `DraggableSheet` widget that can be included in your Flutter app. Below is a simple example of how to integrate it into your app:

```dart
import 'package:flutter/material.dart';
import 'package:draggable_sheet/draggable_sheet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DraggableSheet(
          minHeight: 0.1,
          maxHeight: 0.8,
          itemHeight: 50,
          list: [
            (Widget: Text('Item 1'), index: 0),
            (Widget: Text('Item 2'), index: 1),
          ],
          didSelectItem: (index) {
            print('Selected item $index');
          },
        ),
      ),
    );
  }
}
```

### Configuration

- `minHeight`: The minimum fraction of the screen height that the draggable sheet can occupy.
- `maxHeight`: The maximum fraction of the screen height that the draggable sheet can occupy.
- `itemHeight`: The height of each item in the draggable sheet.
- `list`: A list of tuples, each containing a `Widget` and its corresponding index.
- `didSelectItem`: A callback function that is called when an item is selected.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

This documentation includes basic sections that describe the package's functionality, how to get it set up, and how to start using it in a project. Adjustments may be necessary based on additional functionality or configurations in your package.
