import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';

class DriverBase extends StatefulWidget {
  const DriverBase({super.key});

  @override
  _PassangerBaseState createState() => _PassangerBaseState();
}

class _PassangerBaseState extends State<DriverBase> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: AppColors.static,
      routes: const [
        BaseMainDriverTab(),
        CreateRouteRoute(),
        ProfileRoute(),
      ],
      appBarBuilder: (context, tabsRouter) {
        if (tabsRouter.activeIndex == 0) {
          return AppBar(
            centerTitle: true,
            title: const Text(
              'My Routes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.ligthBlue,
          );
        } else if (tabsRouter.activeIndex == 1) {
          return AppBar(
            centerTitle: true,
            title: const Text(
              'Creating Route',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.ligthBlue,
          );
        } else {
          return AppBar(
            centerTitle: true,
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.ligthBlue,
          );
        }
      },
      bottomNavigationBuilder: (context, tabsRouter) => NavigationBar(
        selectedIndex: tabsRouter.activeIndex,
        onDestinationSelected: (value) {
          tabsRouter.setActiveIndex(value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline_outlined),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
