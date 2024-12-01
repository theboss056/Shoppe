import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final dynamic product;
  final Function(dynamic) addToCart; // Callback function to add to cart
  final int cartCount; // Current cart count
  final VoidCallback openCart; // Callback to open the cart screen

  ProductDetailsScreen({
    required this.product,
    required this.addToCart,
    required this.cartCount,
    required this.openCart,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the discounted price
    final discountedPrice =
        product['price'] * (1 - (product['discountPercentage'] / 100));

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
        title:
            Text(product['title'], style: TextStyle(fontFamily: 'Quicksand')),
        actions: [
          // Cart icon with item count
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$cartCount',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: openCart, // Open the cart screen
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.network(
                product['thumbnail'],
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Product Title
            Text(
              product['title'],
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Product Price
            Text(
              '₹${discountedPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 8),
            // Product Description
            Text(
              product['description'],
              style: TextStyle(fontFamily: 'Quicksand', fontSize: 16),
            ),
            Spacer(),
            // Add to Cart Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  addToCart(product); // Add product to cart
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product['title']} added to cart!'),
                    ),
                  );
                },
                child: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey.shade900, // Text color
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15), // Padding
                  elevation: 5, // Shadow elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                // style: ElevatedButton.styleFrom(
                //   minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
