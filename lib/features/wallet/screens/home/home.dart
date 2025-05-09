import 'package:flutter/material.dart';
import 'package:genesiswallet/features/wallet/screens/home/widgets/assets.dart';
import 'package:genesiswallet/features/wallet/screens/home/widgets/homeitemscontain.dart';
import 'package:genesiswallet/features/wallet/screens/receive/receive.dart';
import 'package:genesiswallet/features/wallet/screens/send/send.dart';
import 'package:genesiswallet/utils/constants/images_string.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/models/registrationmodel.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({Key? key, this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;
  DateTime dateTime = DateTime.now();
  String formattedDate = '';
  String greeting = '';

  @override
  void initState() {
    super.initState();
    _updateDateAndGreeting();
  }

  void _updateDateAndGreeting() {
    formattedDate = DateFormat('EEE, d MMM yyyy').format(dateTime);
    greeting = getGreeting();
  }

  String getGreeting() {
    int hour = dateTime.hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user != null
                        ? '$greeting ${user.nickname ?? ''}'
                        : greeting,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: Msizes.SpaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Main Wallet',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                  ),
                  const SizedBox(width: 10),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 7),
                  Text(
                    isVisible && user != null
                        ? '\$${user.totalAssetAmount}'
                        : '*****',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => SendScreen()),
                    child: const homeitemscontainer(
                      text: 'Send',
                      icons: Iconsax.send_14,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.to(() => ReceiveScreen()),
                    child: const homeitemscontainer(
                      text: 'Receive',
                      icons: Iconsax.receive_square5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(10),
                height: 66,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Msizes.borderRadiusLg),
                  color: MColors.subprimaryColor,
                ),
                child: Row(
                  children: [
                    const Image(image: AssetImage(MImage.asser)),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Crypto from Binance or Coinbase',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MColors.white,
                                    fontSize: 12,
                                  ),
                        ),
                        Text(
                          'Deposit now',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MColors.textcolor,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Assets',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MColors.white,
                                  ),
                        ),
                        Text(
                          'see all',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MColors.white,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    user != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: user.assets.length,
                            itemBuilder: (context, index) {
                              final asset = user.assets[index];
                              // Build the image URL
                              String imageUrl = asset.logo.startsWith('http')
                                  ? asset.logo
                                  : 'https://app.genesiwallet.cc/api/${asset.logo}';

                              return SizedBox(
                                height: 100,
                                child: Card(
                                  child: Assetsitems(
                                    images: imageUrl, // Pass the image URL here
                                    coinName: asset.symbol,
                                    amount: formatNumber(asset.userCoinBalance),
                                    coinpercentage:
                                        '(${formatNumber(asset.balanceDollarRate)}%)',
                                    amountindollars:
                                        '\$${formatNumber(asset.balanceDollarRate)}',
                                    btcamount: formatNumber(asset.dollarRate),
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          )
                        : const Text(
                            'No assets available',
                            style: TextStyle(color: MColors.white),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatNumber(String numberStr) {
    final number = double.tryParse(numberStr) ?? 0.0;
    return number.toStringAsFixed(2);
  }
}
