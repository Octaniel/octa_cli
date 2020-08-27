import 'package:get_cli/arctekko.dart';

void createScreenCommand(List<String> args) async {
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
  name = name.toLowerCase().trimLeft();
  var nameSnakeCase = name.toSnakeCase();
  var screenFileName = '${nameSnakeCase}_page.dart';
  var screenDirectory = 'lib/app/modules/$nameSnakeCase';
  await Utils.createDiretory(screenDirectory);
  await Utils.createDiretory('${screenDirectory}/controllers');
  await Utils.createDiretory('${screenDirectory}/pages');
  await Utils.createDiretory('${screenDirectory}/widgets');

  var screenFilePath = '${screenDirectory}/pages/${screenFileName}';

  if (!await Utils.existsFile(screenFilePath)) {
    await Utils.createFile(screenFilePath);
    await Utils.writeFile(
        screenFilePath, await FileExempleUtils.createTextScreen(name));
  }
  await createController(
      '${screenDirectory}/controllers/${nameSnakeCase}_controller.dart', name);
  await createRoutes(nameSnakeCase);
}
