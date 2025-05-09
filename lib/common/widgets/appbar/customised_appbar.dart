import 'package:flutter/material.dart';
import 'package:genesiswallet/common/widgets/appbar/appbar.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class customiseAppBar extends StatelessWidget {
  const customiseAppBar({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MAppBar(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: MColors.white,
              ),
              const SizedBox(
                width: Msizes.defaultSpace,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: MColors.white, fontSize: 18),
              )
            ],
          ),
        ],
      ),
    );
  }
}
