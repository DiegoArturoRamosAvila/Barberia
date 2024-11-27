import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/barberia.dart';

class BarberiRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registrarBarberia({
    required String email,
    required String password,
    required String nombre,
    required double latitude,
    required double longitude,
    required String telefono,
  }) async {
    // Registro en Firebase Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    // Registro en Firestore
    Barberia barberia = Barberia(
      id: uid,
      nombre: nombre,
      latitude: latitude,
      longitude: longitude,
      telefono: telefono,
      email: email,
    );

    await _firestore.collection('Barberias').doc(uid).set(barberia.toMap());
  }
}
