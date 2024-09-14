import 'package:character/screens/home.dart';
import 'package:character/services/character_store.dart';
import 'package:character/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( ChangeNotifierProvider(
    create: (context) => CharacterStore(),
    child: MaterialApp(
      theme: primarytheme,
      home: const Home(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class SandBox extends StatelessWidget {
  const SandBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SandBox'),
        backgroundColor: Colors.grey,
      ),
      body: const Text('SandBox'),
    );
  }
}