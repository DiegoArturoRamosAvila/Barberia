import 'package:barberia/viewmodel/barberiaViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'viewmodel/clienteViewModel.dart';
import 'viewmodel/barberoViewModel.dart';
import 'viewmodel/servicioViewModel.dart';
import 'firebase_options.dart';
import 'view/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ClienteViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => BarberiViewModel(), // Añadido el Provider para BarberiaViewModel
        ),
        ChangeNotifierProvider(
          create: (_) => Barberoviewmodel(), // Añadido el Provider para BarberiaViewModel
        ),
        ChangeNotifierProvider(
          create: (_) => Servicioviewmodel(), // Añadido el Provider para BarberiaViewModel
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barbería App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
