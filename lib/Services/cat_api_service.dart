import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchBreeds() async {
  const url = 'https://api.thecatapi.com/v1/breeds';
  final headers = {
    'x-api-key': 'bda53789-d59e-46cd-9bc4-2936630fde39',
  };

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data;
  } else {
    return [];
  }
}
