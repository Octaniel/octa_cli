import 'dart:io';

import 'package:get_cli/arctekko.dart';

void initCommand(List<String> args) async {
  if (args.isEmpty) {
    LogService.error('directory or \'.\' argument was not informed');
    LogService.info(
        'correct use: arctekko init . or arctekko init my_fist_project');
    return;
  }

  String dir;
  var skipExample = false;
  var argsjoin = args.join().toLowerCase();
  if (argsjoin.contains('-')) {
    dir = argsjoin.split('-')[0].toSnakeCase();
    skipExample =
        argsjoin.contains('--skipExample') | argsjoin.contains('--se');
  } else {
    dir = argsjoin.toSnakeCase();
  }
  print(dir = dir == '.' ? Directory('').path : dir);
  dir = dir == '.' ? Directory('').path : dir;
  await Utils.createDiretory(dir);
  // await Utils.createDiretory('$dir/lib');
  await ShellUtils.flutterCreate(dir);
  await ShellUtils.cdDir(dir);
  await PubspecUtils.addDependencies(dir,'get', '3.4.6');
  await PubspecUtils.addDependencies(dir,'velocity_x', '0.4.1');
  await PubspecUtils.addDependencies(dir,'http', '0.12.1');
  await PubspecUtils.addDependencies(dir,'responsive_framework', '0.0.8');
  await PubspecUtils.addDependencies(dir,'font_awesome_flutter', '8.8.1');
  await PubspecUtils.addDependencies(dir,'cross_local_storage', '8.8.1');
  await PubspecUtils.addDependencies(dir,'flutter_neumorphic', '3.0.1');
  await ShellUtils.pubGet();
  await CreateDirectory(dir, skipExample);
  await ShellUtils.cdDir('..');
}
