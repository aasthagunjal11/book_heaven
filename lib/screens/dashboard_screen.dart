import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? _dashboardData;

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/products.json');
      setState(() {
        _dashboardData = json.decode(jsonString);
      });
    } catch (error) {
      print('Error loading JSON: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dashboardData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth > 600 ? 40 : 20;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSpecialOfferSection(),
              const SizedBox(height: 40),
              _buildSectionHeader("Top of Week"),
              _buildHorizontalList(_dashboardData!['topOfWeek'], _buildBookCard),
              const SizedBox(height: 40),
              _buildSectionHeader("Best Vendors"),
              _buildHorizontalList(_dashboardData!['vendors'], _buildVendorCard),
              const SizedBox(height: 0),
              _buildSectionHeader("Authors"),
              _buildHorizontalList(_dashboardData!['authors'], _buildAuthorCard),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSpecialOfferSection() {
    final specialOffer = _dashboardData!['specialOffer'];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: specialOffer),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset(
              specialOffer['image'],
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    specialOffer['title'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(specialOffer['description']),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(product: specialOffer),
                        ),
                      );
                    },
                    child: const Text("Order Now"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHorizontalList(List<dynamic> data, Widget Function(Map<String, dynamic>) itemBuilder) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 30),
            child: itemBuilder(data[index]),
          );
        },
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: book),
          ),
        );
      },
      child: Column(
        children: [
          Image.asset(
            book['image'],
            width: 150,
            height: 175,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(book['title'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          Text(book['price'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildVendorCard(Map<String, dynamic> vendor) {
    return GestureDetector(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(vendor['image']),
            radius: 70,
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorCard(Map<String, dynamic> author) {
    return GestureDetector(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(author['image']),
            radius: 70,
          ),
          const SizedBox(height: 16),
          Text(author['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(author['role'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
