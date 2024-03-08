import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:get/get.dart';

class ReviewSignaturePage extends StatelessWidget {
  final Uint8List signature;
  const ReviewSignaturePage({Key? key, required this.signature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () => saveSignature(context),
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
        title:
            const Text('Firma Obtenida', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Image.memory(signature),
      ),
    );
  }

  Future? saveSignature(BuildContext context) async {
    final status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    //making signature name unique
    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time';
    print(name);

    final result = await ImageGallerySaver.saveImage(signature, name: name);
    final isSuccessful = result['isSuccess'];

    if (isSuccessful) {
      Navigator.pop(context);
      Get.snackbar('Genial!', 'Se guardo la firma',
          backgroundColor: Colors.white, colorText: Colors.deepPurple);
    } else {
      Get.snackbar('Error', 'No se logro guardar la firma',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
