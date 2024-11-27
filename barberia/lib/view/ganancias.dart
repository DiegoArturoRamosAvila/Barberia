import 'package:flutter/material.dart';

class GananciasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganancias'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Aquí puedes consultar las ganancias de la barbería.'),
      ),
    );
  }
}
