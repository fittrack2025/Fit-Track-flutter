import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Products(),
    );
  }
}

class Products extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'name': 'Whey Protein',
      'price': '\$49.99',
      'image': 'https://example.com/whey.jpg',
      'link': 'https://example.com/buy-whey',
    },
    {
      'name': 'Creatine',
      'price': '\$19.99',
      'image': 'https://example.com/creatine.jpg',
      'link': 'https://example.com/buy-creatine',
    },
    {
      'name': 'Oats',
      'price': '\$4.99',
      'image': 'https://example.com/oats.jpg',
      'link': 'https://example.com/buy-oats',
    },
  ];

  // Corrected method to launch a URL using url_launcher
  void _launchBuyLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(product['image']!),
              title: Text(product['name']!),
              subtitle: Text(product['price']!),
              trailing: ElevatedButton(
                onPressed: () => _launchBuyLink(product['link']!),
                child: const Text('Buy Now'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ),
          );
        },
      ),
    );
  }
}
