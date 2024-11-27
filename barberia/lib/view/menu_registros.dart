import 'package:flutter/material.dart';
import 'package:barberia/view/registro_barber.dart';
import 'package:barberia/view/registro_cliente.dart';


class MenuRegistrosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¿Qué deseas reistrar?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
                Icons.content_cut,
                size: 100,
                color: Colors.black,
              ),
              const SizedBox(height: 50),

            MenuButton(
              icon: Icons.content_cut,
              label: 'Barberia',
              onPressed: () {
                // Navegar a la pantalla del mapa
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroBarberiaScreen()),
                );
              },
            ),
            
            SizedBox(height: 20),
            MenuButton(
              icon: Icons.account_box,
              label: 'Cliente',
              onPressed: () {
                // Navegar a la pantalla del mapa
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroClienteScreen()),
                );
              },
            ),
          ],
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
      ),
    );
  }
}
