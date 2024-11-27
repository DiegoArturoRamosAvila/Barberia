import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/cliente.dart';

class ClienteRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registrarCliente({
    required String email,
    required String password,
    required String nombre,
    required String apaterno,
    required String amaterno,
    required String telefono,
  }) async {
    // Registro en Firebase Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    // Registro en Firestore
    Cliente cliente = Cliente(
      id: uid,
      nombre: nombre,
      apaterno: apaterno,
      amaterno: amaterno,
      telefono: telefono,
      email: email,
    );

    await _firestore.collection('Clientes').doc(uid).set(cliente.toMap());
  }
}
