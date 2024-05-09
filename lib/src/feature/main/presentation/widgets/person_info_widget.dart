import 'package:flutter/material.dart';

class PersonInfoWidget extends StatelessWidget {
  const PersonInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey),
          child: const Icon(
            Icons.person,
            size: 40,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aleksey Ivanov Yutong',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '“Lucia” Ltd',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
