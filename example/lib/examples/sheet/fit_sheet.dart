import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sheet/sheet.dart';

class FitSheet extends StatelessWidget {
  const FitSheet({super.key});

  @override
  Widget build(BuildContext context) => DefaultSheetController(
    onCreated: (controller) async {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      unawaited(controller.relativeAnimateTo(1, duration: const Duration(milliseconds: 400), curve: Curves.easeOut));
    },
    child: const Sheet(elevation: 4, child: SizedBox(height: 400, child: Text('hello'))),
  );
}
