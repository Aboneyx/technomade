import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:technomade/src/core/resources/resources.dart';

class DateBottomSheet extends StatefulWidget {
  final DateTime? selectedTime;
  const DateBottomSheet({
    super.key,
    this.selectedTime,
  });

  static Future<DateTime?> show(
    BuildContext context, {
    DateTime? selectedTime,
  }) async =>
      showModalBottomSheet<DateTime?>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) => DateBottomSheet(
          selectedTime: selectedTime,
        ),
      );

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  final double maxChildSize = 0.85;
  final double minChildSize = 0.25;

  late double initialChildSize;
  @override
  void initState() {
    super.initState();
    if (widget.selectedTime != null) {
      selectedDay = widget.selectedTime!;
    }
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

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

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
                    'Date of travel',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            TableCalendar(
              availableGestures: AvailableGestures.horizontalSwipe,
              focusedDay: focusedDay,
              firstDay: DateTime(1970),
              currentDay: selectedDay,
              lastDay: DateTime(DateTime.now().year + 2),
              onPageChanged: (focusedDay) {
                this.focusedDay = focusedDay;
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextFormatter: (date, locale) {
                  return DateFormat(
                    'MMMM, yyyy',
                  ).format(date);
                },
                titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                titleCentered: true,
                leftChevronIcon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                rightChevronIcon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                leftChevronPadding: const EdgeInsets.all(8),
                rightChevronPadding: const EdgeInsets.all(8),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                this.selectedDay = selectedDay;
                setState(() {});
                context.router.maybePop(selectedDay);
              },
              daysOfWeekHeight: 30,
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date),
                weekdayStyle: const TextStyle(fontSize: 13, color: AppColors.labelColorLightSecondary),
                weekendStyle: const TextStyle(fontSize: 13, color: AppColors.labelColorLightSecondary),
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              rowHeight: 46,
              calendarStyle: const CalendarStyle(
                tablePadding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                defaultTextStyle: TextStyle(fontSize: 20),
                weekendTextStyle: TextStyle(fontSize: 20),
              ),
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, day, focusedDay) => Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
                todayBuilder: (context, day, focusedDay) => Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // markerBuilder:(context, day, events) => Container(
                //   width: 44,
                //   height: 44,
                //   decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(50)),
                //   child: Text(
                //     day.day.toString(),
                //     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
                //   ),
                // ),
                outsideBuilder: (context, day, focusedDay) => const SizedBox(),
              ),
            ),
          ],
        );
      },
    );
  }
}
