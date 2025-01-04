import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:book_heaven/blocs/home/home_bloc.dart';
import 'package:book_heaven/blocs/home/home_event.dart';
import 'package:book_heaven/blocs/home/home_state.dart';
import 'package:book_heaven/model/product_model.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<Map<String, dynamic>> _loadJson() async {
    String data = await rootBundle.loadString('assets/data/products.json');
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else {
          final jsonData = snapshot.data!;
          return BlocProvider(
            create: (context) => HomeBloc()..add(LoadHomeDataEvent(jsonData: jsonData)),
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
              body: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoadedState) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSpecialOfferSection(context, state.specialOffer),
                          const SizedBox(height: 20),

                          _buildSectionHeader('Top of Week'),
                          const SizedBox(height: 10),

                          _buildTopOfWeekSection(context, state.topOfWeek),
                          const SizedBox(height: 20),

                          _buildSectionHeader('Best Vendors'),
                          const SizedBox(height: 10),

                          _buildVendorsSection(context, state.vendors),
                          const SizedBox(height: 20),

                          _buildSectionHeader('Authors'),
                          const SizedBox(height: 10),
                          _buildAuthorsSection(context, state.authors),
                        ],
                      ),
                    );
                  } else if (state is HomeErrorState) {
                    return Center(child: Text(state.error));
                  } else {
                    return const Center(child: Text('Unknown state'));
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSpecialOfferSection(BuildContext context, Map<String, dynamic> offer) {
    final product = Product.fromJson(offer);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer['title'],
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 22 : 18, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  offer['description'],
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 16, 
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/product_details',
                      arguments: product, 
                    );
                  },
                  child: const Text('Order Now'),
                ),
              ],
            ),
          ),
          Image.asset(
            offer['image'],
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See all'),
        ),
      ],
    );
  }

  Widget _buildTopOfWeekSection(BuildContext context, List<dynamic> books) {
    return SizedBox(
      height: 200, 
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              final product = Product.fromJson(book);
              Navigator.pushNamed(
                context,
                '/product_details',
                arguments: product, 
              );
            },
            child: Column(
              children: [
                Image.asset(
                  book['image'],
                  width: MediaQuery.of(context).size.width > 600 ? 120 : 100, 
                  height: MediaQuery.of(context).size.width > 600 ? 120 : 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 5),
                Text(
                  book['title'],
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14, 
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  book['price'],
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14, 
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVendorsSection(BuildContext context, List<dynamic> vendors) {
    return SizedBox(
      height: 100, 
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: vendors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ClipOval(
            child: Image.asset(
              vendors[index]['image'],
              width: MediaQuery.of(context).size.width > 600 ? 90 : 80, 
              height: MediaQuery.of(context).size.width > 600 ? 90 : 80, 
              fit: BoxFit.cover, 
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuthorsSection(BuildContext context, List<dynamic> authors) {
    return SizedBox(
      height: 200, 
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: authors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final author = authors[index];
          return Column(
            children: [
              ClipOval(
                child: Image.asset(
                  author['image'],
                  width: MediaQuery.of(context).size.width > 600 ? 120 : 100, 
                  height: MediaQuery.of(context).size.width > 600 ? 120 : 100, 
                  fit: BoxFit.cover, 
                ),
              ),
              const SizedBox(height: 5),
              Text(
                author['name'],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14, 
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                author['role'],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 14 : 12, 
                  color: Colors.grey,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
