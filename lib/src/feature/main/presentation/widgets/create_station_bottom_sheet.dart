import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';

class CreateStationBottomSheet extends StatefulWidget {
  const CreateStationBottomSheet({
    super.key,
  });

  static Future<void> show(
    BuildContext context,
  ) async =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) => const CreateStationBottomSheet(),
      );

  @override
  State<CreateStationBottomSheet> createState() => _CreateStationBottomSheetState();
}

class _CreateStationBottomSheetState extends State<CreateStationBottomSheet> {
  final double maxChildSize = 0.85;
  final double minChildSize = 0.25;

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
                    'Rate config',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const CustomTextField(
                    hintText: 'Station name',
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppColors.primaryColor300),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Departure time',
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppColors.primaryColor300),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Arrival time',
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: AppColors.primaryColor300),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomTextField(
                    hintText: 'Cost',
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppColors.primaryColor300),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    text: 'Create a station',
                    onTap: () {},
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
