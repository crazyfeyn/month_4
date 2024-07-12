import 'package:flutter/material.dart';
import 'package:flutter_application/cubits/shop_cubit.dart';
import 'package:flutter_application/cubits/shop_state.dart';
import 'package:flutter_application/cubits/theme_mode.dart';
import 'package:flutter_application/views/widgets/add_product.dart';
import 'package:flutter_application/views/widgets/edit_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<ShopCubit>().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ShopCubit>();
    final themeModeController = context.read<CubitThemeMode>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shop with cubit'),
        actions: [
          IconButton(
              onPressed: () {
                themeModeController.toggleThemeMode();
              },
              icon: themeModeController.state
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode))
        ],
      ),
      body: BlocBuilder<ShopCubit, ShopState>(builder: (context, state) {
        if (state is InitialState) {
          return const Center(
            child: Text("Ma'lumot hali yuklanmadi"),
          );
        }
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        final products = (state as LoadedState).products;

        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(products[index].title),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(products[index].price.toString()),
                              IconButton(
                                  onPressed: () {
                                    controller
                                        .deleteProduct(products[index].id);
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.delete, color: Colors.red))
                            ],
                          ),
                        );
                      });
                },
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return EditDialog(
                            id: products[index].id,
                            title: products[index].title,
                            price: products[index].price.toString(),
                            imageUrl: products[index].imageUrl);
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        products[index].imageUrl,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(products[index].title),
                          IconButton(
                              onPressed: () {
                                controller.toggleFavorite(products[index].id);
                              },
                              icon: products[index].isFavorite
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_outline))
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const Addproduct();
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
