import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SignatureController? controller;
  @override
  void initState() {
    //propiedades del controlador de la firma
    controller = SignatureController(
        penStrokeWidth: 6,
        penColor: Colors.purple,
        exportBackgroundColor: Colors.transparent);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // botones de ok and close
  Widget? buttonWidgets(BuildContext context) => Container(
        color: Colors.teal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              iconSize: 40,
              color: Colors.white,
              icon: const Icon(Icons.check),
            ),
            IconButton(
              onPressed: () {
                controller!.clear();
              },
              iconSize: 40,
              color: Colors.white,
              icon: const Icon(Icons.check),
            )
          ],
        ),
      );

  // pasa la firma a un png

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.transparent,
      penColor: Colors.black,
      points: controller!.points,
    );
    // convierte la firma en un png
    final signature = exportController.toPngBytes();
    // limpiamos memoria
    exportController.dispose();
    return signature;
  }
}
