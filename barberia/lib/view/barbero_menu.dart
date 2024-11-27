import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MenuBarberosScreen extends StatefulWidget {
  @override
  _MenuBarberosScreenState createState() => _MenuBarberosScreenState();
}

class _MenuBarberosScreenState extends State<MenuBarberosScreen> {
  String? _nombreBarbero;

  @override
  void initState() {
    super.initState();
    _cargarNombreBarbero();
  }

  Future<void> _cargarNombreBarbero() async {
  try {
    // Obtener el usuario actual
    User? usuario = FirebaseAuth.instance.currentUser;

    if (usuario != null) {
      String email = usuario.email!;
      print('Correo del usuario actual: $email'); // Para depuración

      // Consultar el barbero en Firestore usando su correo electrónico
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Barberos')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Obtener el primer documento que coincida
        DocumentSnapshot barberoSnapshot = querySnapshot.docs.first;
        Map<String, dynamic>? datos = barberoSnapshot.data() as Map<String, dynamic>?;

        if (datos != null) {
          print('Nombre: ${datos['nombre']}');
          print('Apellido: ${datos['apaterno']}');

          // Aquí actualizamos la variable _nombreBarbero usando setState
          setState(() {
            _nombreBarbero = '${datos['nombre']} ${datos['apaterno']}';
          });
        }
      } else {
        print('No se encontró un barbero con el email proporcionado.');
      }
    } else {
      print('No hay un usuario logueado.');
    }
  } catch (e) {
    print('Error al cargar el nombre del barbero: $e');
  }
}

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_box,
                size: 100,
                color: Colors.black,
              ),
              const SizedBox(height: 20),

              // Mostrar el nombre del barbero
              Text(
                _nombreBarbero ?? 'Cargando nombre...',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 50),

              // Botón para Barbería
              const SizedBox(height: 20),

              // Botón para Barbero
              MenuButton(
                icon: Icons.calendar_today,
                label: 'Agenda',
                onPressed: () {
                  Navigator.pushNamed(context, '/barbero'); // Asegúrate de tener esta ruta definida
                },
              ),
              const SizedBox(height: 20),

              // Botón para Cliente
              MenuButton(
                icon: Icons.account_box,
                label: 'Rendimiento',
                onPressed: () {
                  /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroClienteScreen()),
                  );*/
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  MenuButton({required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 30, color: Colors.white),
      label: Text(
        label,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: Size(double.infinity, 50), // Hacer los botones más grandes
      ),
    );
  }
}
