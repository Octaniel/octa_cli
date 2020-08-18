class InitFiles {
  static Map<String, String> files = {
    'main.dart': '''
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/my_theme.dart';
import 'translations/app_translations.dart';
import 'app/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() => runApp(GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: Routes.EXEMPLO, //Rota inicial
      theme: appThemeData, //Tema personalizado app
      defaultTransition: Transition.fade, // Transição de telas padrão
      getPages: AppPages
          .pages, // Seu array de navegação contendo as rotas e suas pages
      locale: Locale('pt', 'BR'), // Língua padrão
      translationsKeys:
          AppTranslation.translations, // Suas chaves contendo as traduções<map>
    ));
  ''',
    'exemplo_model.dart': '''class ExemploModel {
  int id;
  String nome;

  ExemploModel({this.id, this.nome});

  ExemploModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
    };
  }
}''',
    'exemplo_provider.dart': '''
import '../model/exemplo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';

const baseUrl = 'http:locahost:8080/';

class ExemploProvider {
  final http.Client httpClient;
  ExemploProvider({@required this.httpClient});

  Future<List<ExemploModel>> getAll() async {
    try {
      var response = await httpClient.get(baseUrl + 'home');
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(decoder(response.body));
        var listExemploModel = jsonResponse.map<ExemploModel>((map) {
          return ExemploModel.fromJson(map);
        }).toList();
        return listExemploModel;
      } else {
        print('erro -get');
      }
    } catch (_) {}
    return [];
  }

  String decoder(String body) {
    body = body.replaceAll('Ã§', 'ç');
    body = body.replaceAll('Ãµ', 'õ');
    body = body.replaceAll('Ã', 'Ç');
    return body;
  }

  Future<ExemploModel> getId(int id) async {
    try {
      var response = await httpClient.get(baseUrl);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return ExemploModel.fromJson(jsonResponse);
      } else {
        print('erro -get');
      }
    } catch (_) {}
    return null;
  }

  Future<bool> add(ExemploModel obj) async {
    try {
      var response = await httpClient.post(baseUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -post');
      }
    } catch (_) {}
    return false;
  }

  Future<bool> edit(ExemploModel obj) async {
    try {
      var response = await httpClient.put(baseUrl,
          headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -put');
      }
    } catch (_) {}
    return false;
  }

 Future<bool> delete(int id) async {
    try {
      var response = await httpClient.delete(baseUrl);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('erro -delete');
      }
    } catch (_) {}
    return false;
  }
}
''',
    'exemplo_repository.dart': '''
import '../model/exemplo_model.dart';
import '../provider/exemplo_provider.dart';
import 'package:meta/meta.dart';

class ExemploRepository {
  final ExemploProvider exemploProvider;

  ExemploRepository({@required this.exemploProvider})
      : assert(exemploProvider != null);

  Future<List<ExemploModel>> getAll() async {
    return await exemploProvider.getAll();
  }

  Future<ExemploModel> getId(id) async {
    return await exemploProvider.getId(id);
  }

  Future<bool> add(obj) async {
    return await exemploProvider.add(obj);
  }

  Future<bool> edit(obj) async {
    return await exemploProvider.edit(obj);
  }

  Future<bool> delete(id) async {
    return await exemploProvider.delete(id);
  }
}''',
    'exemplo_controller.dart': '''
import '../../../data/repository/exemplo_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ExemploController extends GetxController {
  final ExemploRepository repository;
  ExemploController({@required this.repository}) : assert(repository != null);

  var _ex = ''.obs;

  set ex(String ex) => _ex.value = ex;
  get ex => _ex.value;
}
''',
    'exemplo_page.dart': '''
import '../controllers/exemplo_controller.dart';
import '../widgets/exemplo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ExemploPage extends GetView<ExemploController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:'pripag'.tr.text.make(),
      ),
      body: ExemploWidget(),
    );
  }
}
''',
    'exemplo_widget.dart': '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/exemplo_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ExemploWidget extends GetWidget<ExemploController> {

  @override
  Widget build(BuildContext context) {
      return 'ex'.tr.text.make();
  }
}
''',
    'exemplo_binding.dart': '''
import '../../data/provider/exemplo_provider.dart';
import '../../data/repository/exemplo_repository.dart';
import 'controllers/exemplo_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ExemploBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ExemploController>(ExemploController(
        repository: ExemploRepository(
            exemploProvider: ExemploProvider(httpClient: http.Client()))));
  }
}
''',
    'static.dart': '''
final String url1 = "http://localhost:8080/";
final String url2 = "https://gestoreferencia-pagamento-api.herokuapp.com/";
final String url = url1;
''',
    'app_routes.dart': '''
abstract class Routes {
  static const INITIAL = '/';
  static const EXEMPLO = '/exemplo';
}''',
    'app_pages.dart': '''
import '../modules/exemplo/exemplo_binding.dart';
import '../modules/exemplo/pages/exemplo_page.dart';
import 'app_routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.EXEMPLO, page: () => ExemploPage(), binding: ExemploBinding()),
  ];
  }''',
    'pt_br_translation.dart': '''
  final Map<String, String> ptBR = {'ex': 'Exemplo', 'pripag': 'Primeira Pagina'};
  ''',
    'en_us_translation.dart': '''
  final Map<String, String> enUs = {'ex': 'Exemple', 'pripag': 'First Page'};
  ''',
    'app_translations.dart': '''
import 'en_US/en_us_translation.dart';
import 'pt_BR/pt_br_translation.dart';
  abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'pt_BR': ptBR,
    'en_US': enUs,
  };
}
  ''',
    'my_theme.dart': '''
  import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: const Color.fromARGB(255, 4, 125, 141),
  scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
  appBarTheme: const AppBarTheme(elevation: 0),
);
  ''',
    'app_binding.dart': '''
  import 'package:get/get.dart';
import 'app_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
  }
}
  ''',
    'app_controller.dart': '''
  import 'package:get/get.dart';

class AppController extends GetxController {
  AppController();

  @override
  void onClose() {
    print("object");
    super.onClose();
  }
}
  ''',
  };
}
