import 'detalles_barberia.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.content_cut, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Lógica para búsqueda
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              // Lógica para perfil
            },
          ),
        ],
        title: Text(
          "Favoritos",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: 4, // Número de barberías en favoritos
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.content_cut, color: Colors.black),
            title: Text("Barberia ...."),
            subtitle: Text("Descripcion de la barberia."),
            trailing: Icon(Icons.favorite, color: Colors.pink),
            onTap: () {
              // Navegar a la pantalla de detalles de la barbería
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BarbershopDetailScreen(
                    barbershopName: "Barbería $index",
                    description:
                        ">Imagen bien chidota de la barberia<\nEsta es la descripción de la barbería $index.",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}