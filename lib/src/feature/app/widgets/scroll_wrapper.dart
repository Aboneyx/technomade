import 'package:flutter/material.dart';

class ScrollWrapper extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  const ScrollWrapper({
    super.key,
    required this.child,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
