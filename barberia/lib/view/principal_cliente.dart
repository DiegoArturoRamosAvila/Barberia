import 'package:barberia/view/login.dart';
import 'package:barberia/view/barberia_info.dart'; // Nueva pantalla para la información de barbería
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LatLng _center = LatLng(19.4326, -99.1332); // Coordenadas iniciales
  final List<Marker> _markers = []; // Lista para los marcadores
  String _searchQuery = ""; // Texto de búsqueda

  @override
  void initState() {
    super.initState();
    _loadBarberiasFromFirebase();
  }

  /// Carga las barberías desde Firebase y genera los marcadores
  Future<void> _loadBarberiasFromFirebase() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('Barberias').get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final data = doc.data();
          final lat = data['latitude'] as double?;
          final lng = data['longitude'] as double?;
          final nombre = data['nombre'] as String?;
          final email = data['email'] as String?;
          final direccion = data['direccion'] as String?; // Ejemplo de otro dato

          if (lat != null && lng != null && nombre != null) {
            _markers.add(
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(lat, lng),
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BarberiaInfoScreen(
                          email: email!,
                          nombre: nombre,
                          direccion: direccion ?? "Sin dirección",
                          latitude: lat,
                          longitude: lng,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            );
          }
        }
        setState(() {}); // Actualiza la interfaz con los marcadores cargados
      }
    } catch (e) {
      print('Error al cargar barberías: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Barbería',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar barberías...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Mapa
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: _center,
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/*void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navegación según el ítem seleccionado
   /* if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoritesScreen()),
      );
    }*/
  }*/
/*bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice seleccionado
        onTap: _onItemTapped, // Acción al tocar un ítem
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.content_cut),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 82, 81, 81), // Color del ítem seleccionado
        unselectedItemColor: const Color.fromARGB(255, 10, 10, 10), // Color de ítems no seleccionados
        backgroundColor: Colors.white,
      ),*/