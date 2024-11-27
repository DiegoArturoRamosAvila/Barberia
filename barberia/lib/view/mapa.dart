import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Coordenadas iniciales para el mapa (en caso de que no se obtenga la ubicación)
  LatLng _center = LatLng(19.4326, -99.1332);  // Ciudad de México por defecto
  late MapController _mapController;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getLocation();
  }

  // Método para obtener la ubicación del dispositivo
  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación están deshabilitados, muestra un mensaje y regresa
      print("Los servicios de ubicación están deshabilitados.");
      return;
    }

    // Solicitar permisos para acceder a la ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // El usuario ha denegado los permisos de ubicación
        print("Permisos de ubicación denegados.");
        return;
      }
    }

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);  // Establecer la ubicación en el mapa
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubicación del dispositivo"),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _center,
          zoom: 13.0,
          onTap: (_, __) {
            // Cualquier acción al tocar el mapa
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _center,
                builder: (ctx) => Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation, // Botón para actualizar la ubicación
        child: Icon(Icons.my_location),
      ),
    );
  }
}
