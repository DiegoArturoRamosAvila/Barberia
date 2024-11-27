class Barberia {
  final String id;
  final String nombre;
  final double latitude;
  final double longitude;
  final String telefono;
  final String email;

  Barberia({
    required this.id,
    required this.nombre,
    required this.latitude,
    required this.longitude,
    required this.telefono,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'latitude': latitude,
      'longitude': longitude,
      'telefono': telefono,
      'email': email,
    };
  }

  static Barberia fromMap(Map<String, dynamic> map) {
    return Barberia(
      id: map['id'],
      nombre: map['nombre'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      telefono: map['telefono'],
      email: map['email'],
    );
  }
}
