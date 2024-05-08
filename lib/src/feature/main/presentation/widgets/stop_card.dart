import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';

class StopCard extends StatelessWidget {
  final Function()? onDeleteTap;
  const StopCard({super.key, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.labelColorLightSecondary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kaskelen',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                if (onDeleteTap != null)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
                    onPressed: onDeleteTap,
                    icon: SvgPicture.asset(Assets.icons.deleteForeverOutline),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arrive time : 12:30'),
                    Text('Departure time: 23:00'),
                  ],
                ),
                Text(
                  '1750',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
