
import 'package:flutter/material.dart';
import 'package:rastro_genetico2/screens/main_page.dart';
import 'package:rastro_genetico2/utils/utils.dart';
import 'package:window_manager/window_manager.dart';
import 'package:floor/floor.dart';
import 'dao/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  final callback = Callback(
    
    onCreate: (database, version) {
      Utils();
    },
  );

  final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').addCallback(callback).build();
  database.close;

  WindowOptions windowOptions = WindowOptions(
      windowButtonVisibility: true,
      center: true,
      size: Size(1200, 740),
      minimumSize: Size(1200, 740));
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    }
  );

  runApp(const RastroGeneticoApp());
}

class RastroGeneticoApp extends StatelessWidget {
  const RastroGeneticoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}