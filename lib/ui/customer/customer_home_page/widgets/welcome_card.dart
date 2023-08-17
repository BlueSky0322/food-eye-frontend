import 'package:flutter/material.dart';

Widget buildWelcomeCard(BuildContext context, String userEmail) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
    child: Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/card-bg.png',
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
                const Text(
                  "Welcome back,",
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.teal.shade200,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.teal.shade500,
                  ),
                  child: Text(
                    "${userEmail}",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Browse all the products\nfrom a variety of sellers!",
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                    color: Colors.grey.shade600,
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
