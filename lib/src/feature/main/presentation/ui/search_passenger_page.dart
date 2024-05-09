import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/presentation/widgets/date_bottom_sheet.dart';
import 'package:technomade/src/feature/main/presentation/widgets/from_bottom_sheet.dart';

@RoutePage()
class SearchPassengerPage extends StatefulWidget {
  const SearchPassengerPage({super.key});

  @override
  State<SearchPassengerPage> createState() => _SearchPassengerPageState();
}

class _SearchPassengerPageState extends State<SearchPassengerPage> {
  DateTime? selectedDate;
  DateTime? selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Find ticket',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 32,
            ),
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
                  onTap: () {
                    FromBottomSheet.show(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'From',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
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
                  onTap: () {
                    FromBottomSheet.show(context, title: 'To');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'To',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
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
                    final DateTime? date = await DateBottomSheet.show(context, selectedTime: selectedDate);
                    if (date != null) {
                      selectedDate = date;
                    }
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate != null ? DateFormat().format(selectedDate!) : 'Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: selectedDate != null ? FontWeight.w600 : null,
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
            const SizedBox(
              height: 24,
            ),
            CustomButton(
              text: 'Search',
              onTap: () {
                context.router.push(const SearchPassengerResultRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
