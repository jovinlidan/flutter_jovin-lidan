import 'package:mini_project/model/module_model.dart';
import 'package:mini_project/services/services.dart';

class ModuleAPI {
  static Future<List<Module>> getModules() async {
    Services repo = Services();
    final response = await repo.get(url: 'Modules?\$lookup=*');
    return await Future.value(response.map<Module>((e) => Module.fromJson(e)).toList());
  }

  static Future<Module> getModule({required id}) async {
    Services repo = Services();
    final response = await repo.get(url: 'Modules/$id?\$lookup=*');
    return await Future.value(Module.fromJson(response));
  }
}
