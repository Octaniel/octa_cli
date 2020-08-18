import 'package:get_cli/arctekko.dart';

class GetCli {
  static void ProcessCommand(List<String> args) async {
    if (args.isEmpty) {
      LogService.error('unquoted command');
      LogService.info('in the future I will create a help');
      return;
    }
    var command = args.first.toLowerCase();
    args.removeAt(0);
    switch (command) {
      case 'arctekko':
      case 'arc':
        Arctekko.ProcessCommand(args);
        break;
      case 'upgrade':
        ShellUtils.update();
        break;
      default:
        LogService.error('comando invalido');
    }
  }
}
