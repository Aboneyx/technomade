import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MainRouteCard extends StatelessWidget {
  const MainRouteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Almaty - Shymkent',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SvgPicture.asset('assets/icons/chevron-down.svg'),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              children: [
                Text('8:30-18:30'),
                SizedBox(
                  width: 8,
                ),
                Text('10 hours on the road'),
              ],
            ),
            const Text('12 martch - 13 martch'),
            const SizedBox(
              height: 8,
            ),
            const Text(
              '10 000 ₸',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
