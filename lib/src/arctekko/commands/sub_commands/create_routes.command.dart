import 'dart:io';

import 'package:get_cli/arctekko.dart';

void createRoutes(String nameRoute) async {
  var app_routes = 'lib/routes/app_routes.dart';
  var app_pages = 'lib/routes/app_pages.dart';
  if (!await Utils.existsFile(app_routes) &&
      !await Utils.existsFile(app_pages)) {
    await Utils.createFile(app_routes);
    await Utils.createFile(app_pages);
    await Utils.writeFile(app_routes, InitFiles.files['app_routes.dart']);
    await Utils.writeFile(app_pages, InitFiles.files['app_pages.dart']);
  }

  _addRoute(nameRoute);
}

void _addRoute(String nameRoute) async {
  var app_routes = 'lib/routes/app_routes.dart';
  var app_pages = 'lib/routes/app_pages.dart';
  var lines = await File(app_routes).readAsLinesSync();
  var lines1 = await File(app_pages).readAsLinesSync();

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
