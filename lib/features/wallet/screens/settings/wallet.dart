import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../../utils/constants/colors.dart';

class Wallets extends StatelessWidget {
  const Wallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Wallets',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: MColors.white,
                fontSize: 18,
              ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.add,
              color: MColors.subprimaryColor,
              size: 20,
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MColors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 115,
                width: 500,
                decoration: BoxDecoration(
                  color: MColors.subprimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Main wallet',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          'Back up manually',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MColors.white,
                                    fontSize: 14,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          'Back up to iCloud',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MColors.white,
                                    fontSize: 14,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
