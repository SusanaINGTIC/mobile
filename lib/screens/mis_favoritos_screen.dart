import 'dart:async';
import 'dart:convert';
import 'package:app_los_pajaritos/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(FavoritosScreen());

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Favoritos",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: const _FavoritosScreen(),
    );
  }
}

class _FavoritosScreen extends StatefulWidget {
  const _FavoritosScreen({super.key});

  @override
  FavoritosState createState() => FavoritosState();
}

class FavoritosState extends State {
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
        child: Text('Mis Favoritos'),
      ),
    );
  }
}
