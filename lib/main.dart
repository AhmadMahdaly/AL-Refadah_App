import 'package:alrefadah/core/init/initializer.dart';
import 'package:alrefadah/presentation/app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  await initializeApp();

  runApp(const MyApp());
}
