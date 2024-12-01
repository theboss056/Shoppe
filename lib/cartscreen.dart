import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<dynamic> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = [];
    for (var product in widget.cartItems) {
      addToCart(product);
    }
  }

  // Function to handle quantity changes
  void updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  // Function to handle adding an item to the cart
  void addToCart(dynamic product) {
    setState(() {
      final existingItemIndex =
          cartItems.indexWhere((item) => item.title == product['title']);
      if (existingItemIndex >= 0) {
        cartItems[existingItemIndex].quantity++;
      } else {
        cartItems.add(CartItem.fromProduct(product));
      }
    });
  }

  // Function to calculate the total price
  double calculateTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Function to count total number of items
  int totalItemsInCart() {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
        title: Text('Cart (${totalItemsInCart()})'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Prevent nested scrolling
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 0.0),
                        child: Card(
                          child: ListTile(
                            tileColor: Colors.orange.shade200,
                            leading: Image.network(
                              item.thumbnail,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.title),
                            subtitle: Text('₹${item.price.toStringAsFixed(2)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    updateQuantity(index, item.quantity - 1);
                                  },
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    updateQuantity(index, item.quantity + 1);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total Price: ₹${calculateTotalPrice().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Proceeding to checkout...'),
                              ),
                            );
                          },
                          child: Text(
                            'Checkout (${totalItemsInCart()} items)',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey.shade900, // Text color
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15), // Padding
                            elevation: 5, // Shadow elevation
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// CartItem model to manage each item in the cart
class CartItem {
  final String title;
  final String thumbnail;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  // Factory constructor to create a CartItem from a product
  factory CartItem.fromProduct(dynamic product) {
    return CartItem(
      title: product['title'],
      thumbnail: product['thumbnail'],
      price: product['price'],
      quantity: 1, // Default quantity is 1
    );
  }
}
