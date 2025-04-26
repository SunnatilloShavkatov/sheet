import 'package:flutter/material.dart';

import 'package:sheet/sheet.dart';

class TextFieldSheet extends StatefulWidget {
  const TextFieldSheet({super.key});

  @override
  State<TextFieldSheet> createState() => _TextFieldSheetState();
}

class _TextFieldSheetState extends State<TextFieldSheet> with TickerProviderStateMixin {
  late SheetController controller = SheetController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Sheet(
    minExtent: 100,
    physics: const SnapSheetPhysics(stops: <double>[0.4, 1]),
    initialExtent: 500,
    controller: controller,
    child: DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Inside AppBar'), automaticallyImplyLeading: false),
        body: const SingleChildScrollView(
          primary: true,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 400),
              TextField(scrollPadding: EdgeInsets.all(200)),
              SizedBox(height: 400),
            ],
          ),
        ),
      ),
    ),
  );
}
