import 'package:get_cli/arctekko.dart';

class FileExempleUtils {
  static String createTextController(String name) {
    return '''
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ${name}Controller extends GetxController{
  final ${name}Repository repository;

  ${name}Controller({@required this.repository});

  //TODO: ${name}Controller
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
