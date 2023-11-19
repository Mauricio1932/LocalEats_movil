import 'dart:convert';
import 'package:localeats/features/locales/data/models/local_model.dart';
import 'package:http/http.dart' as http;

abstract class LocalApiDatasource {
  Future<List<LocalModel>> getLocals();
  Future<List<LocalModel>> getSingleLocals(int local);
  // Future<void> postAddProduct(Local product);
  // Future<void> putUpdateProduct(Local product);
  // Future<void> deleteProduct(String id);
}

class ApiLocalDatasourceImp implements LocalApiDatasource {
  final String apiUrl = 'http://192.168.1.69:3000/api/local/viewAll';
  final String getSingleLocal ='http://192.168.1.69:3000/api/local/viewLocalById/?id=';

  @override
  Future<List<LocalModel>> getLocals() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      final locals =
          body.map((dynamic item) => LocalModel.fromJson(item)).toList();
      // print("locales ${locals}");
      // return Future.value(locals); // Envuelve la lista en un Future
      return locals;
    } else {
      throw Exception('Failed to load locals');
    }
  }

  @override
  Future<List<LocalModel>> getSingleLocals(int local) async {
    // final response = await http.get(Uri.parse('$getSingleLocal/$local'));
    print('url  $getSingleLocal$local');
    final response = await http.get(Uri.parse('$getSingleLocal$local'));

    // print("petcion ${local}");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);


      final local = body.map((dynamic item) => LocalModel.fromJson(item)).toList();

      return local ;
    } else {
      throw Exception('Failed to load product');
    }
  }

  // @override
  // Future<void> postAddProduct(Product product) async {
  //     await Future.delayed(const Duration(seconds: 2));
  //     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //     String productsString = sharedPreferences.getString('product') ?? "[]";
  //     List<UserModel> product = jsonDecode(productsString).map<UserModel>((data) => UserModel.fromJson(data)).toList();

  //     product.add(UserModel.fromEntity(product as User));
  //     sharedPreferences.setString('product', jsonEncode(product));
  //   }

  // @override
  // Future<void> putUpdateProduct(Product product) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   String productsString = sharedPreferences.getString('product') ?? "[]";
  //   List<ProductModel> productModel = jsonDecode(productsString).map<ProductModel>((data) => ProductModel.fromJson(data)).toList();

  //   productModel.removeWhere((item) => item.id == product.id);
  //   productModel.add(UserModel.fromEntity(product as User) as ProductModel);
  //   sharedPreferences.setString('product', jsonEncode(product));
  // }
}
