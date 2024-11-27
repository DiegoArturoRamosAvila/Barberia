import 'package:flutter/material.dart';

class ServiciosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text('Aquí puedes gestionar los servicios de la barbería.'),
      ),
    );
  }
}
