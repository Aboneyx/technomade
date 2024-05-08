import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/main/presentation/widgets/main_route_card.dart';

class MainDriverPage extends StatefulWidget {
  const MainDriverPage({super.key});

  @override
  State<MainDriverPage> createState() => _MainDriverPageState();
}

class _MainDriverPageState extends State<MainDriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Routes',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.ligthBlue,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemBuilder: (context, index) => const MainRouteCard(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: 4,
      ),
    );
  }
}
