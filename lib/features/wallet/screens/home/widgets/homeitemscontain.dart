import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class homeitemscontainer extends StatelessWidget {
  const homeitemscontainer({
    Key? key,
    required this.text,
    required this.icons,
  }) : super(key: key);
  final String text;
  final IconData icons;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 140,
      decoration: BoxDecoration(
          color: MColors.subprimaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(
            icons,
            color: MColors.accent,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MColors.accent,
                  fontSize: 16,
                ),
          )
        ],
      ),
    );
  }
}
