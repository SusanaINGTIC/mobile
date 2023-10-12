import 'package:app_los_pajaritos/models/home_models.dart';
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  Category categoria;
  bool muestraDescripcion;

  CardCategory({required this.categoria, required this.muestraDescripcion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.45,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 209, 209, 209),
              offset: Offset(
                2.0,
                5.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 0.2,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    categoria.getImage(),
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: Center(
                  child: Text(
                    categoria.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              if (muestraDescripcion)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Center(
                    child: Text(
                      categoria.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () => print('sss'),
                      child: const Text('Ver categoría')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
