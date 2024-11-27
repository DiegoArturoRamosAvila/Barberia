import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'registro_barbero.dart';

class BarberosScreen extends StatefulWidget {
  

  @override
  _BarberosScreenState createState() => _BarberosScreenState();
}

class _BarberosScreenState extends State<BarberosScreen> {
  List<String> _barberos = []; // Lista de barberos, inicialmente vacía
  bool _isLoading = true; // Para mostrar el indicador de carga mientras obtenemos los datos

  @override
  void initState() {
    super.initState();
    _obtenerBarberos(); // Llamar al método para obtener los barberos al iniciar la pantalla
  }
  Future<String> obtenerCorreoUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email!; // Retorna el correo del propietario logueado
    }
    throw Exception("No hay usuario logueado");
  }

  /// Método para obtener los barberos desde Firebase
  Future<void> _obtenerBarberos() async {
    try {
      String correoPropietario = await obtenerCorreoUsuario();
      // Consulta los barberos relacionados con la barbería actual
      final snapshot = await FirebaseFirestore.instance
          .collection('Barberos')
          .where('id', isEqualTo: correoPropietario)
          .get();

      // Procesar los datos obtenidos
      List<String> barberosList = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final nombre = data['nombre'] ?? 'Sin nombre'; // Usar un valor por defecto si no existe el campo 'nombre'
        barberosList.add(nombre);
      }

      setState(() {
        _barberos = barberosList;
        _isLoading = false; // Cuando los datos se hayan cargado, detener el indicador de carga
      });
    } catch (e) {
      print("Error al obtener los barberos: $e");
      setState(() {
        _isLoading = false; // Si ocurre un error, también detener el indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barberos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Agregar Barbero', style: TextStyle(color: Colors.white)),
              onPressed: () {
                // Navegar a la pantalla de registro de barbero
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroBarberoScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Mostrar el indicador de carga si aún se están obteniendo los datos
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _barberos.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay barberos registrados para esta barbería.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _barberos.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_barberos[index]),
                              leading: const Icon(Icons.person),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
