import 'dart:io';
import 'package:get_cli/arctekko.dart';

void CreateDirectory(String path, bool skipExample) async {
  var widgetFile = File('./test/widget_test.dart');
  if (await widgetFile.existsSync()) await widgetFile.deleteSync();
  var dirs = [
    'lib/app/data/',
    'lib/app/data/model/',
    'lib/app/data/provider/',
    'lib/app/data/repository/',
    'lib/app/modules/',
    'lib/app/modules/exemplo/',
    'lib/app/modules/exemplo/controllers/',
    'lib/app/modules/exemplo/pages/',
    'lib/app/modules/exemplo/widgets/',
    'lib/app/res/',
    'lib/app/routes/',
    'lib/app/translations/',
    'lib/app/translations/pt_BR/',
    'lib/app/translations/en_US/',
    'lib/app/widgets/',
  ];
  var dirTheme = 'lib/theme/';
  dirs.add(dirTheme);

  var themeFiles = ['my_theme.dart'];
  var orthersFiles = [
    {
      'filename': 'main.dart',
      'path': 'lib/',
      'content': InitFiles.files['main.dart']
    },
    {
      'filename': 'exemplo_model.dart',
      'path': 'lib/app/data/model/',
      'content': InitFiles.files['exemplo_model.dart']
    },
    {
      'filename': 'exemplo_provider.dart',
      'path': 'lib/app/data/provider/',
      'content': InitFiles.files['exemplo_provider.dart']
    },
    {
      'filename': 'exemplo_repository.dart',
      'path': 'lib/app/data/repository/',
      'content': InitFiles.files['exemplo_repository.dart']
    },
    {
      'filename': 'exemplo_controller.dart',
      'path': 'lib/app/modules/exemplo/controllers/',
      'content': InitFiles.files['exemplo_controller.dart']
    },
    {
      'filename': 'exemplo_page.dart',
      'path': 'lib/app/modules/exemplo/pages/',
      'content': InitFiles.files['exemplo_page.dart']
    },
    {
      'filename': 'exemplo_widget.dart',
      'path': 'lib/app/modules/exemplo/widgets/',
      'content': InitFiles.files['exemplo_widget.dart']
    },
    {
      'filename': 'exemplo_binding.dart',
      'path': 'lib/app/modules/exemplo/',
      'content': InitFiles.files['exemplo_binding.dart']
    },
    {
      'filename': 'static.dart',
      'path': 'lib/app/res/',
      'content': InitFiles.files['static.dart']
    },
    {
      'filename': 'app_routes.dart',
      'path': 'lib/app/routes/',
      'content': InitFiles.files['app_routes.dart']
    },
    {
      'filename': 'app_pages.dart',
      'path': 'lib/app/routes/',
      'content': InitFiles.files['app_pages.dart']
    },
    {
      'filename': 'pt_br_translation.dart',
      'path': 'lib/app/translations/pt_BR/',
      'content': InitFiles.files['pt_br_translation.dart']
    },
    {
      'filename': 'en_us_translation.dart',
      'path': 'lib/app/translations/en_US/',
      'content': InitFiles.files['en_us_translation.dart']
    },
    {
      'filename': 'app_translations.dart',
      'path': 'lib/app/translations/',
      'content': InitFiles.files['app_translations.dart']
    },
    {
      'filename': 'app_binding.dart',
      'path': 'lib/app/',
      'content': InitFiles.files['app_binding.dart']
    },
    {
      'filename': 'app_controller.dart',
      'path': 'lib/app/',
      'content': InitFiles.files['app_controller.dart']
    },
  ];

  dirs.forEach((dir) async {
    path = path.endsWith('/') ? path : '$path/';
    await Utils.createDiretory('$path$dir');
  });
  themeFiles.forEach((fileName) async {
    path = path.endsWith('/') ? path : '$path/';
    dirTheme = dirTheme.endsWith('/') ? dirTheme : '$dirTheme/';
    await _createFile('$path$dirTheme', fileName);
    await _writeFile('$path$dirTheme', fileName);
  });
  _createOrtherFiles(path, orthersFiles);
  // if (!skipExample) {
  //   await _createCounter();
  // }
}

void _createFile(String path, String name) async {
  path = path.endsWith('/') ? path : '$path/';
  if (!await Utils.existsFile('$path$name')) {
    await Utils.createFile('$path$name');
  }
}

void _createOrtherFiles(String path, orthersFiles) async {
  orthersFiles.forEach((e) async {
    var pat = e['path'];
    var name = e['filename'];
    var content = e['content'];
    await _createFile('$path$pat', name);
    await Utils.writeFile('$path$pat$name', content);
  });
}

void _writeFile(String path, String name) async {
  path = path.endsWith('/') ? path : '$path/';
  if (await Utils.existsFile('$path$name')) {
    await Utils.writeFile('$path$name', InitFiles.files[name]);
  }
}

// void _createCounter() async {
//   var counterfiles = [
//     {
//       'filename': 'navigation.dart',
//       'path': 'lib/infrastructure/navigation/',
//       'content': InitFiles.files['navigation.dart.example']
//     },
//     {
//       'filename': 'routes.dart',
//       'path': 'lib/infrastructure/navigation/',
//       'content': InitFiles.files['routes.dart.example']
//     },
//     {
//       'filename': 'counter.controller.binding.dart',
//       'path': 'lib/infrastructure/navigation/bindings/controllers',
//       'content': InitFiles.files['counter.controller.binding.dart']
//     },
//     {
//       'filename': 'counter.screen.dart',
//       'path': 'lib/presentation/counter',
//       'content': InitFiles.files['counter.screen.dart']
//     },
//     {
//       'filename': 'counter.controller.dart',
//       'path': 'lib/presentation/counter/controllers',
//       'content': InitFiles.files['counter.controller.dart']
//     },
//   ];
//   await _createOrtherFiles(counterfiles);
// }
