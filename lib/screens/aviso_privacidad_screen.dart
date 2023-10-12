import 'dart:async';
import 'dart:convert';
import 'package:app_los_pajaritos/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(AvisoPrivacidadScreen());

class AvisoPrivacidadScreen extends StatelessWidget {
  const AvisoPrivacidadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Aviso de privacidad",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _AvisoPrivacidadScreen(),
    );
  }
}

class _AvisoPrivacidadScreen extends StatefulWidget {
  const _AvisoPrivacidadScreen({super.key});

  @override
  AvisoPrivacidadState createState() => AvisoPrivacidadState();
}

class AvisoPrivacidadState extends State {
  SharedPreferences? _prefs;

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
    return const Scaffold(
      body: Center(
        child: Text('Sastreria "Los Pajaritos",'),
      ),
    );
  }
}
