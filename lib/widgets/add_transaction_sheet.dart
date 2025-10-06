import 'package:flutter/material.dart';

class AddTransactionSheet extends StatelessWidget {
  const AddTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'Sale Transactions'),
            const SizedBox(height: 16),
            _buildTransactionGrid([
              _TransactionGridItem(
                  icon: Icons.download_sharp,
                  label: 'Payment-In',
                  onTap: () =>
                      Navigator.pushNamed(context, '/paymentIn')),
              _TransactionGridItem(
                  icon: Icons.refresh,
                  label: 'Sale Return',
                  onTap: () =>
                      Navigator.pushNamed(context, '/saleReturn')),
              _TransactionGridItem(
                  icon: Icons.local_shipping,
                  label: 'Delivery Challan',
                  onTap: () => Navigator.pushNamed(
                      context, '/deliveryChallan')),
              _TransactionGridItem(
                  icon: Icons.request_quote,
                  label: 'Estimate/Quot...',
                  onTap: () =>
                      Navigator.pushNamed(context, '/estimateQuote')),
              _TransactionGridItem(
                  icon: Icons.list_alt,
                  label: 'Sale Order',
                  onTap: () => Navigator.pushNamed(context, '/saleOrder')),
              _TransactionGridItem(
                  icon: Icons.receipt,
                  label: 'Sale Invoice',
                  onTap: () =>
                      Navigator.pushNamed(context, '/saleInvoice')),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Purchase Transactions'),
            const SizedBox(height: 16),
            _buildTransactionGrid([
              _TransactionGridItem(
                  icon: Icons.shopping_cart,
                  label: 'Purchase',
                  onTap: () =>
                      Navigator.pushNamed(context, '/addPurchase')),
              _TransactionGridItem(
                  icon: Icons.upload_sharp,
                  label: 'Payment-Out',
                  onTap: () =>
                      Navigator.pushNamed(context, '/paymentOut')),
              _TransactionGridItem(
                  icon: Icons.refresh_sharp,
                  label: 'Purchase Return',
                  onTap: () => Navigator.pushNamed(
                      context, '/purchaseReturn')),
              _TransactionGridItem(
                  icon: Icons.list_alt_sharp,
                  label: 'Purchase Order',
                  onTap: () =>
                      Navigator.pushNamed(context, '/purchaseOrder')),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Other Transactions'),
            const SizedBox(height: 16),
            _buildTransactionGrid([
              _TransactionGridItem(
                  icon: Icons.wallet_travel,
                  label: 'Expenses',
                  onTap: () => Navigator.pushNamed(context, '/expense')),
              _TransactionGridItem(
                  icon: Icons.people_alt,
                  label: 'P2P Transfer',
                  onTap: () =>
                      Navigator.pushNamed(context, '/p2pTransfer')),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTransactionGrid(List<_TransactionGridItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}

class _TransactionGridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TransactionGridItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.grey[700]),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}