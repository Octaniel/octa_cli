
import 'dart:io';

import '../../../../arctekko.dart';

void createRoutesBinding(String nameRoute, String nameModules) async {
  var app_model = 'lib/app/data/model/${nameRoute}_model.dart';
  var app_provider = 'lib/app/data/provider/${nameRoute}_provider.dart';
  var app_repository = 'lib/app/data/repository/${nameRoute}_repository.dart';
  var app_binding = 'lib/app/modules/${nameModules}/${nameRoute}_binding.dart';

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
}
