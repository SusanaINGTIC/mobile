import 'dart:async';
import 'dart:convert';
import 'package:app_los_pajaritos/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(SearchScreen());

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.red.shade100,
          foregroundColor: Colors.red.shade200,
          title: const Center(
              child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar en Sastrería Los Pajaritos',
              hintStyle: TextStyle(color: Colors.black26),
              // contentPadding: EdgeInsets.all(12),
              border: InputBorder.none,
              fillColor: Colors.white,
            ),
          ))),
      body: const _SearchScreen(),
    );
  }
}

class _SearchScreen extends StatefulWidget {
  const _SearchScreen({super.key});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State {
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
        child: Text('Resultado'),
      ),
    );
  }
}
