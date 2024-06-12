import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';

class PassengerBase extends StatefulWidget {
  const PassengerBase({super.key});

  @override
  _PassangerBaseState createState() => _PassangerBaseState();
}

class _PassangerBaseState extends State<PassengerBase> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: AppColors.static,
      routes: const [
        BaseMainPassengerTab(),
        SearchPassengerRoute(),
        ProfileRoute(),
      ],
      appBarBuilder: (context, tabsRouter) {
        if (tabsRouter.activeIndex == 0) {
          return AppBar(
            centerTitle: true,
            title: const Text(
              'My Tickets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.ligthBlue,
          );
        } else if (tabsRouter.activeIndex == 1) {
          return AppBar(
            centerTitle: true,
            title: const Text(
              'Find ticket',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.ligthBlue,
          );
        } else {
          return AppBar(
            centerTitle: true,
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
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
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(Assets.icons.ticket),
            selectedIcon: SvgPicture.asset(Assets.icons.ticket),
            label: 'Tickets',
          ),
          const NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
