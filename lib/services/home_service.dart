import 'dart:convert';
import 'package:app_los_pajaritos/models/home_models.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  static Map<String, dynamic> usuarioLogueado = {};
  static const String apiURL =
      "https://sastrerialospajaritos.proyectowebuni.com/api";

  static Future<List<Category>> getCategories() async {
    var url = "$apiURL/products/getCategories.php";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final categories = Categories.fromJsonList(respuestaJSON);
      return categories;
    }
    return <Category>[];
  }

  static Future<List<Category>> getCategoriesPerSex(
      String type, int cant) async {
    var url = "$apiURL/products/getCategoriesPerSex.php?categorySex=$type";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final categoriesPerSex = Categories.fromJsonList(respuestaJSON);
      if (cant.isNaN) return categoriesPerSex;
      if (categoriesPerSex.length > cant) {
        categoriesPerSex.length = cant;
      }
      return categoriesPerSex;
    }
    return <Category>[];
  }

  static Future<List<Product>> getProducts(int cant) async {
    var url = "$apiURL/products/getProducts.php";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      final products = Products.fromJsonList(respuestaJSON);
      if (products.length > cant) {
        products.length = cant;
      }
      return products;
    }
    return <Product>[];
  }

  static Future<List> getUserLoguedData(String id) async {
    var url = "$apiURL/users/getUser.php?id=$id";
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      usuarioLogueado = respuestaJSON[0];
      return respuestaJSON;
    }
    return [];
  }

  static Future<List> getMisCompras(String userID) async {
    var url = "$apiURL/sales/getSales.php?clienteID=$userID";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode(respuesta.body);
      return respuestaJSON;
    }
    return [];
  }

  static Future<Product> getProduct(String productID) async {
    var url = "$apiURL/products/getProduct.php?id=$productID";
    final respuesta = await http.get(Uri.parse(url));

    var respuestaJSON = json.decode(respuesta.body);
    final product = Product.fromJson(respuestaJSON[0]);
    return product;
  }
}
