import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:formulario_cite/pages/signaturePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SignatureController? controller;

  @override
  void initState() {
    // we initialize the signature controller
    controller = SignatureController(penStrokeWidth: 6, penColor: Colors.white);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: controller!,
              backgroundColor: Colors.deepPurple,
            ),
          ),
          buttonWidgets(context)!,
          buildSwapOrientation(context)!,
        ],
      ),
    );
  }

  Widget? buildSwapOrientation(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;

        controller!.clear();

        setOrientation(newOrientation);
      },
      child: Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'Click para rotar la pantalla',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Widget? buttonWidgets(BuildContext context) => Container(
        color: Colors.deepPurple,
        child: Padding(
          padding: EdgeInsetsDirectional.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            //boton de guardado
            ElevatedButton.icon(
                onPressed: () async {
                  if (controller!.isNotEmpty) {
                    final signature = await exportSignature();

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) =>
                            ReviewSignaturePage(signature: signature!)),
                      ),
                    );

                    controller!.clear();
                  }
                },
                label: const Text('Guardar Firma'),
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                )),
            //boton de eliminar
            ElevatedButton.icon(
                onPressed: () {
                  controller!.clear();
                },
                label: const Text('Borrar'),
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                )),
          ]),
        ),
      );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      points: controller!.points,
    );

    final signature = exportController.toPngBytes();

    //clean up the memory
    exportController.dispose();

    return signature;
  }
}
