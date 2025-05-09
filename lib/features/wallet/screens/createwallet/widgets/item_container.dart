import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class itemcontainer extends StatelessWidget {
  const itemcontainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 138,
      decoration: BoxDecoration(
          color: MColors.subprimaryColor,
          borderRadius: BorderRadius.circular(Msizes.borderRadiusMd)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 25,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MColors.white,
                ),
          ),
        ],
      ),
    );
  }
}
