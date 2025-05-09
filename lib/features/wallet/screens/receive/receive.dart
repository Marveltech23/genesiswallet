import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genesiswallet/features/wallet/screens/receive/receivebarcode.dart';
import 'package:genesiswallet/utils/constants/api_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images_string.dart';
import '../../../../utils/http/models/assertavailable.dart';

class ReceiveScreen extends StatefulWidget {
  ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  late Future<AssetAvailable> _futureAssetAvailable;

  @override
  void initState() {
    super.initState();
    _futureAssetAvailable = fetchAssetAvailable();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<AssetAvailable> fetchAssetAvailable() async {
    String? token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse('${APIConstants.baseUrl}/networks');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return assetAvailableFromJson(response.body);
    } else {
      throw Exception('Failed to load asset available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Receive',
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
      body: SafeArea(
        child: Center(
          child: FutureBuilder<AssetAvailable>(
            future: _futureAssetAvailable,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (context, index) {
                    final asset = snapshot.data!.data[index];
                    return ListTile(
                      title: Text(
                        asset.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: MColors.white,
                            ),
                      ),
                      subtitle: Text(
                        asset.symbol,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: MColors.success,
                            ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiveBarCode(),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Receiveitems extends StatelessWidget {
  const Receiveitems({
    Key? key,
    required this.images,
    required this.coinName,
    required this.amount,
    required this.coinpercentage,
    required this.amountindollars,
    required this.btcamount,
  }) : super(key: key);

  final String images;
  final String coinName;
  final String amount;
  final String coinpercentage;
  final String amountindollars;
  final String btcamount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Apply SpaceBetween property
      children: [
        const Image(
          image: AssetImage(MImage.Bitconis),
        ),
        const SizedBox(
            width: 10), // Add spacing between the image and the column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Apply SpaceBetween property
                children: [
                  Text(
                    coinName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: MColors.white,
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
              const SizedBox(
                  height: 1), // Add vertical spacing between the rows
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Apply SpaceBetween property
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        TextSpan(
                          text: coinpercentage,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
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
    );
  }
}
















// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:trustforge/utils/http/models/user_avaliable_network.dart';
// import 'package:your_project_name_here/asset_available.dart'; // Import the AssetAvailable model

// class AssetListScreen extends StatefulWidget {
//   @override
//   _AssetListScreenState createState() => _AssetListScreenState();
// }

// class _AssetListScreenState extends State<AssetListScreen> {
//   late Future<AssetAvailable> _futureAssetAvailable;

//   @override
//   void initState() {
//     super.initState();
//     _futureAssetAvailable = fetchAssetAvailable();
//   }

//   Future<AssetAvailable> fetchAssetAvailable() async {
//     var headers = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer 11|zClZDjSdeJfx0467ylrJSJiOq4mYu07WHNmHd29q35ed7722'
//     };
  
//     var url = Uri.parse('https://app.trustforge.cc/api/networks');
//     var response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       return assetAvailableFromJson(response.body);
//     } else {
//       throw Exception('Failed to load asset available');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Available Assets'),
//       ),
//       body: Center(
//         child: FutureBuilder<AssetAvailable>(
//           future: _futureAssetAvailable,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.data.length,
//                 itemBuilder: (context, index) {
//                   final asset = snapshot.data!.data[index];
//                   return ListTile(
//                     title: Text(asset.name),
//                     subtitle: Text(asset.symbol),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AssetDetailsScreen(asset: asset),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
