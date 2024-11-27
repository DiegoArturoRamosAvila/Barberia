import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/servicios.dart';

class ServiciosRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener correo del propietario de la barbería (usuario logueado)
  Future<String> obtenerCorreoUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email!; // Retorna el correo del propietario logueado
    }
    throw Exception("No hay usuario logueado");
  }

  // Registrar barbero en Firebase
  Future<void> registrarServicio({
    required String nombre,
    required String descripcion,
    required double precio,
  }) async {
    String correoPropietario = await obtenerCorreoUsuario();


    // Obtener el correo del propietario de la barbería

    // Registro en Firestore (usando el correo del propietario como el ID del barbero)
    Servicios servicio = Servicios(
      id: correoPropietario,  // Aquí usamos el correo del propietario como id
      nombre: nombre,
      descripcion: descripcion,
      precio: precio,
    );

    await _firestore.collection('Servicios').add(servicio.toMap());
  }
}
