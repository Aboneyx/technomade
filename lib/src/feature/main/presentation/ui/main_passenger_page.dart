import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/main/presentation/widgets/main_route_card.dart';

@RoutePage()
class MainPassengerPage extends StatefulWidget {
  const MainPassengerPage({super.key});

  @override
  State<MainPassengerPage> createState() => _MainPassengerPageState();
}

class _MainPassengerPageState extends State<MainPassengerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tickets',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.ligthBlue,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemBuilder: (context, index) => const MainRouteCard(
          isPassenger: true,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: 4,
      ),
    );
  }
}
