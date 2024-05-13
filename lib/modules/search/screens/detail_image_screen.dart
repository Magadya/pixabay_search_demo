import 'package:flutter/material.dart';

import '../models/image_model.dart';

class DetailImageScreen extends StatelessWidget {
  final ImageModel imageModel;

  const DetailImageScreen({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child:SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageModel.webFormatURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
