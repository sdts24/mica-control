import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mica_control/src/models/user_model.dart';

class UsersProvider {
  final String _url = 'https://micacontrol-default-rtdb.firebaseio.com';

  Future<bool> crearUser(UserModel user) async {
    final String url = '$_url/usuarios.json';
    final resp = await http.post(
      url,
      body: userModelToJson(user),
    );

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

    Future<bool> editarUser(UserModel user) async {
    final String url = '$_url/usuarios/${user.id}.json';
    final resp = await http.put(
      url,
      body: userModelToJson(user),
    );

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<UserModel>> obtenerUser() async {
    final url = '$_url/usuarios.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeDate = json.decode(resp.body);
    final List<UserModel> users = new List();

    if (decodeDate == null) return [];

    decodeDate.forEach((id, user) {
      final userTemp = UserModel.fromJson(user);
      userTemp.id = id;

      users.add(userTemp);
    });

    return users;
  }

  Future<int> borrarUser(String id) async {
    final url = '$_url/usuarios/$id.json';
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }
}
