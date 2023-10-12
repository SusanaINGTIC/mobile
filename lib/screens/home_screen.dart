import 'package:app_los_pajaritos/components/card_category_widget.dart';
import 'package:app_los_pajaritos/components/spinner_widget.dart';
import 'package:app_los_pajaritos/screens/product_detail_screen.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://sastrerialospajaritos.proyectowebuni.com/assets//resources/sld1.png',
  'https://sastrerialospajaritos.proyectowebuni.com/assets//resources/sld2.png',
  'https://sastrerialospajaritos.proyectowebuni.com/assets//resources/sld3.png',
];

final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: "\$");

void main() => runApp(const HomeScreen());

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: const EdgeInsets.all(3.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      item,
                      fit: BoxFit.fitHeight,
                      height: 1000,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(50, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.008, 0.18, 0.2, 0.5],
            colors: [
              Colors.red.shade200,
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          children: [
            Column(children: <Widget>[
              carouselSection,
              categoriesButtonSection,
              categoriesPerSex('man', 'caballero'),
              categoriesPerSex('woman', 'dama'),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  'Produtos principales',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              principalesProductosWidget(),
            ]),
          ],
        ),
      ),
    );
  }
}

Widget carouselSection = Container(
  child: CarouselSlider(
    options: CarouselOptions(
      autoPlayAnimationDuration: const Duration(seconds: 2),
      autoPlay: true,
      aspectRatio: 3.6,
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
    ),
    items: imageSliders,
  ),
);

Widget categoriesButtonSection = Column(
  children: <Widget>[
    const Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Text(
        'Categorías',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    FutureBuilder(
      future: HomeServices.getCategories(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
            height: 60.0,
            child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(2, 8, 0, 8),
                children: snapshot.data!
                    .map((categoria) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                            onPressed: () => print('sss'),
                            child: Text(categoria.name))))
                    .toList()),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SpinnerWidget(),
          );
        }
      },
    ),
  ],
);

Widget categoriesPerSex(String type, String name) => Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            "Principales categorías para $name",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
          future: HomeServices.getCategoriesPerSex(type, 2),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
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
                        (categoria) => CardCategory(
                          categoria: categoria,
                          muestraDescripcion: false,
                        ),
                      )
                      .toList(),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: SpinnerWidget(),
              );
            }
          },
        ),
      ],
    );

Widget principalesProductosWidget() => FutureBuilder(
      future: HomeServices.getProducts(6),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Wrap(
              children: snapshot.data!
                  .map(
                    (producto) => Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      width: MediaQuery.sizeOf(context).width,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color(0x411D2429),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  producto.getImage(),
                                  width: 70,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 8, 4, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      producto.title,
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 8, 0),
                                        child: Text(producto.description,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF7C8791),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailView(
                                                      productoID:
                                                          producto.id
                                                              ['\$oid'])),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color(0xFF57636C),
                                        size: 30,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 8),
                                  child: Text(
                                    numberFormat.format(producto.precio),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.red.shade300),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
          return SpinnerWidget();
        }
      },
    );
