import 'package:example/base_scaffold.dart';
import 'package:example/editor/editor_page.dart';
import 'package:example/examples/sheet/bouncing_overflow_sheet.dart';
import 'package:example/examples/sheet/bouncing_sheet.dart';
import 'package:example/examples/sheet/clamped_sheet.dart';
import 'package:example/examples/sheet/complex_snap_sheet.dart';
import 'package:example/examples/sheet/fit_resizable_sheet.dart';
import 'package:example/examples/sheet/fit_sheet.dart';
import 'package:example/examples/sheet/fit_sheet_snap.dart';
import 'package:example/examples/sheet/floating_sheet.dart';
import 'package:example/examples/sheet/fold_screen_sheet.dart';
import 'package:example/examples/sheet/resizable_sheet.dart';
import 'package:example/examples/sheet/scrollable_sheet.dart';
import 'package:example/examples/sheet/scrollable_snap_sheet.dart';
import 'package:example/examples/sheet/simple_sheet.dart';
import 'package:example/examples/sheet/snap_sheet.dart';
import 'package:example/examples/sheet/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SheetExamplesPage extends StatelessWidget {
  const SheetExamplesPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CupertinoNavigationBar(middle: Text('Sheets'), transitionBetweenRoutes: false),
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      primary: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SectionTitle('SIZING'),
          ExampleTile.sheet('Expanded sheet', const SimpleSheet()),
          ExampleTile.sheet('Fit sheet', const FitSheet()),
          ExampleTile.sheet('Resizable sheet', const ResizableSheet()),
          const SectionTitle('DRAG PHYSICS'),
          ExampleTile.sheet('Snap', const SnapSheet()),
          ExampleTile.sheet('Bouncing', const BounceTopSheet()),
          ExampleTile.sheet('Bouncing overflow', const BounceOverflowSheet()),
          ExampleTile.sheet('Clamped sheet (min and max extent)', const ClampedSheet()),
          const SectionTitle('SCROLLING'),
          ExampleTile.sheet('Scrollabe sheet', const ScrollableSheet()),
          ExampleTile.sheet('Scrollabe snap sheet', const ScrollableSnapSheet()),
          const SectionTitle('Others'),
          ExampleTile.sheet('Floating sheet', const FloatingSheet()),
          ExampleTile.sheet('Fit and Snap sheet', const FitSnapSheet()),
          ExampleTile.sheet('Fit, Resizable and Bouncing sheet', const FitResizableSheet()),
          ExampleTile.sheet('Textfield sheet', const TextFieldSheet()),
          ExampleTile.sheet('Foldable screen', const FoldableScreenFloatingSheet()),
          const ExampleTile(title: 'Customizable sheet', page: SheetConfigurationPage()),
          const SectionTitle('SHOWCASE'),
          const ExampleTile(leading: Icon(Icons.map), title: 'Map BottomSheet Example', page: AdvancedSnapSheetPage()),
          const SizedBox(height: 60),
        ].addItemInBetween(const Divider(height: 1)),
      ),
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(title, style: Theme.of(context).textTheme.bodySmall),
  );
}

extension ListUtils<T> on List<T> {
  List<T> addItemInBetween(T item) =>
      length <= 1 ? this : sublist(1).fold(<T>[first], (List<T> r, T element) => <T>[...r, item, element]);
}
