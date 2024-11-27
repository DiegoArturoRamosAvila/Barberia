// favorites_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getFavorites(String userId) async {
    List<Map<String, dynamic>> favorites = [];

    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      List<dynamic> favoriteIds = userDoc['favoritas'] ?? [];

      for (var barbershopId in favoriteIds) {
        DocumentSnapshot barbershopDoc =
            await _firestore.collection('barberias').doc(barbershopId).get();
        favorites.add(barbershopDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error obteniendo barberías favoritas: $e");
      rethrow;
    }

    return favorites;
  }
}
