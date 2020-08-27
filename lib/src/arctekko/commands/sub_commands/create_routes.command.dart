import 'dart:io';

import 'package:get_cli/arctekko.dart';

void createRoutes(String nameRoute) async {
  var app_routes = 'lib/app/routes/app_routes.dart';
  var app_pages = 'lib/app/routes/app_pages.dart';
  var app_model = 'lib/app/data/model/${nameRoute}_model.dart';
  var app_provider = 'lib/app/data/provider/${nameRoute}_provider.dart';
  var app_repository = 'lib/app/data/repository/${nameRoute}_repository.dart';
  var app_binding = 'lib/app/modules/${nameRoute}/${nameRoute}_binding.dart';
  if (!await Utils.existsFile(app_routes) &&
      !await Utils.existsFile(app_pages)) {
    await Utils.createFile(app_routes);
    await Utils.createFile(app_pages);
    await Utils.writeFile(app_routes, InitFiles.files['app_routes.dart']);
    await Utils.writeFile(app_pages, InitFiles.files['app_pages.dart']);
  }

  if(!await Utils.existsFile(app_model)&&
      !await Utils.existsFile(app_provider)&&
      !await Utils.existsFile(app_repository)&&
      !await Utils.existsFile(app_binding)){
    await Utils.createFile(app_model);
    await Utils.createFile(app_provider);
    await Utils.createFile(app_repository);
    await Utils.writeFile(app_model, FileExempleUtils.createTextModel(nameRoute.toPascalCase()));
    await Utils.writeFile(app_provider, FileExempleUtils.createTextProvider(nameRoute.toPascalCase()));
    await Utils.writeFile(app_repository, FileExempleUtils.createTextRepository(nameRoute.toPascalCase()));
    await Utils.writeFile(app_binding, FileExempleUtils.createTextBinding(nameRoute.toPascalCase()));
  }

  _addRoute(nameRoute);
}

void _addRoute(String nameRoute) async {
  var app_routes = 'lib/app/routes/app_routes.dart';
  var app_pages = 'lib/app/routes/app_pages.dart';
  var lines = await File(app_routes).readAsLinesSync();
  var lines1 = await File(app_pages).readAsLinesSync();
  var aux = <String>[];
  aux.addAll(lines1);
  lines1.removeRange(0, lines1.length-1);
  lines1.add('''import '../modules/${nameRoute.toSnakeCase()}/${nameRoute.toSnakeCase()}_binding.dart';''');
  lines1.add('''import '../modules/${nameRoute.toSnakeCase()}/pages/${nameRoute.toSnakeCase()}_page.dart';''');
  lines1.addAll(aux);

  while (lines.last.isEmpty) {
    lines.removeLast();
  }
  while (lines1.last.isEmpty) {
    lines1.removeLast();
  }
  lines.removeLast();
  lines1.removeLast();
  lines1.removeLast();
  lines.add(
      '  static const ${nameRoute.toUpperCase()} = \'/${nameRoute.toLowerCase().replaceAll('_', '-')}\';');
  lines1.add(
      '  GetPage(name: Routes.${nameRoute.toUpperCase()}, page: () => ${nameRoute.toPascalCase()}Page(), binding: ${nameRoute.toPascalCase()}Binding()),');

  _routesSort(lines);
  _pagesSort(lines1);

  await File(app_routes).writeAsStringSync(lines.join('\n'));
  await File(app_pages).writeAsStringSync(lines1.join('\n'));
}

List<String> _routesSort(List<String> lines) {
  var routes = <String>[];
  var lines2 = <String>[];
  lines2.addAll(lines);
  lines2.forEach((line) {
    if (line.contains('abstract') || line.contains('static')) {
      routes.add('$line');
      lines.remove(line);
    }
  });
  // routes.sort();
  lines.addAll(routes);
  lines.add('}');
  return lines;
}

List<String> _pagesSort(List<String> lines) {
  var routes = <String>[];
  var lines2 = <String>[];
  lines2.addAll(lines);
  lines2.forEach((line) {
    if (line.contains('GetPage')) {
      routes.add('$line');
      lines.remove(line);
    }
  });
  routes.sort();
  lines.addAll(routes);
  lines.add('];');
  lines.add('}');
  return lines;
}
