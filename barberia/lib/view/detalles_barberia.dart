import 'package:flutter/material.dart';

class BarbershopDetailScreen extends StatelessWidget {
  final String barbershopName;
  final String description;

  const BarbershopDetailScreen({
    Key? key,
    required this.barbershopName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          barbershopName,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Descripción de la barbería
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // Lista de barberos
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Número de barberos
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person, color: Colors.black),
                    title: Text("Barbero $index"),
                    subtitle: Row(
                      children: [
                        // Estrellas de calificación
                        Row(
                          children: List.generate(
                            5, // Número máximo de estrellas
                            (starIndex) => Icon(
                              starIndex < 4 // Calificación de ejemplo
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        
                      },
                    ),
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
