import 'package:get_cli/arctekko.dart';
import 'package:get_cli/src/arctekko/commands/sub_commands/create_binding_command.dart';

void createCommand(List<String> args) async {
  if (!await Utils.isFlutterDirectory()) {
    LogService.error('pubspec.yaml was not found');
    LogService.info('run the command in the flutter project directory');
    return;
  }
  if (args.isEmpty) {
    LogService.error('Create <type> [screen , widget]');
    return;
  }
  var type = args.first;
  args.removeAt(0);
  switch (type) {
    case 'module':
    case 'm':
      createScreenCommand(args);
      break;
    case 'binding':
    case 'b':
      createBindingCommand(args);
      break;
    case 'widget':
    case 'w':
      createWidgetCommand(args);
      break;

    default:
      LogService.error(
          'the type: ${type} not\'s find. expected [screen, widget]');
  }
}
