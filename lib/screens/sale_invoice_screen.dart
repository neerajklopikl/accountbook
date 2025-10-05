import 'package:flutter/material.dart';
import 'dart:math' as math;

class SaleInvoiceScreen extends StatelessWidget {
  const SaleInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/addSale');
            },
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            label: const Text(
              'Create New',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF0F2F5), // Light grey background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Filter clicked!')),
                      );
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // "All" and "E-Invoices" buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All clicked!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: const Text('All'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('E-Invoices clicked!')),
                    );
                  },
                  style: TextButton.styleFrom(
                     backgroundColor: Colors.white,
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                     padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  child: Text(
                    'E-Invoices',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Center content for creating the first invoice
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Custom illustration made with Flutter widgets
                CircleAvatar(
                  radius: 80,
                  backgroundColor: const Color(0xFFFAF3E0).withOpacity(0.7),
                  child: const Icon(
                    Icons.description_outlined,
                    size: 70,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Create your first Invoice',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Custom dotted arrow
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(
                    painter: DottedArrowPainter(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addSale');
                  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Create Invoice'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}


// Custom Painter to draw the curved, dotted arrow
class DottedArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 1.2, size.height * 0.4, // Control point
        size.width * 0.7, size.height * 0.9  // End point
    );

    // Draw the dotted line
    final dashWidth = 5;
    final dashSpace = 4;
    double distance = 0.0;
    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }

    // Draw arrowhead
    final arrowHeadPath = Path();
    arrowHeadPath.moveTo(size.width * 0.6, size.height * 0.75);
    arrowHeadPath.lineTo(size.width * 0.7, size.height * 0.9);
    arrowHeadPath.lineTo(size.width * 0.85, size.height * 0.78);
    canvas.drawPath(arrowHeadPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}