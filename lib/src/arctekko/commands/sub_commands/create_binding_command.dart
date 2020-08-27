import 'package:get_cli/arctekko.dart';

import 'create_routes_binding.dart';

void createBindingCommand(List<String> args) async {
  var name = args.firstWhere(
          (el) => el.startsWith('--nome=') || el.startsWith('--n='),
      orElse: () => null);
  if (name == null) {
    LogService.error('Não foi encontrado argumento --n ou --nome');
    return;
  }
  name = name.split('=')[1];
  if (name.isEmpty) {
    LogService.error('Não foi encontrado argumento --n ou --nome');
    return;
  }
  var nameModules = args.firstWhere(
          (el) => el.contains('--nomeModule=') || el.contains('--nM='),
      orElse: () => null);
  if (nameModules == null) {
    LogService.error('Não foi encontrado argumento --nM ou --nomeModule');
    return;
  }
  nameModules = nameModules.split('=')[1];
  if (nameModules.isEmpty) {
    LogService.error('Não foi encontrado argumento --nM ou --nomeModule');
    return;
  }
  name = name.toLowerCase().trimLeft();
  var nameSnakeCase = name.toSnakeCase();
  var nameModuleSnakeCase = nameModules.toSnakeCase();
  var screenFileName = '${nameSnakeCase}_page.dart';
  var screenDirectory = 'lib/app/modules/$nameModuleSnakeCase';
//  await Utils.createDiretory(screenDirectory);
//  await Utils.createDiretory('${screenDirectory}/controllers');
//  await Utils.createDiretory('${screenDirectory}/pages');
//  await Utils.createDiretory('${screenDirectory}/widgets');

  var screenFilePath = '${screenDirectory}/pages/${screenFileName}';

//  if (!await Utils.existsFile(screenFilePath)) {
//    await Utils.createFile(screenFilePath);
//    await Utils.writeFile(
//        screenFilePath, await FileExempleUtils.createTextScreen(name));
//  }
  await createController(
      '${screenDirectory}/controllers/${nameSnakeCase}_controller.dart', name);
  await createRoutesBinding(nameSnakeCase, nameModules);
}
