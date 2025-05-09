import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class SecurityandPrivacy extends StatelessWidget {
  const SecurityandPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Security and Privacy',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MColors.white,
                fontSize: 15,
              ),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MColors.white,
            )),
      ),
      body: const Padding(
        padding: EdgeInsets.all(Msizes.defaultSpace),
        child: Column(
          children: [
            securityandprivacy(
              title: 'Security detector',
              subtitle: 'Show warnings for high=risk transactions',
              icon: Icons.toggle_off,
            ),
            SizedBox(
              height: 15,
            ),
            Security(
              text: 'Passcode',
              icon: null,
              icon1: Icons.toggle_off,
            ),
            SizedBox(
              height: 15,
            ),
            securityandprivacy(
              title: 'Lack method',
              subtitle: 'Passcode/face ID',
              icon: Icons.arrow_forward_ios,
            ),
            SizedBox(
              height: 15,
            ),
            securityandprivacy(
              title: 'Transaction signing',
              subtitle: 'Ask for approval ahead of transactions',
              icon: Icons.toggle_off,
            ),
          ],
        ),
      ),
    );
  }
}

class securityandprivacy extends StatelessWidget {
  const securityandprivacy({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MColors.white,
                    fontSize: 15,
                  ),
            ),
            Icon(
              icon,
              color: MColors.subprimaryColor,
              size: 35,
            )
          ],
        ),
        Row(
          children: [
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: MColors.white, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

class Security extends StatelessWidget {
  const Security({
    Key? key,
    required this.text,
    required this.icon,
    required this.icon1,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final IconData icon1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MColors.white,
                  ),
            )
          ],
        ),
        Icon(
          icon1,
          color: MColors.subprimaryColor,
          size: 35,
        ),
      ],
    );
  }
}
