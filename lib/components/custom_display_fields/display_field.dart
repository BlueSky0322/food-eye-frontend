import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CustomDisplayField extends StatelessWidget {
  final String labelText;
  final String valueText;

  const CustomDisplayField({
    super.key,
    required this.labelText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Set the border radius here
        border: Border.all(
          color: appbar,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 55,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              color: Colors.blue.withOpacity(0.2),
            ),
            child: Container(
              width: 90,
              padding: const EdgeInsets.only(right: 8, left: 8),
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  end: BorderSide(
                    color: appbar,
                    width: 1.0,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  labelText,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                    color: primaryBG,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
              child: Text(
                valueText,
                maxLines: 5,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 16,
                  color: Colors.teal.shade500,
                ),
              ),
            ),
          )

          // Container(
          //   padding: const EdgeInsets.all(16),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Text(
          //       valueText,
          //       softWrap: true,
          //       overflow: TextOverflow.fade,
          //       style: TextStyle(
          //         fontFamily: 'Outfit',
          //         fontSize: 16,
          //         color: Colors.teal.shade500,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
