import 'package:flutter/material.dart';
import '../utils/constants.dart';

class InputSelectionDailog extends StatelessWidget {
  //final String imageAsset;
  final VoidCallback? trOnPressed;
  final VoidCallback? dpOnPressed;

  const InputSelectionDailog({
    super.key,
    this.dpOnPressed,
    this.trOnPressed,
    //required this.imageAsse
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Choose Option",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: primaryBG,
          fontFamily: 'Outfit',
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Select how to enter the expiry date",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.teal.shade700,
          fontFamily: 'Outfit',
          fontSize: 14,
        ),
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 0); // Option for text recognition
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    elevation: 5,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: 6,
                      // ),
                      Icon(
                        Icons.text_fields_rounded,
                        color: primaryBG,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Text Recognition",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 1); // Option for date picker
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: 6,
                      // ),
                      Icon(
                        Icons.calendar_month,
                        color: primaryBG,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Date Picker",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
