// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/add_sale_screen.dart';
import 'screens/add_item_screen.dart';
import 'screens/item_settings_screen.dart';
import 'screens/add_purchase_screen.dart';
import 'screens/sale_report_screen.dart';
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
import 'screens/transaction_settings_screen.dart';
import 'screens/payment_in_screen.dart';
import 'screens/sale_return_screen.dart';
import 'screens/delivery_challan_screen.dart';
import 'screens/estimate_quote_screen.dart';
import 'screens/sale_order_screen.dart';
import 'screens/sale_invoice_screen.dart';
import 'screens/payment_out_screen.dart';
import 'screens/purchase_return_screen.dart';
import 'screens/purchase_order_screen.dart';
import 'screens/expense_screen.dart';
import 'screens/other_income_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/stock_dashboard_screen.dart';
import 'screens/stock_summary_screen.dart';
import 'screens/e_invoice_login_screen.dart';
import 'screens/quotation_list_screen.dart';
import 'screens/quotation_filters_screen.dart';
import 'screens/p2p_transfer_screen.dart'; // Import the new screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AccountBook',
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
        '/quotationList': (context) => const QuotationListScreen(),
        '/quotationFilters': (context) => const QuotationFiltersScreen(),
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
        '/settings': (context) => const SettingsScreen(),
        '/stockDashboard': (context) => const StockDashboardScreen(),
        '/stockSummary': (context) => const StockSummaryScreen(),
        '/txnSettings': (context) => const TransactionSettingsScreen(),
        '/paymentIn': (context) => const PaymentInScreen(),
        '/saleReturn': (context) => const SaleReturnScreen(),
        '/deliveryChallan': (context) => const DeliveryChallanScreen(),
        '/estimateQuote': (context) => const EstimateQuoteScreen(),
        '/saleOrder': (context) => const SaleOrderScreen(),
        '/saleInvoice': (context) => const SaleInvoiceScreen(),
        '/paymentOut': (context) => const PaymentOutScreen(),
        '/purchaseReturn': (context) => const PurchaseReturnScreen(),
        '/purchaseOrder': (context) => const PurchaseOrderScreen(),
        '/expense': (context) => const ExpenseScreen(),
        '/otherIncome': (context) => const OtherIncomeScreen(),
        '/eInvoiceLogin': (context) => const EInvoiceLoginScreen(),
        '/p2pTransfer': (context) => const P2PTransferScreen(), // Add new route
      },
    );
  }
}