class Category {
  Object id;
  String name;
  String description;
  String categorySex;
  String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.categorySex,
    required this.imageUrl,
  });

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      id: (json['_id'] as Object),
      name: json['name'] as String,
      description: json['description'] as String,
      categorySex: json['categorySex'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  String getImage() {
    return "https://sastrerialospajaritos.proyectowebuni.com/api/products/imageProducts/$imageUrl";
  }
}

class Categories {
  Categories();

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    List<Category> arrCategories = [];
    if (jsonList.isNotEmpty) {
      for (var cat in jsonList) {
        final category = Category.fromJson(cat);
        arrCategories.add(category);
      }
    }
    return arrCategories;
  }
}

class Inventario {
  String talla;
  int inventario;

  Inventario({
    required this.talla,
    required this.inventario,
  });

  static Inventario fromJson(Map<String, dynamic> json) {
    return Inventario(
      talla: json['talla'] as String,
      inventario: json['inventario'] as int,
    );
  }
}

class Inventarios {
  Inventarios();

  static List<Inventario> fromJsonList(List<dynamic> jsonList) {
    List<Inventario> arrInventario = [];
    if (jsonList.isNotEmpty) {
      for (var inv in jsonList) {
        final inventario = Inventario.fromJson(inv);
        arrInventario.add(inventario);
      }
    }
    return arrInventario;
  }
}

class Product {
  Object id;
  String categoryID;
  String title;
  String description;
  String categorySex;
  String imageUrl;
  List<Inventario> inventario;
  int precio;

  Product({
    required this.id,
    required this.categoryID,
    required this.title,
    required this.description,
    required this.categorySex,
    required this.imageUrl,
    required this.inventario,
    required this.precio,
  });

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['_id'] != null ? json['_id'] as Object : {}),
      categoryID: json['categoryID'] != null ? json['categoryID'] as String : '',
      title: json['title'] != null ? json['title'] as String : '',
      description: json['description'] != null ? json['description'] as String : '',
      categorySex: json['categorySex'] != null ? json['categorySex'] as String : '',
      imageUrl: json['imageUrl'] != null ? json['imageUrl'] as String : '',
      inventario: Inventarios.fromJsonList(json['inventario'] ?? []),
      precio: json['precio'] != null ? json['precio'] as int : 0,
    );
  }

  String getImage() {
    return "https://sastrerialospajaritos.proyectowebuni.com/api/products/imageProducts/$imageUrl";
  }
}

class Products {
  Products();

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    List<Product> arrProducts = [];
    if (jsonList.isNotEmpty) {
      for (var prod in jsonList) {
        final producto = Product.fromJson(prod);
        arrProducts.add(producto);
      }
    }
    return arrProducts;
  }
}

class Cliente {
  Object id;
  String email;
  String name;
  String password;
  bool isAdmin;

  Cliente({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.isAdmin,
  });

  static Cliente fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['_id'] as Object,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      isAdmin: json['isAdmin'] as bool,
    );
  }
}

class Clientes {
  Clientes();

  static List<Cliente> fromJsonList(List<dynamic> jsonList) {
    List<Cliente> arrClientes = [];
    if (jsonList.isNotEmpty) {
      for (var c in jsonList) {
        final cliente = Cliente.fromJson(c);
        arrClientes.add(cliente);
      }
    }
    return arrClientes;
  }
}

class Direccion {
  Object id;
  String clienteID;
  String nombre;
  String estado;
  String municipio;
  String colonia;
  String calle;
  String telefono;
  String indicaciones;

  Direccion({
    required this.id,
    required this.clienteID,
    required this.nombre,
    required this.estado,
    required this.municipio,
    required this.colonia,
    required this.calle,
    required this.telefono,
    required this.indicaciones,
  });

  static Direccion fromJson(Map<String, dynamic> json) {
    return Direccion(
      id: json['_id'] as Object,
      clienteID: json['clienteID'] as String,
      nombre: json['nombre'] as String,
      estado: json['estado'] as String,
      municipio: json['municipio'] as String,
      colonia: json['colonia'] as String,
      calle: json['calle'] as String,
      telefono: json['telefono'] as String,
      indicaciones: json['indicaciones'] as String,
    );
  }
}

class Direcciones {
  Direcciones();

  static List<Direccion> fromJsonList(List<dynamic> jsonList) {
    List<Direccion> arrDirecciones = [];
    if (jsonList.isNotEmpty) {
      for (var c in jsonList) {
        final direccion = Direccion.fromJson(c);
        arrDirecciones.add(direccion);
      }
    }
    return arrDirecciones;
  }
}
