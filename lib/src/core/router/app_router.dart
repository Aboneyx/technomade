import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/feature/app/presentation/launcher.dart';
import 'package:technomade/src/feature/auth/presentation/auth_presentation.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LauncherRoute.page,
          initial: true,
          children: [
            /// Passenger Routes
            AutoRoute(
              page: BaseMainPassengerTab.page,
              children: [
                AutoRoute(
                  page: MainPassengerRoute.page,
                  initial: true,
                ),
              ],
            ),
            AutoRoute(page: SearchPassengerRoute.page),

            /// Driver Routes
            AutoRoute(
              page: BaseMainDriverTab.page,
              children: [
                AutoRoute(
                  page: MainDriverRoute.page,
                  initial: true,
                ),
              ],
            ),
            AutoRoute(page: CreateRouteRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),

        ///
        ///Auth
        ///
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: ConfirmationRoute.page),

        ///
        ///Main
        ///
        AutoRoute(page: CreateRouteSecondRoute.page),
        AutoRoute(page: DriverRouteDetailRoute.page),
        AutoRoute(page: MonitoringDriverRoute.page),
        AutoRoute(page: ScanTicketRoute.page),
        AutoRoute(page: MainPassengerRoute.page),
        AutoRoute(page: SearchPassengerResultRoute.page),
      ];
}

@RoutePage(name: 'BaseMainDriverTab')
class BaseMainDriverPage extends AutoRouter {
  const BaseMainDriverPage({super.key});
}

@RoutePage(name: 'BaseMainPassengerTab')
class BaseMainPassengerPage extends AutoRouter {
  const BaseMainPassengerPage({super.key});
}
