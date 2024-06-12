import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/main/bloc/tickets_cubit.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';
import 'package:technomade/src/feature/main/presentation/widgets/main_route_card.dart';

@RoutePage()
class MainPassengerPage extends StatefulWidget  {
  const MainPassengerPage({super.key});

  @override
  State<MainPassengerPage> createState() => _MainPassengerPageState();


}

class _MainPassengerPageState extends State<MainPassengerPage> {
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<TicketsCubit>(context).getTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TicketsCubit, TicketsState>(
        listener: (context, state) {
          state.maybeWhen(
            errorState: (message) {
              SnackBarUtil.showErrorTopShortToast(context, message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loadedState: (tickets) => SmartRefresher(
              scrollController: scrollController,
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<TicketsCubit>(context).getTickets(
                  hasLoading: false,
                );
                refreshController.refreshCompleted();
              },
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemBuilder: (context, index) => MainRouteCard(
                  route: RouteDTO(
                    id: tickets[index].forRoute?.id,
                    description: tickets[index].forRoute?.description,
                    routeState: tickets[index].forRoute?.routeState,
                    routeStations: tickets[index].fromStop != null && tickets[index].toStop != null
                        ? [tickets[index].fromStop!, tickets[index].toStop!]
                        : null,
                  ),
                  isPassenger: true,
                  onTap: () {
                    context.router.push(
                      PassengerTicketDetailRoute(
                        ticket: tickets[index],
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: tickets.length,
              ),
            ),
            orElse: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        },
      ),
    );
  }
}
