import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/app/widgets/custom_loading_widget.dart';
import 'package:technomade/src/feature/app/widgets/field_debouncer.dart';
import 'package:technomade/src/feature/main/bloc/station_list_cubit.dart';
import 'package:technomade/src/feature/main/model/station_dto.dart';

class FromBottomSheet extends StatefulWidget {
  final String? title;
  const FromBottomSheet({
    super.key,
    this.title,
  });

  static Future<StationDTO?> show(
    BuildContext context, {
    String? title,
  }) async =>
      showModalBottomSheet<StationDTO?>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) => BlocProvider(
          create: (context) => StationListCubit(
            repository: DI(),
          ),
          child: FromBottomSheet(
            title: title,
          ),
        ),
      );

  @override
  State<FromBottomSheet> createState() => _FromBottomSheetState();
}

class _FromBottomSheetState extends State<FromBottomSheet> {
  final double maxChildSize = 0.85;
  final double minChildSize = 0.25;

  late double initialChildSize;
  @override
  void initState() {
    BlocProvider.of<StationListCubit>(context).getStationList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    const heightPercentage = 0.85;

    initialChildSize = heightPercentage > maxChildSize
        ? maxChildSize
        : heightPercentage < minChildSize
            ? minChildSize
            : heightPercentage;
    // print(initialChildSize);
  }

  final FieldDebouncer debouncer = FieldDebouncer(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StationListCubit, StationListState>(
      listener: (context, state) {
        state.whenOrNull(
          errorState: (message) {
            SnackBarUtil.showErrorTopShortToast(context, message);
          },
        );
      },
      builder: (context, state) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: initialChildSize,
          minChildSize: minChildSize,
          initialChildSize: initialChildSize,
          builder: (context, scrollController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 4,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.grey3,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.title ?? 'From',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoTextField(
                    onChanged: (value) {
                      debouncer.run(() {
                        BlocProvider.of<StationListCubit>(context).searchStation(value);
                      });
                    },
                    placeholder: 'City or station',
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10).copyWith(right: 0),
                      child: const Icon(
                        Icons.search,
                        color: AppColors.grey1,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0, color: Colors.transparent),
                      color: AppColors.bgBaseSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: state.maybeWhen(
                    loadedState: (stations) => CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverList.builder(
                          itemCount: stations.length,
                          itemBuilder: (context, index) => Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                context.router.maybePop(stations[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  stations[index].name ?? 'no name',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    orElse: () => const CustomLoadingWidget(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
