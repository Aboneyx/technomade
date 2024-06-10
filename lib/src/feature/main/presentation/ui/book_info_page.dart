import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/extension/integer_extension.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/bloc/book_place_cubit.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';

@RoutePage()
class BookInfoPage extends StatefulWidget implements AutoRouteWrapper {
  final double price;
  final RouteDTO route;
  final RouteStationDTO startStation;
  final RouteStationDTO finishStation;
  final PlaceDTO place;
  const BookInfoPage({
    super.key,
    required this.price,
    required this.route,
    required this.startStation,
    required this.finishStation,
    required this.place,
  });

  @override
  State<BookInfoPage> createState() => _BookInfoPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => BookPlaceCubit(repository: DI()),
      child: this,
    );
  }
}

class _BookInfoPageState extends State<BookInfoPage> {
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
        title: const Text(
          'Back',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.startStation.station?.name} ----- ${widget.finishStation.station?.name}',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  BookInfoRow(
                    firstTitle: 'Date & Time',
                    firstSubtitle:
                        DateFormat('dd MMMM, HH:mm').format(widget.startStation.departureTime ?? DateTime.now()),
                    secondTitle: 'Arrival',
                    secondSubtitle:
                        DateFormat('dd MMMM, HH:mm').format(widget.finishStation.arrivalTime ?? DateTime.now()),
                  ),
                  BookInfoRow(
                    firstTitle: 'Ticket',
                    firstSubtitle: '1 seat',
                    secondTitle: 'Seat number',
                    secondSubtitle: '${widget.place.place + 1}',
                  ),
                  BookInfoRow(
                    firstTitle: 'Price',
                    firstSubtitle: '${widget.price.toInt().thousandFormat()} ₸',
                    secondTitle: 'Bus number',
                    secondSubtitle: '122040',
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${widget.price.toInt().thousandFormat()} ₸',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<BookPlaceCubit, BookPlaceState>(
              listener: (context, state) {
                state.maybeWhen(
                  loadedState: (message) {
                    SnackBarUtil.showTopShortToast(context, message: message);
                    context.router.popUntil((route) => route.settings.name == LauncherRoute.name);
                  },
                  errorState: (message) {
                    SnackBarUtil.showErrorTopShortToast(context, message);
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
                  child: CustomButton(
                    onTap: () {
                      if (widget.route.id != null &&
                          widget.startStation.id != null &&
                          widget.finishStation.id != null) {
                        BlocProvider.of<BookPlaceCubit>(context).bookPlace(
                          routeId: widget.route.id!,
                          start: widget.startStation.id!,
                          finish: widget.finishStation.id!,
                          place: widget.place.place,
                        );
                      }
                    },
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: 40,
                    text: 'Book',
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    child: state.maybeWhen(
                      loadingState: () => const CircularProgressIndicator.adaptive(),
                      orElse: () => null,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BookInfoRow extends StatelessWidget {
  final String firstTitle;
  final String firstSubtitle;

  final String secondTitle;
  final String secondSubtitle;

  const BookInfoRow({
    super.key,
    required this.firstTitle,
    required this.firstSubtitle,
    required this.secondTitle,
    required this.secondSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstTitle,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                firstSubtitle,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                secondTitle,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                secondSubtitle,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
