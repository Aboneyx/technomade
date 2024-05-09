import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/main/bloc/search_passenger_cubit.dart';
import 'package:technomade/src/feature/main/presentation/widgets/main_route_card.dart';

@RoutePage()
class SearchPassengerResultPage extends StatefulWidget implements AutoRouteWrapper {
  final String from;
  final String to;
  final String? date;
  const SearchPassengerResultPage({super.key, required this.from, required this.to, this.date});

  @override
  State<SearchPassengerResultPage> createState() => _SearchPassengerResultPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPassengerCubit(repository: DI()),
      child: this,
    );
  }
}

class _SearchPassengerResultPageState extends State<SearchPassengerResultPage> {
  @override
  void initState() {
    BlocProvider.of<SearchPassengerCubit>(context).searchPassenger(from: widget.from, to: widget.to, date: widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 24,
            constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
            onPressed: () {
              context.router.maybePop();
            },
            icon: SvgPicture.asset(Assets.icons.arrowLeftDropCircleOutline),
          ),
        ),
        leadingWidth: 48,
        title: Text(
          '${widget.from} - ${widget.to}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: BlocConsumer<SearchPassengerCubit, SearchPassengerState>(
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
            loadedState: (routes) => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemBuilder: (context, index) => MainRouteCard(
                hasTimeline: false,
                route: routes[index],
                onTap: () {
                  context.router.push(const SearchResultDetailRoute());
                },
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: routes.length,
            ),
            orElse: () => const Center(child: CircularProgressIndicator.adaptive()),
          );
        },
      ),
    );
  }
}
