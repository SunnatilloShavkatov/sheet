import 'package:flutter/material.dart';
import 'package:sheet/sheet.dart';

class SimpleSheet extends StatelessWidget {
  const SimpleSheet({super.key});

  @override
  Widget build(BuildContext context) => Sheet(
    elevation: 12,
    initialExtent: 200,
    child: Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 20),
          Text('Title', style: Theme.of(context).textTheme.displaySmall),
          Text('Subtitle', style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    ),
  );
}
