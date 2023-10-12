import 'package:app_los_pajaritos/components/card_category_widget.dart';
import 'package:app_los_pajaritos/components/spinner_widget.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
void main() => runApp(const ProductsCategory());

class ProductsCategory extends StatelessWidget {
  const ProductsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white60,
          title: const Text(
            "Categorías",
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: bgColor,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          children: [
            Column(
              children: <Widget>[
                FutureBuilder(
                  future: HomeServices.getCategories(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: snapshot.data!
                              .map(
                                (categoria) => Column(children: [
                                  CardCategory(
                                    categoria: categoria,
                                    muestraDescripcion: true,
                                  )
                                ]),
                              )
                              .toList(),
                        ),
                      );
                    } else {
                      return SpinnerWidget();
                    }
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
