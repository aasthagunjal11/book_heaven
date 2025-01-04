import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_heaven/model/product_model.dart';
import 'package:book_heaven/blocs/product_details/product_details_bloc.dart';
import 'package:book_heaven/blocs/product_details/product_details_event.dart';
import 'package:book_heaven/blocs/product_details/product_details_state.dart';
import 'package:book_heaven/blocs/shopping_bag/shopping_bag_bloc.dart';
import 'package:book_heaven/blocs/shopping_bag/shopping_bag_event.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product?;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Product details not available.")),
      );
    }

    return BlocProvider(
      create: (context) =>
          ProductDetailsBloc()..add(LoadProductDetailsEvent(product)),
      child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsLoadedState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Book Heaven"),
                centerTitle: true,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          state.product.image,
                          width: double.infinity,
                          height: 250, 
                          fit: BoxFit.contain, 
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              state.product.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "GoodDay",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.product.description,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            "Review",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(5, (index) {
                              if (index < 4) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                );
                              } else {
                                return const Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                );
                              }
                            }),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "4.0",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductDetailsBloc>()
                                      .add(DecrementQuantityEvent());
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                "${state.quantity}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductDetailsBloc>()
                                      .add(IncrementQuantityEvent());
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                          Text(
                            "\$${(state.product.price * state.quantity).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<ShoppingBagBloc>().add(
                                  AddToBagEvent(state.product, state.quantity),
                                );
                                Navigator.pushNamed(context, '/shopping_bag'); 
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Add to bag",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<ShoppingBagBloc>().add(
                                  AddToBagEvent(state.product, state.quantity),
                                );
                                Navigator.pushNamed(context, '/shopping_bag');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ProductDetailsErrorState) {
            return const Center(child: Text('Failed to load product details'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
