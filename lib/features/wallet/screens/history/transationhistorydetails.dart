import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/http/models/transactionhistory.dart';

class TransactionHistorydeatails extends StatefulWidget {
  const TransactionHistorydeatails({super.key});

  @override
  State<TransactionHistorydeatails> createState() =>
      _TransactionHistorydeatailsState();
}

class _TransactionHistorydeatailsState
    extends State<TransactionHistorydeatails> {
// Fetch transaction history

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      print('Token successfully retrieved: $token');
    } else {
      print('Token not found or is empty');
    }

    return token;
  }

  Future<List<Transaction>> fetchTransactions() async {
    // Set loading state to true when starting to fetch

    String? token = await _getToken();

    // Check if the token is null or empty
    if (token == null || token.isEmpty) {
      print('Token not found');
      // Set loading state to false
      return []; // Return an empty list instead of null
    }

    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/transaction-history'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Check for successful response
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body)['data'];
        return jsonResponse
            .map((transaction) => Transaction.fromJson(transaction))
            .toList();
      } else {
        throw Exception(
            'Failed to load transactions: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
      return []; // Return an empty list on error
    } finally {
      // Ensure loading state is set to false when done
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: MColors.white,
          ),
        ),
        title: Text(
          'Transaction History',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: MColors.white,
                fontSize: 15,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                '-0.0050678 BTC',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: MColors.white, fontSize: 20),
              ),
            ),
            Center(
              child: Text(
                '=\$\281.121',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: 169,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: MColors.subprimaryColor,
                  borderRadius: BorderRadius.circular(12)),
              child: const Column(
                children: [
                  Ttext(
                    title: 'Date',
                    titlediscripion: '21 Dec 2023, 10:44',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Ttext(
                    title: 'Status',
                    titlediscripion: 'Completed',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Ttext(
                    title: 'Recipient',
                    titlediscripion: 'bcc1w3g....gg',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Ttext(
                    title: 'Network',
                    titlediscripion: '0.000000176BTC(\$\1.01)',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Ttext extends StatelessWidget {
  const Ttext({
    Key? key,
    required this.title,
    required this.titlediscripion,
  }) : super(key: key);

  final String title;
  final String titlediscripion;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey,
              ),
        ),
        const Spacer(),
        Text(
          titlediscripion,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: MColors.white,
              ),
        ),
      ],
    );
  }
}




// Fetch transaction history


