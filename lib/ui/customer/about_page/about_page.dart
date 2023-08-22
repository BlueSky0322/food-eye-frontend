import 'package:flutter/material.dart';
import 'package:food_eye_fyp/utils/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "About FoodEye",
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: appbarText,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(
                        'assets/images/splash-page-logo.png',
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
                    color: primaryBG,
                  ),
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    """Provide mobile application solution for convenient managing of raw materials (for sellers)
                      \nExpiry date tracking to remind users when items are expiring
                      \nBetter inventory management can lead to cost savings, which improves sustainability of businesses in this industry
                      \nContribute to a more sustainable food system (better consumer-seller interaction)
                      \nProvide a simple mobile platform sellers to promote their products. And for customers to view and pre-order local kuih-muih
                      \nPromote responsible food consumption practices
                      """,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 16,
                      color: primaryBG,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
