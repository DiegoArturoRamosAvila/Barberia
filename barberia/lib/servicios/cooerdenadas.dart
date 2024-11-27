import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  Future<List<double>> getCoordinates(String address) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$address&format=json');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        return [lat, lon];
      } else {
        throw Exception('No se encontraron coordenadas para esta dirección');
      }
    } else {
      throw Exception('Error al comunicarse con la API');
    }
  }
}
