import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/customer_home_page_state.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/widgets/app_bar.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/widgets/grid_tile.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/widgets/preorder_popup.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/widgets/welcome_card.dart';
import 'package:food_eye_fyp/ui/customer/customer_home_page/settings_sidebar/settings_sidebar.dart';
import 'package:food_eye_fyp/ui/seller/products_page/products_page_state.dart';
import 'package:food_eye_fyp/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CustomerHomePageState>(context);
    return Scaffold(
      backgroundColor: pageBG,
      endDrawer: const SettingsSidebar(),
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              buildWelcomeCard(context, state.userEmail),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    mainAxisExtent: 350,
                  ),
                  itemCount: state.productsList.length,
                  itemBuilder: (context, index) {
                    final product = state.productsList[index];
                    return InkWell(
                      onTap: () {
                        log("tapped $index ${product.productId} ${product.sellerId}");
                      },
                      child: CustomGridTile(
                        product: product,
                        preorderButtonPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return PreorderPopup(
                                  state: state,
                                  product: product,
                                );
                              });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
