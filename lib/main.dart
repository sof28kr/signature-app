import 'package:flutter/material.dart';
import 'package:formulario_cite/pages/homepage.dart';
import 'package:get/get.dart';

void main() {
  runApp(const SignatureApp());
}

class SignatureApp extends StatelessWidget {
  const SignatureApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'App de Firma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}
