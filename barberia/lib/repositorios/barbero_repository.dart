import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/barbero.dart';

class BarberoRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
  Future<void> registrarBarbero({
    required String email,
    required String password,
    required String nombre,
    required String apaterno,
    required String amaterno,
    required String telefono,
  }) async {
    String correoPropietario = await obtenerCorreoUsuario();
    // Registro en Firebase Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Obtener el correo del propietario de la barbería

    // Obtener el UID del barbero recién registrado
    String uid = userCredential.user!.uid;

    // Registro en Firestore (usando el correo del propietario como el ID del barbero)
    Barbero barbero = Barbero(
      id: correoPropietario,  // Aquí usamos el correo del propietario como id
      nombre: nombre,
      apaterno: apaterno,
      amaterno: amaterno,
      telefono: telefono,
      email: email,
    );

    await _firestore.collection('Barberos').doc(uid).set(barbero.toMap());
  }
}
