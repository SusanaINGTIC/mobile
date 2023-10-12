import 'package:app_los_pajaritos/components/spinner_widget.dart';
import 'package:app_los_pajaritos/models/home_models.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color bgColor = Colors.red.shade200;
final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: "\$");

class ProductDetailView extends StatefulWidget {
  String productoID;
  ProductDetailView({Key? key, required this.productoID}) : super(key: key);

  @override
  State<ProductDetailView> createState() =>
      _ProductDetailState(productoID: this.productoID);
}

class _ProductDetailState extends State<ProductDetailView> {
  String productoID;
  String precio = '0';
  String productName = '';
  _ProductDetailState({required this.productoID});
  @override
  void initState() {
    super.initState();
    precio = numberFormat.format(0);
  }

  String getImageUrl(String productName) {
    return "https://sastrerialospajaritos.proyectowebuni.com/api/products/imageProducts/$productName";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(productName),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red.shade200,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {},
              icon: const Badge(
                label: Text('2'),
                backgroundColor: Colors.black87,
                child: Icon(Icons.shopping_cart, color: Colors.white),
              )),
        ],
      ),
      body: FutureBuilder(
        future: HomeServices.getProduct(productoID),
        builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
          if (snapshot.hasData) {
            Future.delayed(Duration.zero, () {
              setState(() {
                precio = numberFormat.format(snapshot.data!.precio);
                productName = snapshot.data!.title;
              });
            });

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: ClipRRect(
                    child: Image.network(
                      getImageUrl(snapshot.data!.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 0),
                  child: Text(
                    'Categoria',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 0, bottom: 0),
                  child: Text(
                    'Disponible',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.red.shade200),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 5, bottom: 5),
                  child: Text(
                    snapshot.data!.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 14,
                      right: 14,
                      top: 5,
                      bottom: MediaQuery.of(context).padding.bottom),
                  child: Text(
                    // widget.product.description,
                    snapshot.data!.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 5, 14, 0),
                  height: 55.0,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      children: snapshot.data!.inventario
                          .map((inv) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: OutlinedButton(
                                  onPressed: () => print('sss'),
                                  child: Text(inv.talla.toUpperCase()))))
                          .toList()),
                )
              ],
            );
          } else {
            return SpinnerWidget();
          }
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black87,
        height: 80 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 10,
          top: 10,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Precio",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  // '\$${_selectedPriceTag.price}',
                  precio,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Agregar al carrito"),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Comprar ahora"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
