import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:technomade/src/feature/main/model/payload/stops_payload.dart';
import 'package:technomade/src/feature/main/model/station_dto.dart';
import 'package:technomade/src/feature/main/presentation/vmodel/create_route_vmodel.dart';
import 'package:technomade/src/feature/main/presentation/widgets/choose_station_bottom_sheet.dart';
import 'package:technomade/src/feature/main/presentation/widgets/date_bottom_sheet.dart';
import 'package:technomade/src/feature/main/presentation/widgets/time_bottom_sheet.dart';

class AddStopBottomSheet extends StatefulWidget {
  const AddStopBottomSheet({
    super.key,
  });

  static Future<void> show(
    BuildContext context, {
    required CreateRouteVmodel createRouteVmodel,
  }) async =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) => ChangeNotifierProvider.value(
          value: createRouteVmodel,
          child: const AddStopBottomSheet(),
        ),
      );

  @override
  State<AddStopBottomSheet> createState() => _AddStopBottomSheetState();
}

class _AddStopBottomSheetState extends State<AddStopBottomSheet> {
  final double maxChildSize = 0.85;
  final double minChildSize = 0.25;
  StationDTO? selectedStation;
  DateTime? selectedArrivalDate;
  DateTime? selectedArrivalTime;
  DateTime? selectedDepartureDate;
  DateTime? selectedDepartureTime;
  final TextEditingController costController = TextEditingController();

  late double initialChildSize;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Text(
                    'Add Stop',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primaryColor300),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () async {
                          final StationDTO? chosenStation = await FromBottomSheet.show(context);
                          if (chosenStation == null) return;
                          if (!context.mounted) return;

                          final provider = Provider.of<CreateRouteVmodel>(context, listen: false);
                          if (!provider.checkingStops(chosenStation.name ?? '')) {
                            SnackBarUtil.showErrorTopShortToast(context, 'There is already a stop in the route');
                          } else {
                            selectedStation = chosenStation;
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            selectedStation != null ? selectedStation!.name ?? 'no name' : 'Station name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: selectedStation != null ? FontWeight.w600 : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor300),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final DateTime? date =
                                    await DateBottomSheet.show(context, selectedTime: selectedArrivalDate);
                                if (date != null) {
                                  selectedArrivalDate = date;
                                }
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedArrivalDate != null
                                            ? DateFormat().format(selectedArrivalDate!)
                                            : 'Arrival Date',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: selectedArrivalDate != null ? FontWeight.w600 : null,
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset(Assets.icons.calendarBlankOutline),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor300),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final DateTime? date =
                                    await TimeBottomSheet.show(context, selectedTime: selectedArrivalTime);
                                if (date != null) {
                                  selectedArrivalTime = date;
                                }
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedArrivalTime != null
                                      ? DateFormat('H:mm').format(selectedArrivalTime!)
                                      : 'Arrival Time',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: selectedArrivalTime != null ? FontWeight.w600 : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor300),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final DateTime? date =
                                    await DateBottomSheet.show(context, selectedTime: selectedDepartureDate);
                                if (date != null) {
                                  selectedDepartureDate = date;
                                }
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedDepartureDate != null
                                            ? DateFormat().format(selectedDepartureDate!)
                                            : 'Departure Date',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: selectedDepartureDate != null ? FontWeight.w600 : null,
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset(Assets.icons.calendarBlankOutline),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor300),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final DateTime? date =
                                    await TimeBottomSheet.show(context, selectedTime: selectedDepartureTime);
                                if (date != null) {
                                  selectedDepartureTime = date;
                                }
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedDepartureTime != null
                                      ? DateFormat('H:mm').format(selectedDepartureTime!)
                                      : 'Departure Time',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: selectedDepartureTime != null ? FontWeight.w600 : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: 'Cost',
                    controller: costController,
                    keyboardType: TextInputType.number,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryColor300),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Add',
                    onTap: () {
                      final provider = Provider.of<CreateRouteVmodel>(context, listen: false);

                      final int? cost = int.tryParse(costController.text);

                      if (cost != null &&
                          selectedStation != null &&
                          selectedArrivalDate != null &&
                          selectedArrivalTime != null &&
                          selectedDepartureDate != null &&
                          selectedDepartureTime != null) {
                        provider.addStops(
                          StopsPayload(
                            cost: cost,
                            station: selectedStation!.name,
                            departureTime: DateTime(
                              selectedDepartureDate!.year,
                              selectedDepartureDate!.month,
                              selectedDepartureDate!.day,
                              selectedDepartureTime!.hour,
                              selectedDepartureTime!.minute,
                              selectedDepartureTime!.second,
                              selectedDepartureTime!.millisecond,
                              selectedDepartureTime!.microsecond,
                            ),
                            arrivalTime: DateTime(
                              selectedArrivalDate!.year,
                              selectedArrivalDate!.month,
                              selectedArrivalDate!.day,
                              selectedArrivalTime!.hour,
                              selectedArrivalTime!.minute,
                              selectedArrivalTime!.second,
                              selectedArrivalTime!.millisecond,
                              selectedArrivalTime!.microsecond,
                            ),
                          ),
                        );
                        context.router.maybePop();
                      } else {
                        SnackBarUtil.showErrorTopShortToast(context, 'Fill in all the data');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
