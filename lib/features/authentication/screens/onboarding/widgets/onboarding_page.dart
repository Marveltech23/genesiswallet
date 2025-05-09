import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/constants/sizes.dart';
import 'package:genesiswallet/utils/helpers/helper_funtions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Msizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: MHelperFunction.screenWidth() * 0.8,
            height: MHelperFunction.screenHeight() * 0.6,
            image: AssetImage(image),
          ),
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: MColors.white),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          const SizedBox(
            height: Msizes.SpaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: MColors.white),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
