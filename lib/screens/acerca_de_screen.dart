import 'dart:async';
import 'dart:convert';
import 'package:app_los_pajaritos/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(AcercaDeScreen());

class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Acerca de Sastrería Los Pajaritos",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _AcercaDeScreen(),
    );
  }
}

class _AcercaDeScreen extends StatefulWidget {
  const _AcercaDeScreen({super.key});

  @override
  AcercaDeState createState() => AcercaDeState();
}

class AcercaDeState extends State {
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
        child: Text('Sastreria "Los Pajaritos, es una empresa" '
        'Mision: Ofrecer a nuestros clientes productos de calidad a precios comodos que cumplan con las necesidades  y exigencias abarcando sus gustos de acuerdo a su estilo de ver y vivir la vida',
        
        ),
      ),
    );
  }
}
