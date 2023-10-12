import 'dart:async';
import 'dart:convert';
import 'package:app_los_pajaritos/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Color bgColor = const Color.fromARGB(255, 248, 249, 250);
void main() => runApp(LogInScreen());

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _LogInScreen(),
    );
  }
}

class _LogInScreen extends StatefulWidget {
  const _LogInScreen({super.key});

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State {
  SharedPreferences? _prefs;

  TextEditingController emailTxt = TextEditingController();
  TextEditingController passTxt = TextEditingController();

  Future<List> _login(BuildContext context) async {
    var usuario = emailTxt.text.toString();
    var contra = passTxt.text.toString();
    var uri =
        "https://sastrerialospajaritos.proyectowebuni.com/api/users/login.php?email=$usuario&password=$contra";
    final response = await http.get(Uri.parse(uri));
    var datauser = json.decode(response.body);
    if (datauser.length > 0) {
      if (datauser[0]['isAdmin']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Acceso no válido',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Bienvenido',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        _prefs!.setBool('isAuth', true);
        _prefs!.setString('token', datauser[0]['_id']['\$oid']);
        _prefs!.setString('email', datauser[0]['email']);
        _prefs!.setString('name', datauser[0]['name']);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Email o contraseña incorrectos',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
    return datauser;
  }

  @override
  void initState() {
    super.initState();
    _cargarPreferencias();
  }

  _cargarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bgColor,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Por favor,',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ),
                        const Text(
                          'Inicia sesión para continuar...',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Image.asset(
                            'assets/images/logo/logo.png',
                            scale: 4.5,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(-0, -2),
                        blurRadius: 30)
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade200,
                      Colors.red.shade300,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Form(
                  // key: logInKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.shade100,
                                  offset: const Offset(1, 2),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hoverColor: Colors.grey,
                                isDense: true,
                                isCollapsed: true,
                                hintText: 'Correo electrónico',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(25),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(
                                    Icons.email_rounded,
                                    size: 25,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                fillColor: Colors.grey.shade50,
                                focusColor: Colors.grey.shade50,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              controller: emailTxt,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Por favor ingresa tu correo electrónico';
                                }
                                return null;
                              },
                              // onSaved: (val) {
                              //   logEmail = val;
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(1, 2),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Contraseña',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(25),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(
                                    Icons.password,
                                    size: 25,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                fillColor: Colors.grey.shade50,
                                focusColor: Colors.grey.shade50,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              obscuringCharacter: '*',
                              // obscureText: logViewPassword,
                              controller: passTxt,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Por favor ingresa tu contraseña';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                // setState(() {
                                //   logPassword = val;
                                // });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                            ),
                            onPressed: () {
                              _login(context);
                            },
                            child: const SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                '¿No tienes una cuenta? Registrate',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
