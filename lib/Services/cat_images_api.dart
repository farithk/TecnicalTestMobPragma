//https://api.thecatapi.com/v1/images/0XYvRd7oD

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchBreedsImages(id) async {
var url = 'https://api.thecatapi.com/v1/images/$id';
  final headers = {
    'x-api-key': 'bda53789-d59e-46cd-9bc4-2936630fde39',
  };

  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data["url"];
  } else {
    return "";
  }
}
