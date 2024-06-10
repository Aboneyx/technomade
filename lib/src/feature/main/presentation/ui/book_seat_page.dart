import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/extension/integer_extension.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/bloc/place_cubit.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';

@RoutePage()
class BookSeatPage extends StatefulWidget implements AutoRouteWrapper {
  final double price;
  final RouteDTO route;
  final RouteStationDTO startStation;
  final RouteStationDTO finishStation;
  const BookSeatPage({
    super.key,
    required this.price,
    required this.route,
    required this.startStation,
    required this.finishStation,
  });

  @override
  State<BookSeatPage> createState() => _BookSeatPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaceCubit(repository: DI()),
      child: this,
    );
  }
}

class _BookSeatPageState extends State<BookSeatPage> {
  @override
  void initState() {
    if (widget.route.id != null && widget.startStation.id != null && widget.finishStation.id != null) {
      BlocProvider.of<PlaceCubit>(context)
          .getPlaces(routeId: widget.route.id!, start: widget.startStation.id!, finish: widget.finishStation.id!);
    }
    super.initState();
  }

  PlaceDTO? selectedIndex;
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _InfoRowWidget(),
            ),
            BlocConsumer<PlaceCubit, PlaceState>(
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
                  loadedState: (places) => Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      itemBuilder: (context, index) => SeatCard(
                        place: places[index],
                        onTap: () {
                          selectedIndex = places[index];
                          setState(() {});
                        },
                        status: selectedIndex == places[index] ? 2 : 1,
                      ),
                      itemCount: places.length,
                    ),
                  ),
                  orElse: () => const Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                );
              },
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                height: 36,
                text: 'Book',
                onTap: selectedIndex != null
                    ? () {
                        context.router.push(
                          BookInfoRoute(
                            route: widget.route,
                            startStation: widget.startStation,
                            finishStation: widget.finishStation,
                            price: widget.price,
                            place: selectedIndex!,
                          ),
                        );
                      }
                    : null,
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatCard extends StatelessWidget {
  final Function()? onTap;
  final int status;
  final PlaceDTO place;

  /// 0-reserved, 1-available, 2-selected seat
  const SeatCard({
    super.key,
    this.onTap,
    required this.status,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: place.placeState == 'TAKEN' ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(
          place.placeState == 'TAKEN'
              ? Assets.icons.searReserved
              : status == 1
                  ? Assets.icons.seatAvailable
                  : Assets.icons.seatSelected,
        ),
      ),
    );
  }
}

class _InfoRowWidget extends StatelessWidget {
  const _InfoRowWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.grey4),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Reserved',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent,
                border: Border.all(color: AppColors.mainColor),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Available',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: AppColors.mainColor),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Selected Seat',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
