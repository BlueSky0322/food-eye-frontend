import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_eye_fyp/components/product_list_tile.dart';
import 'package:food_eye_fyp/data/request_response_model/product_response.dart';
import 'package:food_eye_fyp/ui/seller/add_product_page/add_product.dart';
import 'package:food_eye_fyp/ui/seller/add_product_page/add_product_state.dart';
import 'package:food_eye_fyp/ui/seller/edit_product_page/edit_product.dart';
import 'package:food_eye_fyp/ui/seller/edit_product_page/edit_product_state.dart';
import 'package:food_eye_fyp/ui/seller/products_detail_page/products_detail_page.dart';
import 'package:food_eye_fyp/ui/seller/products_detail_page/products_detail_page_state.dart';
import 'package:food_eye_fyp/ui/seller/products_page/products_page_state.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductsPageState>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => AddProductState(context),
                child: const AddProductPage(),
              ),
            ),
          ).then((shouldUpdate) {
            if (shouldUpdate == true) {
              state.loadProducts();
            }
          });
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: Colors.teal.shade100,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        tooltip: "Add Items",
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.my_library_add_rounded,
          color: appbarText,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: pageBG,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: appbar,
        elevation: 6,
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          "Products",
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: appbarText,
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(22, 12, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "All Products",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryBG,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryBG,
                        width: 2.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 12.0,
                      backgroundColor: Colors.transparent,
                      child: Text(
                        state.productsList.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryBG,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      state.showSortingOptions(context);
                    },
                    child: Text(
                      "Sort by: ${state.sortByOption}",
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryBG,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      state.toggleSortingOrder();
                    },
                    icon: Transform.rotate(
                      angle: 90 *
                          3.1415927 /
                          180, // Rotate by 90 degrees (in radians)
                      child: Icon(
                        !state.isDescending.value
                            ? Icons.switch_left_rounded
                            : Icons.switch_right_rounded,
                        size: 30,
                      ),
                    ),
                    color: primaryBG,
                  )
                ],
              ),
            ),
            FutureBuilder<List<ProductResponse>>(
              future: state.reloadProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16.0),
                          Text(
                            'Loading Products...',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data?.isEmpty ?? true) {
                  return Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/images/empty-list.png'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Your list is currently empty! ",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (context) =>
                                        AddProductState(context),
                                    child: const AddProductPage(),
                                  ),
                                ),
                              ).then((shouldUpdate) {
                                if (shouldUpdate == true) {
                                  state.loadProducts();
                                }
                              });
                            },
                            child: const Text(
                              "Add some products",
                              style: TextStyle(
                                color: primaryBG,
                                fontSize: 16,
                                fontFamily: 'Outfit',
                                decoration: TextDecoration.underline,
                                decorationColor: primaryBG,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  final sortedItems = state.sortItems(snapshot.data!,
                      state.isDescending.value, state.sortByOption);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: sortedItems.length,
                      itemBuilder: (context, index) {
                        final item = sortedItems[index];
                        return ValueListenableBuilder<bool>(
                          valueListenable: state.isDescending,
                          builder: (context, isDescending, _) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                      create: (context) => ProductDetailState(
                                          sortedItems[index]),
                                      child: const ProductDetail(),
                                    ),
                                  ),
                                );
                              },
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: appbar,
                                      icon: Icons.edit,
                                      label: "Edit",
                                      onPressed: (context) {
                                        Navigator.push<bool>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                              create: (context) =>
                                                  EditProductState(
                                                      context, item.productID!),
                                              child: const EditProductPage(),
                                            ),
                                          ),
                                        ).then((shouldUpdate) {
                                          if (shouldUpdate == true) {
                                            state.loadProducts();
                                          }
                                        });
                                      },
                                    ),
                                    SlidableAction(
                                      backgroundColor: Colors.red.shade700,
                                      icon: Icons.delete_outline_rounded,
                                      label: "Delete",
                                      onPressed: (context) {
                                        state.deleteProduct(item.productID!);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            showCloseIcon: true,
                                            duration:
                                                const Duration(seconds: 2),
                                            content: Text(
                                                "Product '${item.productName}' deleted successfully!"),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                child: CustomListTile(product: item),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ]),
    );
  }
}
