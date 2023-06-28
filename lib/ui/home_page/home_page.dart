import 'package:flutter/material.dart';
import 'package:food_eye_fyp/components/list_tile.dart';
import 'package:food_eye_fyp/ui/home_page/home_page_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import '../../data/model/item.dart';
import '../../data/model/item.dart';
import '../../utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomePageState>(context);
    return Scaffold(
      backgroundColor: pageBG,
      appBar: AppBar(
        backgroundColor: appbar,
        elevation: 1,
        toolbarHeight: 70,
        title: Row(
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: primaryBG,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                // Perform avatar icon action
              },
              icon: Container(
                width: 65,
                height: 65,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/card-bg-1.png',
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You have ${state.expItemCount} items \nthat are still fresh!",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text.rich(
                          TextSpan(
                              text: "Enjoy by   ",
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: DateFormat('dd/MM/yyyy')
                                      .format(state.nearestExpDate),
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 29, 214, 106),
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text("data"),
          Expanded(
            child: ListView.builder(
              itemCount: state.itemList.length,
              itemBuilder: (context, index) {
                final item = state.itemList[index];
                return CustomListTile(
                  item: item,
                );
                // return ListTile(
                //   leading: item.imagePath != null
                //       ? Image.asset(item.imagePath!)
                //       : const SizedBox.shrink(),
                //   title: Text(item.itemName ?? ''),
                //   subtitle: Text('Quantity: ${item.quantity}'),
                //   trailing: Text(
                //       'Expires on: ${DateFormat('yyyy-MM-dd').format(item.dateExpiresOn!)}'),
                // );
              },
            ),
          )
        ],
      ),
    );
  }
}
