import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 1. Add a Product model to match the backend schema
class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(), // Safely parse number
    );
  }
}

// 2. Convert to a StatefulWidget to manage state
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  // 3. Create a function to fetch data from the backend
  Future<List<Product>> _fetchProducts() async {
    // For Android emulator, use 10.0.2.2 to access localhost
    // For iOS simulator or a real device, use your computer's local IP address
    final response = await http.get(Uri.parse('http://10.0.2.2:5001/api/products'));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body);
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Product'),
        // Optional: Add a button to add new products
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to an 'Add Product' screen
            },
          ),
        ],
      ),
      // 4. Use a FutureBuilder to handle loading and displaying the data
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            if (products.isEmpty) {
              return const Center(child: Text('No products found.'));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Price: ₹${product.price.toStringAsFixed(2)}'),
                  onTap: () {
                    // Return the selected product to the previous screen
                    Navigator.pop(context, product);
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }
}
