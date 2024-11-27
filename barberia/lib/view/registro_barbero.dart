import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/barberoViewModel.dart';
import 'pantalla_opciones.dart';



class RegistroBarberoScreen extends StatelessWidget {
  
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apaternoController = TextEditingController();
  final TextEditingController _amaternoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final barberoViewModel = Provider.of<Barberoviewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Barbero'),
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
                controller: _apaternoController,
                decoration: InputDecoration(labelText: 'Apellido Paterno'),
              ),
              TextField(
                controller: _amaternoController,
                decoration: InputDecoration(labelText: 'Apellido Materno'),
              ),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await barberoViewModel.registroBarbero(
                    email: _emailController.text,
                    password: _passwordController.text,
                    nombre: _nombreController.text,
                    apaterno: _apaternoController.text,
                    amaterno: _amaternoController.text,
                    telefono: _telefonoController.text,
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
