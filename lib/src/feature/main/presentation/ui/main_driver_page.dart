import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/app/widgets/custom_loading_widget.dart';
import 'package:technomade/src/feature/main/bloc/main_driver_cubit.dart';
import 'package:technomade/src/feature/main/presentation/widgets/main_route_card.dart';

@RoutePage()
class MainDriverPage extends StatefulWidget implements AutoRouteWrapper {
  const MainDriverPage({super.key});

  @override
  State<MainDriverPage> createState() => _MainDriverPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => MainDriverCubit(repository: DI()),
      child: this,
    );
  }
}

class _MainDriverPageState extends State<MainDriverPage> {
  @override
  void initState() {
    BlocProvider.of<MainDriverCubit>(context).getDriversMyRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<MainDriverCubit, MainDriverState>(
        listener: (context, state) {
          state.maybeWhen(
            errorState: (message) {
              SnackBarUtil.showErrorTopShortToast(context, message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) => state.maybeWhen(
          orElse: () => const CustomLoadingWidget(),
          loadedState: (routes) {
            if (routes.isEmpty) {
              return const Center(
                child: Text('no routes'),
              );
            }
            return ListView.separated(
              itemCount: routes.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemBuilder: (context, index) => MainRouteCard(
                route: routes[index],
                onTap: () {
                  context.router.push(const DriverRouteDetailRoute());
                },
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
            );
          },
        ),
      ),
    );
  }
}
