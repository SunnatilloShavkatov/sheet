import 'package:flutter/material.dart';

import 'package:sheet/sheet.dart';

class BounceOverflowSheet extends StatelessWidget {
  const BounceOverflowSheet({super.key});

  @override
  Widget build(BuildContext context) => Sheet(
    physics: const BouncingSheetPhysics(),
    minExtent: 100,
    child: Scaffold(appBar: AppBar(title: const Text('Example'))),
  );
}
