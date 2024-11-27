import 'package:flutter/material.dart';
import '../repositorios/barberi_repository.dart';

class BarberiViewModel extends ChangeNotifier {
  final BarberiRepository _repository = BarberiRepository();

  String _error = '';
  String get error => _error;

  Future<void> registrarBarberia({
    required String email,
    required String password,
    required String nombre,
    required double latitude,
    required double longitude,
    required String telefono,
  }) async {
    try {
      await _repository.registrarBarberia(
        email: email,
        password: password,
        nombre: nombre,
        latitude: latitude,
        longitude: longitude,
        telefono: telefono,
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
