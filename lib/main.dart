import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/add_sale_screen.dart';
import 'screens/add_item_screen.dart';
import 'screens/item_settings_screen.dart';
import 'screens/add_purchase_screen.dart';
import 'screens/sale_report_screen.dart'; // Import new screen
import 'screens/purchase_report_screen.dart';
import 'screens/day_book_screen.dart';
import 'screens/all_transactions_screen.dart';
import 'screens/bill_wise_profit_screen.dart';
import 'screens/profit_loss_screen.dart';
import 'screens/cashflow_screen.dart';
import 'screens/balance_sheet_screen.dart';
import 'screens/trial_balance_screen.dart';
import 'screens/party_reports_screen.dart';
import 'screens/gst_reports_screen.dart';
import 'screens/stock_reports_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account Book Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1A237E), // A deep indigo
        scaffoldBackgroundColor: const Color(0xFFF0F2F5), // A light grey
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
          primary: const Color(0xFF1A237E),
          secondary: const Color(0xFF00BFA5), // Teal for accents
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/addSale': (context) => const AddSaleScreen(),
        '/addPurchase': (context) => const AddPurchaseScreen(),
        '/addItem': (context) => const AddItemScreen(),
        '/itemSettings': (context) => const ItemSettingsScreen(),
        '/saleReport': (context) => const SaleReportScreen(),
        '/purchaseReport': (context) => const PurchaseReportScreen(),
        '/dayBook': (context) => const DayBookScreen(),
        '/allTransactions': (context) => const AllTransactionsScreen(),
        '/billWiseProfit': (context) => const BillWiseProfitScreen(),
        '/profitLoss': (context) => const ProfitLossScreen(),
        '/cashflow': (context) => const CashflowScreen(),
        '/balanceSheet': (context) => const BalanceSheetScreen(),
        '/trialBalance': (context) => const TrialBalanceScreen(),
        '/partyReports': (context) => const PartyReportsScreen(),
        '/gstReports': (context) => const GstReportsScreen(),
        '/stockReports': (context) => const StockReportsScreen(),
      },
    );
  }
}