import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';

class TimeBottomSheet extends StatefulWidget {
  final DateTime? selectedTime;
  const TimeBottomSheet({
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
        builder: (_) => TimeBottomSheet(
          selectedTime: selectedTime,
        ),
      );

  @override
  State<TimeBottomSheet> createState() => _TimeBottomSheetState();
}

class _TimeBottomSheetState extends State<TimeBottomSheet> {
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
    const heightPercentage = 0.5;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
        SizedBox(
          height: 199,
          child: CupertinoTheme(
            data: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                pickerTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                dateTimePickerTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            child: CupertinoDatePicker(
              initialDateTime: selectedDay,
              onDateTimeChanged: (value) {
                selectedDay = value;
              },
              mode: CupertinoDatePickerMode.time,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(
            onTap: () {
              context.router.maybePop(selectedDay);
            },
            text: 'Save',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
