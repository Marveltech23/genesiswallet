import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';

class Assetsitems extends StatelessWidget {
  const Assetsitems({
    Key? key,
    required this.images,
    required this.coinName,
    required this.amount,
    required this.coinpercentage,
    required this.amountindollars,
    required this.btcamount,
    required this.index, // Add the index parameter
  }) : super(key: key);

  final String coinName;
  final String amount;
  final String coinpercentage;
  final String amountindollars;
  final String btcamount;
  final String images;
  final int index; // Store the index

  @override
  Widget build(BuildContext context) {
    // Determine the fallback image based on the index
    String fallbackImage;
    if (index == 0) {
      fallbackImage = 'assets/images/on_boarding_images/image 3.png';
    } else if (index == 1) {
      fallbackImage = 'assets/images/on_boarding_images/solona.png';
    } else {
      fallbackImage = 'assets/images/on_boarding_images/image 5.png';
    }

    return Container(
      decoration: const BoxDecoration(
        color: MColors.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              images,
              width: 40, // specify a width for the image
              height: 40, // specify a height for the image
              fit: BoxFit.contain,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                log('Error loading image: $images, error: $error');
                return Image.asset(fallbackImage,
                    width: 40, height: 40); // Use fallback image on error
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          coinName,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: MColors.white,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        btcamount,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: MColors.white,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: amount,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            TextSpan(
                              text: coinpercentage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.red,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        amountindollars,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: MColors.white,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
