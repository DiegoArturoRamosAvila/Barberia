import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/servicioViewModel.dart';
import 'pantalla_opciones.dart';

class RegistroServicioScreen extends StatelessWidget {
  
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final barberoViewModel = Provider.of<Servicioviewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Servicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripcion'),
              ),
              TextField(
                controller: _precioController,
                decoration: InputDecoration(labelText: 'Precio'),
              ),
              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await barberoViewModel.registroServicio(
                    nombre: _nombreController.text,
                    descripcion: _descripcionController.text,
                    precio: double.tryParse(_precioController.text) ?? 0.0,
                  );
                  

                  if (barberoViewModel.error.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registro exitoso')),
                    );
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BarberiaOptionsScreen()),
                    );
                  
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(barberoViewModel.error)),
                    );
                  }
                },
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Color de fondo del botón
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Registrar',
                  style: TextStyle(color: Colors.white), // Texto en blanco
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
