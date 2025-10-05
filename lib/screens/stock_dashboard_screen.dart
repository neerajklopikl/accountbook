import 'package:flutter/material.dart';
import '../models/feature_item_model.dart';
import '../widgets/feature_grid_item.dart';

class StockDashboardScreen extends StatelessWidget {
  const StockDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.storefront, color: Colors.white),
        title: const Text('Enter Company...'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildQuickLinks(context),
          const SizedBox(height: 16),
          _buildStockItemCard(context),
        ],
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickLinkItem(
                context, Icons.store_outlined, 'Online Store', () {}),
            _buildQuickLinkItem(context, Icons.summarize_outlined, 'Stock Sum...',
                () => Navigator.pushNamed(context, '/stockSummary')),
            _buildQuickLinkItem(context, Icons.settings_outlined, 'Item Settin...',
                () => Navigator.pushNamed(context, '/itemSettings')),
            _buildQuickLinkItem(
                context, Icons.more_horiz, 'Show All', () => _showMoreOptionsSheet(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinkItem(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildStockItemCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mango',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sale Price'),
                    Text('₹ 0.00',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Purchase Price'),
                    Text('₹ 0.00',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('In Stock'),
                    Text('0.0',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final moreOptions = [
          FeatureItemModel(
              icon: Icons.file_upload,
              title: 'Import Items',
              color: Colors.blue),
          FeatureItemModel(
              icon: Icons.file_download,
              title: 'Export Items',
              color: Colors.green),
          FeatureItemModel(
              icon: Icons.stacked_line_chart,
              title: 'Item wise PnL',
              color: Colors.orange),
          FeatureItemModel(
              icon: Icons.add_circle_outline,
              title: 'Additional Fields',
              color: Colors.purple),
          FeatureItemModel(
              icon: Icons.info_outline,
              title: 'Item Details',
              color: Colors.teal),
          FeatureItemModel(
              icon: Icons.inventory,
              title: 'Low Stock Sum...',
              color: Colors.red),
        ];

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('More Options',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                itemCount: moreOptions.length,
                itemBuilder: (context, index) {
                  final item = moreOptions[index];
                  Widget gridItem = FeatureGridItem(item: item, onTap: () {});
                  if (item.title == 'Additional Fields') {
                    gridItem = Stack(
                      children: [
                        gridItem,
                        const Positioned(
                          top: 4,
                          right: 4,
                          child: Icon(Icons.workspace_premium, color: Colors.amber, size: 16),
                        )
                      ],
                    );
                  }
                  return gridItem;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}