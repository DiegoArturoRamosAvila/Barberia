import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Has iniciado sesión correctamente!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para navegar a otra pantalla,
                // por ejemplo, para ver el perfil o las opciones de la aplicación
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtherScreen()),
                );
              },
              child: Text('Ir a otra pantalla'),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otra Pantalla'),
      ),
      body: Center(
        child: Text('Esta es una pantalla secundaria'),
      ),
    );
  }
}
