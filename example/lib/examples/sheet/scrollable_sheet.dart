import 'package:flutter/material.dart';
import 'package:sheet/sheet.dart';

class ScrollableSheet extends StatelessWidget {
  const ScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) => DefaultSheetController(
    child: Sheet(
      physics: const BouncingSheetPhysics(overflowViewport: true),
      initialExtent: 500,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12, blurRadius: 12)],
        ),
        child: Scaffold(
          appBar: AppBar(title: const Text('Inside AppBar'), automaticallyImplyLeading: false),
          body: ListView(
            shrinkWrap: true,
            primary: true,
            physics: const BouncingScrollPhysics(),
            children:
                ListTile.divideTiles(
                  context: context,
                  tiles: List<Widget>.generate(100, (int index) {
                    if (index == 0) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Text('Location', style: Theme.of(context).textTheme.titleLarge),
                      );
                    }
                    return ListTile(title: Text('Item $index'));
                  }),
                ).toList(),
          ),
        ),
      ),
    ),
  );
}
