import 'package:flutter/material.dart';
import '../repositorios/servicios_repository.dart';

class Servicioviewmodel extends ChangeNotifier {
  final ServiciosRepository _repository = ServiciosRepository();

  String _error = '';
  String get error => _error;

  Future<void> registroServicio({
    required String nombre,
    required String descripcion,
    required double precio,
  }) async {
    try {
      await _repository.registrarServicio(
        nombre: nombre,
        descripcion: descripcion,
        precio: precio,
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
