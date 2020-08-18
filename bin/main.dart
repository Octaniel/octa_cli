import 'package:get_cli/src/cli.dart';

void main(List<String> arguments) {
  print(arguments.length);
  GetCli.ProcessCommand(List<String>.from(arguments));
}
