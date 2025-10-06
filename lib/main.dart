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
import 'screens/p2p_transfer_screen.dart';
// NEW: Import new screens for the updated UI
import 'screens/create_invoice_screen.dart';
import 'screens/create_purchase_screen.dart';
import 'screens/upload_bill_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // UPDATED: Complete theme overhaul for a modern and beautiful UI
    return MaterialApp(
      title: 'AccountBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF0052D4),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0052D4),
          primary: const Color(0xFF0052D4), // Professional Blue
          secondary: const Color(0xFF00BFA5), // Vibrant Teal for accents/FAB
          background: const Color(0xFFF8F9FA),
          onBackground: const Color(0xFF212529),
          surface: Colors.white,
          onSurface: const Color(0xFF212529),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FA),
          foregroundColor: Color(0xFF212529),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212529),
          ),
        ),
        cardTheme: CardThemeData( // FIX: Changed CardTheme to CardThemeData
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0052D4),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w800),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.4),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.3),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
      ),
      initialRoute: '/',
      routes: {
        // UPDATED: Added new routes for the improved UI flow
        '/': (context) => const MainScreen(),
        '/createInvoice': (context) => const CreateInvoiceScreen(),
        '/createPurchase': (context) => const CreatePurchaseScreen(),
        '/uploadBill': (context) => const UploadBillScreen(),
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
        '/p2pTransfer': (context) => const P2PTransferScreen(),
      },
    );
  }
}