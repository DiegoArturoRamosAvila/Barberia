class Servicios {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;

  Servicios({
    required this.id, 
    required this.nombre,
    required this.descripcion,
    required this.precio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    };
  }

  static Servicios fromMap(Map<String, dynamic> map) {
    return Servicios(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      precio: map['precio'],
    );
  }
}
