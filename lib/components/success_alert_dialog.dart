import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomSuccessAlertDialog extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String description;

  const CustomSuccessAlertDialog({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: IntrinsicHeight(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  color: primaryBG,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.green,
                    fontFamily: 'Outfit',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontFamily: 'Outfit',
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                description,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
