import 'package:flutter/material.dart';
import 'package:genesiswallet/utils/constants/colors.dart';
import 'package:genesiswallet/utils/http/models/transactionhistory.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../navigationmenu.dart';
import '../../../../utils/constants/api_constants.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _TransactionHistoryDetailsState();
}

class _TransactionHistoryDetailsState extends State<History> {
  late Future<List<Transaction>> futureTransactions;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Transaction>> fetchTransactions() async {
    final token = await getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('${APIConstants.baseUrl}/transaction-history'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
    } else {
      print('Failed to load transactions: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load transactions');
    }
  }

  @override
  void initState() {
    super.initState();
    futureTransactions = fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.to(() => const NavigationMenu()),
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
      body: SafeArea(
        child: FutureBuilder<List<Transaction>>(
          future: futureTransactions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange), // Use your custom color from MColors
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                'No transactions found',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: MColors.white, fontSize: 20),
              ));
            } else {
              final transactions = snapshot.data!;
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TransactionCard(transaction: transaction),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      color: MColors.subprimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  transaction.type == 'received'
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: transaction.type == 'received'
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  transaction.type.capitalizeFirst!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: MColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${transaction.coinAmount} ${transaction.fromAsset.symbol}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: MColors.white,
                        fontSize: 14,
                      ),
                ),
                Text(
                  '\$${transaction.dollarAmount}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: MColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'To: ${transaction.toAddress}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MColors.white,
                    fontSize: 12,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Date: ${transaction.date}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MColors.white,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
