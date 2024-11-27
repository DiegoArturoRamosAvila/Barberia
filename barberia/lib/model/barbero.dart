class Barbero {
  final String id;
  final String nombre;
  final String apaterno;
  final String amaterno;
  final String telefono;
  final String email;

  Barbero({
    required this.id,
    required this.nombre,
    required this.apaterno,
    required this.amaterno,
    required this.telefono,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apaterno': apaterno,
      'amaterno': amaterno,
      'telefono': telefono,
      'email': email,
    };
  }

  static Barbero fromMap(Map<String, dynamic> map) {
    return Barbero(
      id: map['id'],
      nombre: map['nombre'],
      apaterno: map['apaterno'],
      amaterno: map['amaterno'],
      telefono: map['telefono'],
      email: map['email'],
    );
  }
}
