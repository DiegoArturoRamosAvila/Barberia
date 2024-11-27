import 'package:flutter/material.dart';
import '../repositorios/barbero_repository.dart';

class Barberoviewmodel extends ChangeNotifier {
  final BarberoRepository _repository = BarberoRepository();

  String _error = '';
  String get error => _error;

  Future<void> registroBarbero({
    required String email,
    required String password,
    required String nombre,
    required String apaterno,
    required String amaterno,
    required String telefono,
  }) async {
    try {
      await _repository.registrarBarbero(
        email: email,
        password: password,
        nombre: nombre,
        apaterno: apaterno,
        amaterno: amaterno,
        telefono: telefono,
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
