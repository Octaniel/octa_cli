import 'package:get_cli/arctekko.dart';

class FileExempleUtils {
  static String createTextController(String name) {
    return '''
import '../../../data/repository/${name.toSnakeCase()}_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ${name}Controller extends GetxController{
  final ${name}Repository repository;

  ${name}Controller({@required this.repository});

  //TODO: ${name}Controller
}
''';
  }

  static String createTextModel(String name) {
    return '''
class ${name}Model {
  int id;
  String nome;

  ExemploModel({this.id, this.nome});

  ExemploModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
    };
  }
}
''';
  }

  static String createTextProvider(String name) {
    return '''
import '../model/${name.toSnakeCase()}_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';

const baseUrl = 'http:locahost:8080/';

class ${name}Provider {
  final http.Client httpClient;
  ExemploProvider({@required this.httpClient});

  Future<List<${name}Model>> getAll() async {
    try {
      var response = await httpClient.get(baseUrl + 'home');
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(decoder(response.body));
        var list${name}Model = jsonResponse.map<${name}Model>((map) {
          return ${name}Model.fromJson(map);
        }).toList();
        return list${name}Model;
      } else {
        print('erro -get');
      }
    } catch (_) {}
    return [];
  }

  String decoder(String body) {
    body = body.replaceAll('Ã§', 'ç');
    body = body.replaceAll('Ãµ', 'õ');
    body = body.replaceAll('Ã', 'Ç');
    return body;
  }

  Future<${name}Model> getId(int id) async {
    try {
      var response = await httpClient.get(baseUrl);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ${name}Model.fromJson(jsonResponse);
      } else {
        print('erro -get');
      }
    } catch (_) {}
    return null;
  }

  Future<bool> add(${name}Model obj) async {
    try {
      var response = await httpClient.post(baseUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -post');
      }
    } catch (_) {}
    return false;
  }

  Future<bool> edit(${name}Model obj) async {
    try {
      var response = await httpClient.put(baseUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -put');
      }
    } catch (_) {}
    return false;
  }

 Future<bool> delete(int id) async {
    try {
      var response = await httpClient.delete(baseUrl);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -delete');
      }
    } catch (_) {}
    return false;
  }
}''';
  }

  static String createTextRepository(String name){
    return '''
    import '../model/${name.toSnakeCase()}_model.dart';
import '../provider/${name.toSnakeCase()}_provider.dart';
import 'package:meta/meta.dart';

class ${name}Repository {
  final ${name}Provider exemploProvider;

  ${name}Repository({@required this.${name.toSnakeCase()}Provider})
      : assert(${name.toSnakeCase()}Provider != null);

  Future<List<ExemploModel>> getAll() async {
    return await ${name.toSnakeCase()}Provider.getAll();
  }

  Future<ExemploModel> getId(id) async {
    return await ${name.toSnakeCase()}Provider.getId(id);
  }

  Future<bool> add(obj) async {
    return await ${name.toSnakeCase()}Provider.add(obj);
  }

  Future<bool> edit(obj) async {
    return await ${name.toSnakeCase()}Provider.edit(obj);
  }

  Future<bool> delete(id) async {
    return await ${name.toSnakeCase()}Provider.delete(id);
  }
}
    ''';
  }

  static String createTextBinding(String name){
    return '''
    import '../../data/provider/${name.toSnakeCase()}_provider.dart';
import '../../data/repository/${name.toSnakeCase()}_repository.dart';
import 'controllers/${name.toSnakeCase()}_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ${name}Binding implements Bindings {
  @override
  void dependencies() {
    Get.put<${name}Controller>(${name}Controller(
        repository: ${name}Repository(
            ${name.toSnakeCase()}Provider: ${name}Provider(httpClient: http.Client()))));
  }
}
    ''';
  }

  static String createTextScreen(String name) {
    return '''
import '../controllers/${name.toSnakeCase()}_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ${name.toPascalCase()}Page extends GetView<${name.toPascalCase()}Controller> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('${name.toPascalCase()}Page '),
      centerTitle: true,),
      body: Center(
        child: Text('${name.toPascalCase()}Screen  is working', style: TextStyle(fontSize:20),),
      ),
    );
  }
}
''';
  }

  static String createTextWidget(String name) {
    return '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ${name}Widget extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
}''';
  }
}
