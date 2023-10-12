import 'package:app_los_pajaritos/components/spinner_widget.dart';
import 'package:app_los_pajaritos/services/home_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

Color bgColor = Colors.red.shade200;
final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: "\$");

class MisComprasScreen extends StatelessWidget {
  String clienteID;
  MisComprasScreen({super.key, required this.clienteID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Mis compras",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: _MisComprasScreen(clienteID: clienteID),
    );
  }
}

class _MisComprasScreen extends StatefulWidget {
  String clienteID;
  _MisComprasScreen({super.key, required this.clienteID});

  @override
  MisComprasState createState() => MisComprasState(clienteID: clienteID);
}

class MisComprasState extends State {
  String clienteID;
  MisComprasState({required this.clienteID});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Mis compras',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            principalesProductosWidget(clienteID),
          ]),
        ],
      ),
    );
  }
}

Widget principalesProductosWidget(String clienteID) => FutureBuilder(
      future: HomeServices.getMisCompras(clienteID),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          String parseDate(String date) {
            var arrFecha = date.split('(');
            var fechaTxt = arrFecha[0].trim();
            var fecha =
                DateFormat('EEE MMM dd yyyy HH:mm:ss \'GMT\'').parse(fechaTxt);
            final result = DateFormat('dd/mm/yyyy HH:mm a').format(fecha);
            return result;
          }

          return Padding(
            padding: const EdgeInsets.all(0),
            child: Wrap(
              children: snapshot.data!
                  .map(
                    (compra) => Container(
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
                                      parseDate(compra['fechaVenta']),
                                      style: TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade300),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 8, 0),
                                        child: Text(
                                            'A nombre de ' +
                                                compra['nombreCliente'],
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
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: Color(0xFF57636C),
                                    size: 30,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 0),
                                  child: Text(
                                    "Total de compra",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 8),
                                  child: Text(
                                    numberFormat.format(compra['total']),
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
