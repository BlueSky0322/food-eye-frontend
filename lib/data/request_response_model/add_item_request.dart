class AddItemRequest {
  final String? itemName;
  final String? itemType;
  final int quantity;
  final DateTime? datePurchased;
  final DateTime? dateExpiresOn;
  String? imagePath;
  final String? storedAt;
  final String? description;
  final String? userId;

  AddItemRequest({
    required this.itemName,
    required this.itemType,
    required this.quantity,
    required this.datePurchased,
    required this.dateExpiresOn,
    this.imagePath,
    required this.storedAt,
    required this.description,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemType': itemType,
      'quantity': quantity,
      'datePurchased': datePurchased?.toIso8601String(),
      'dateExpiresOn': dateExpiresOn?.toIso8601String(),
      'storedAt': storedAt,
      'description': description,
      'userId': userId,
    };
  }
}
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';

// class AddItemRequest {
//   final String? itemName;
//   final String? itemType;
//   final int quantity;
//   final DateTime? datePurchased;
//   final DateTime? dateExpiresOn;
//   final File? imageFile; // Add File type for the image file
//   final String? storedAt;
//   final String? description;
//   final String? userId;

//   AddItemRequest({
//     required this.itemName,
//     required this.itemType,
//     required this.quantity,
//     required this.datePurchased,
//     required this.dateExpiresOn,
//     this.imageFile, // Add imageFile parameter
//     required this.storedAt,
//     required this.description,
//     required this.userId,
//   });

//   Future<http.MultipartRequest> toMultipartRequest(String url) async {
//     final request = http.MultipartRequest('POST', Uri.parse(url));

//     // Add fields to the request body
//     request.fields['itemName'] = itemName!;
//     request.fields['itemType'] = itemType!;
//     request.fields['quantity'] = quantity.toString();
//     request.fields['datePurchased'] = datePurchased?.toIso8601String() ?? '';
//     request.fields['dateExpiresOn'] = dateExpiresOn?.toIso8601String() ?? '';
//     request.fields['storedAt'] = storedAt!;
//     request.fields['description'] = description!;
//     request.fields['userId'] = userId!;

//     // Add the image file to the request body
//     if (imageFile != null) {
//       final imageStream = http.ByteStream(imageFile!.openRead());
//       final imageLength = await imageFile!.length();

//       final imageUpload = http.MultipartFile(
//         'image', // Field name for the image in the request
//         imageStream,
//         imageLength,
//         filename: imageFile!.path
//             .split('/')
//             .last, // Use the file name as the filename
//         contentType: MediaType('image',
//             'jpeg'), // Change the content type based on your image type
//       );

//       request.files.add(imageUpload);
//     }

//     return request;
//   }}

