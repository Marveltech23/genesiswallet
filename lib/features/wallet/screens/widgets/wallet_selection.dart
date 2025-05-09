import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class walletselection extends StatelessWidget {
  const walletselection({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          color: MColors.subprimaryColor,
          borderRadius: BorderRadius.circular(Msizes.borderRadiusMd)),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: MColors.accent),
            child: Icon(
              icon,
            ),
          ),
          const SizedBox(
            width: Msizes.defaultSpace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MColors.white,
                ),
          )
        ],
      ),
    );
  }
}
