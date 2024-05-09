import 'package:flutter/material.dart';

class StartScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;

  const StartScaffold(
      {super.key, required this.child, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          actions: actions,
        ),
        body: SafeArea(child: Center(child: child)));
  }
}
