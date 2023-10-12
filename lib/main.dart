// import 'dart:html';

import 'package:app_los_pajaritos/screens/acerca_de_screen.dart';
import 'package:app_los_pajaritos/screens/aviso_privacidad_screen.dart';
import 'package:app_los_pajaritos/screens/home_screen.dart';
import 'package:app_los_pajaritos/screens/log_in_screen.dart';
import 'package:app_los_pajaritos/screens/mis_compras_screen.dart';
import 'package:app_los_pajaritos/screens/mis_favoritos_screen.dart';
import 'package:app_los_pajaritos/screens/perfil_screen.dart';
import 'package:app_los_pajaritos/screens/preguntas_frecuentes.dart';
import 'package:app_los_pajaritos/screens/products_category_screen.dart';
import 'package:app_los_pajaritos/screens/search_screen.dart';
import 'package:app_los_pajaritos/screens/shopping_cart.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: const MyHomePage(title: appTitle),
      theme:
          ThemeData(colorSchemeSeed: Colors.red.shade200, useMaterial3: true),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? _prefs;
  bool? isAuth;
  String? name = '';
  String? email = '';
  String? id = '';

  final Color bgColor = Colors.red.shade200;

  @override
  void initState() {
    super.initState();
    _cargarPreferencias();
  }

  _cargarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
    isAuth = _prefs!.getBool('isAuth');
    id = _prefs!.getString('token');
    if (id != null) {
      if (isAuth == true) {
        name = _prefs!.getString('name');
        email = _prefs!.getString('email');
      }
    }
  }

  _cerrarSesion() {
    _prefs!.remove('isAuth');
    _prefs!.remove('token');
    _prefs!.remove('name');
    _prefs!.remove('email');
    isAuth = false;
    name = '';
    email = '';
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Center(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: TextField(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (const SearchScreen())),
                );
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Buscar en la tienda',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                  iconSize: 20,
                ),
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Badge(
                label: Text('2'),
                backgroundColor: Colors.black87,
                child: Icon(Icons.shopping_cart, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShoppingCart()),
                );
              },
            ),
          )
        ],
      ),
      body: const HomeScreen(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Builder(builder: (context) {
              if (isAuth == true) {
                return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    accountName: Text(
                      name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(
                      email ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                        radius: (52),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/images/logo/user.png"),
                        )));
              } else {
                return DrawerHeader(
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    child: ListView(
                      children: [
                        const Text(
                          'Ingresa a tu cuenta',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Podrás comprar en la tienda y ver el detalle de tus pedidos.',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          child: const Text('Inicia sesión'),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInScreen()),
                            )
                          },
                        )
                      ],
                    ));
              }
            }),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (const MyApp())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.search_outlined),
              title: const Text('Buscar'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (const SearchScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.person_outline_outlined),
              title: const Text('Mi perfil'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (isAuth == true
                          ? PerfilScreen(
                              userName: name ?? '',
                              userEmail: email ?? '',
                              id: id ?? '')
                          : const LogInScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Mis compras'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (isAuth == true
                          ? MisComprasScreen(
                              clienteID: id ?? '',
                            )
                          : const LogInScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favoritos'),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (isAuth == true
                          ? const FavoritosScreen()
                          : const LogInScreen())),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.format_list_bulleted),
              title: const Text('Categorías'),
              selected: _selectedIndex == 5,
              onTap: () {
                _onItemTapped(5);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductsCategory()),
                );
              },
              selectedColor: bgColor,
            ),
            const Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Aviso de privacidad'),
              selected: _selectedIndex == 6,
              onTap: () {
                _onItemTapped(6);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AvisoPrivacidadScreen()),
                );
              },
              selectedColor: bgColor,
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_outlined),
              title: const Text('Preguntas frecuentes'),
              selected: _selectedIndex == 7,
              onTap: () {
                _onItemTapped(7);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PreguntasFrecuentesScreen()),
                );
              },
              selectedColor: bgColor,
            ),
            const Divider(
              color: Colors.black12,
            ),
            ListTile(
              title: const Text('Acerca de Los Pajaritos'),
              selected: _selectedIndex == 8,
              onTap: () {
                _onItemTapped(8);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AcercaDeScreen()),
                );
              },
              selectedColor: bgColor,
            ),
            const Divider(
              color: Colors.black12,
            ),
            Builder(builder: (context) {
              if (isAuth == true) {
                return ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Cerrar sesión'),
                  onTap: () {
                    _cerrarSesion();
                  },
                  selectedColor: bgColor,
                );
              } else {
                return ListTile(
                  leading: const Icon(Icons.login_rounded),
                  title: const Text('Ingresar'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen()),
                    );
                  },
                  selectedColor: bgColor,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
