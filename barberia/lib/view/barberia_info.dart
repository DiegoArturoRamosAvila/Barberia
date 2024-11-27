import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BarberiaInfoScreen extends StatelessWidget {
  final String email;
  final String nombre;
  final String direccion;
  final double latitude;
  final double longitude;

  BarberiaInfoScreen({
    required this.email,
    required this.nombre,
    required this.direccion,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Dirección: $direccion",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Latitud: $latitude",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Longitud: $longitude",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ServiciosList(barberiaId: email),
            ),
            CitaButton(
              icon: Icons.calendar_today,
              label: 'AgendarCita',
              onPressed: () {
                // Navegar a la pantalla para agendar cita
                Navigator.pushNamed(context, '/schedule');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ServiciosList extends StatelessWidget {
  final String barberiaId;

  ServiciosList({required this.barberiaId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Servicios')
          .where('id', isEqualTo: barberiaId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No hay servicios disponibles para esta barbería.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final servicios = snapshot.data!.docs;

        return ListView.builder(
          itemCount: servicios.length,
          itemBuilder: (context, index) {
            final servicio = servicios[index];
            final nombreServicio = servicio['nombre'] ?? 'Sin nombre';
            final precio = servicio['precio'] ?? 'Sin precio';

            return ListTile(
              title: Text(
                nombreServicio,
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text('Precio: \$${precio.toString()}'),
              leading: Icon(Icons.content_cut, color: Colors.black),
            );
          },
        );
      },
    );
  }
}

class CitaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  CitaButton({required this.icon, required this.label, required this.onPressed});

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
        minimumSize: Size(double.infinity, 50), // Ancho completo
      ),
    );
  }
}
