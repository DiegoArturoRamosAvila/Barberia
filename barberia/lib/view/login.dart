import 'package:barberia/view/menu_registros.dart';
import 'package:barberia/view/menu.dart';
import 'package:barberia/view/barbero_menu.dart';
import 'package:barberia/view/pantalla_opciones.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _clearFields(); // Limpia los controladores al inicializar el widget
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Limpia los campos del formulario
  void _clearFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  /// Inicia sesión y valida el tipo de usuario
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final uid = userCredential.user?.uid;

      if (uid != null) {
        await _validateUserType(uid);
      } else {
        _showErrorDialog("Error: No se pudo obtener el UID del usuario.");
      }
    } catch (e) {
      _showErrorDialog("Error al iniciar sesión: ${e.toString()}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Valida si el usuario pertenece a la colección "clientes" o "barberías"
  Future<void> _validateUserType(String uid) async {
    try {
      final clienteSnapshot = await _firestore.collection('Clientes').doc(uid).get();
      final barberiaSnapshot = await _firestore.collection('Barberias').doc(uid).get();
      final barberoSnapshot = await _firestore.collection('Barberos').doc(uid).get();

      if (clienteSnapshot.exists) {
        // Redirige al menú de cliente
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuScreen()), // Reemplaza con tu pantalla de clientes
        );
      } else if (barberiaSnapshot.exists) {
        // Redirige al menú de barbería
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BarberiaOptionsScreen()), // Reemplaza con tu pantalla de barberías
        );
      } else if (barberoSnapshot.exists) {
        // Redirige al menú de barbería
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuBarberosScreen()), // Reemplaza con tu pantalla de barberías
        );
      }else {
        _showErrorDialog("Usuario no registrado en ninguna categoría.");
      }
    } catch (e) {
      _showErrorDialog("Error al validar el tipo de usuario: ${e.toString()}");
    }
  }

  /// Muestra un cuadro de diálogo para errores
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono
              const Icon(
                Icons.content_cut,
                size: 100,
                color: Colors.black,
              ),
              const SizedBox(height: 50),

              // Campo de Email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Campo de Contraseña
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Botón de Iniciar Sesión
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              const SizedBox(height: 12),

              // Opción de Olvidar Contraseña
              TextButton(
                onPressed: () {
                  // Lógica para recuperar contraseña
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              // Opción de Crear Cuenta Nueva
              TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuRegistrosScreen()),
                  );
                  _clearFields(); // Limpia los campos al regresar
                },
                child: const Text(
                  'Crear Cuenta Nueva',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
