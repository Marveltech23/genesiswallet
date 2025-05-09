import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../../utils/constants/colors.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preferences',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MColors.white,
                fontSize: 17,
              ),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MColors.white,
            )),
      ),
      backgroundColor: MColors.primaryColor,
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            prefrenceitems(
              text: 'Currency',
              subtext: 'USD',
            ),
            SizedBox(
              height: 20,
            ),
            prefrenceitems(
              text: 'Currency',
              subtext: 'USD',
            )
          ],
        ),
      ),
    );
  }
}

class prefrenceitems extends StatelessWidget {
  const prefrenceitems({
    Key? key,
    required this.text,
    required this.subtext,
  }) : super(key: key);
  final String text;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MColors.white,
                  ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: MColors.white,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subtext,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: MColors.white, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ],
    );
  }
}
