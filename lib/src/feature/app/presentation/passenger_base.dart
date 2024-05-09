import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';

class PassengerBase extends StatefulWidget {
  const PassengerBase({super.key});

  @override
  _PassangerBaseState createState() => _PassangerBaseState();
}

class _PassangerBaseState extends State<PassengerBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // return AutoTabsScaffold(
      backgroundColor: AppColors.static,
    );
  }
}
