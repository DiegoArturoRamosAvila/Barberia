import 'package:flutter/material.dart';
import 'package:barberia/view/principal_cliente.dart';
import 'package:barberia/view/barberias_favoritas.dart';


class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal', style: TextStyle(color: const Color.fromARGB(255, 253, 253, 253)),),
        backgroundColor: Colors.black,
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
              icon: Icons.map,
              label: 'Barberias',
              onPressed: () {
                // Navegar a la pantalla del mapa
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            MenuButton(
              icon: Icons.calendar_today,
              label: 'Citas',
              onPressed: () {
                // Navegar a la pantalla para agendar cita
                Navigator.pushNamed(context, '/schedule');
              },
            ),
            SizedBox(height: 20),
            MenuButton(
              icon: Icons.favorite,
              label: 'Favoritos',
              onPressed: () {
                // Navegar a la pantalla del mapa
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
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
