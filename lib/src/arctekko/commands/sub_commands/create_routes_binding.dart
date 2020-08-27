import 'dart:io';

import '../../../../arctekko.dart';

void createRoutesBinding(String nameRoute, String nameModules) async {
  var app_model = 'lib/app/data/model/${nameRoute}_model.dart';
  var app_provider = 'lib/app/data/provider/${nameRoute}_provider.dart';
  var app_repository = 'lib/app/data/repository/${nameRoute}_repository.dart';
  var app_binding = 'lib/app/modules/${nameModules}/${nameRoute}_binding.dart';

  if (!await Utils.existsFile(app_model) &&
      !await Utils.existsFile(app_provider) &&
      !await Utils.existsFile(app_repository)) {
    await Utils.createFile(app_model);
    await Utils.createFile(app_provider);
    await Utils.createFile(app_repository);
    await Utils.writeFile(
        app_model, FileExempleUtils.createTextModel(nameRoute.toPascalCase()));
    await Utils.writeFile(app_provider,
        FileExempleUtils.createTextProvider(nameRoute.toPascalCase()));
    await Utils.writeFile(app_repository,
        FileExempleUtils.createTextRepository(nameRoute.toPascalCase()));

    _addBinding(nameRoute, nameModules);
  }
}

void _addBinding(String nameRoute, String nameModules) async {
  var app_binding =
      'lib/app/modules/${nameModules}/${nameModules}_binding.dart';
  var lines = await File(app_binding).readAsLinesSync();

  var aux = <String>[];
  aux.addAll(lines);
  lines.removeRange(0, lines.length-1);
  lines.add('''import '../../data/provider/${nameRoute.toSnakeCase()}_provider.dart';''');
  lines.add('''import '../../data/repository/pages/${nameRoute.toSnakeCase()}_repository.dart';''');
  lines.add('''import 'controllers/${nameRoute.toSnakeCase()}_controller.dart';''');
  lines.addAll(aux);

 while(!lines.last.contains(';')) lines.removeLast();
 lines.add('''Get.put<${nameRoute.toPascalCase()}Controller>(${nameRoute.toPascalCase()}Controller(
        repository: ${nameRoute.toPascalCase()}Repository(
            homeProvider: ${nameRoute.toPascalCase()}Provider(httpClient: http.Client()))));''');

 lines.add('}');
 lines.add('}');

  await File(app_binding).writeAsStringSync(lines.join('\n'));
}
