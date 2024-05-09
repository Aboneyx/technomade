import 'package:flutter/material.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';

class PersonInfoWidget extends StatelessWidget {
  final UserDTO? driver;
  const PersonInfoWidget({
    super.key,
    this.driver,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${driver?.firstName ?? ''} ${driver?.lastName}',
              style: const TextStyle(fontSize: 16),
            ),
            // const Text(
            //   '“Lucia” Ltd',
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            // ),
          ],
        ),
      ],
    );
  }
}
