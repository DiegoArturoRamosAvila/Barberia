import 'package:flutter/material.dart';
import '../repositorios/cliente_repository.dart';

class ClienteViewModel extends ChangeNotifier {
  final ClienteRepository _repository = ClienteRepository();

  String _error = '';
  String get error => _error;

  Future<void> registrarCliente({
    required String email,
    required String password,
    required String nombre,
    required String apaterno,
    required String amaterno,
    required String telefono,
  }) async {
    try {
      await _repository.registrarCliente(
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
