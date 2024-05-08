import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';

class FromBottomSheet extends StatefulWidget {
  const FromBottomSheet({
    super.key,
  });

  static Future<void> show(
    BuildContext context,
  ) async =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) => const FromBottomSheet(),
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
                    'From',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoTextField(
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
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverList.separated(
                    itemBuilder: (context, index) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Almaty',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: 20,
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
