import 'package:barberia/view/barberos.dart';
import 'package:flutter/material.dart';
import 'registro_servicios.dart';

class BarberiaOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Retorna false para bloquear la acción de retroceso
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Barbería',
            style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.content_cut,
                size: 100,
                color: Colors.black,
              ),
              const SizedBox(height: 50),
              // Botón Servicios
              _buildOptionCard(
                context,
                title: 'Servicios',
                icon: Icons.design_services,
                color: Colors.black,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroServicioScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
              // Botón Ganancias
              _buildOptionCard(
                context,
                title: 'Ganancias',
                icon: Icons.attach_money,
                color: Colors.black,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ganancias seleccionado')),
                  );
                },
              ),
              const SizedBox(height: 10),
              // Botón Barberos
              _buildOptionCard(
                context,
                title: 'Barberos',
                icon: Icons.person,
                color: Colors.black,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BarberosScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Método para construir las tarjetas de opción
  Widget _buildOptionCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

