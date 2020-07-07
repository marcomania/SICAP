import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Voucher>> fetchVouchers(http.Client client) async {
  final response = await client.get(
      'https://sigapdev2-consultarecibos-back.herokuapp.com/recaudaciones/alumno/concepto/listar_cod/18207001');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseVoucher, response.body);
}

class Voucher {
  final int idRec;
  final int idAlum;
  final String apeNom;
  final int ciclo;
  final String concepto;
  final int idconcepto;
  final String numero;
  final String dni;
  final String nombre;
  final String moneda;
  final String moneda2;
  final int importe;
  final int importe_tc;
  final String fecha;
  final String anio_ingreso;
  final int idPrograma;
  final String nomPrograma;
  final String sigla_programa;
  final String codAlumno;
  final String estado;
  final String descripcion_ubi;
  final String descripcion_tipo;
  final String estado_civil;
  final bool validado;
  final String repitencia;
  final int id_tip_grado;
  final int id_tipo_recaudacion;
  final String observacion;

  Voucher(
      {this.idRec,
      this.idAlum,
      this.apeNom,
      this.ciclo,
      this.concepto,
      this.idconcepto,
      this.numero,
      this.dni,
      this.nombre,
      this.moneda,
      this.moneda2,
      this.importe,
      this.importe_tc,
      this.fecha,
      this.anio_ingreso,
      this.idPrograma,
      this.nomPrograma,
      this.sigla_programa,
      this.codAlumno,
      this.estado,
      this.descripcion_ubi,
      this.descripcion_tipo,
      this.estado_civil,
      this.validado,
      this.repitencia,
      this.id_tip_grado,
      this.id_tipo_recaudacion,
      this.observacion});

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      idRec: json['idRec'] as int,
      idAlum: json['idAlum'] as int,
      apeNom: json['apeNom'] as String,
      ciclo: json['ciclo'] as int,
      concepto: json['concepto'] as String,
      idconcepto: json['idconcepto'] as int,
      numero: json['numero'] as String,
      dni: json['dni'] as String,
      nombre: json['nombre'] as String,
      moneda: json['moneda'] as String,
      moneda2: json['moneda2'] as String,
      importe: json['importe'] as int,
      importe_tc: json['importe_tc'] as int,
      fecha: json['fecha'] as String,
      anio_ingreso: json['anio_ingreso'] as String,
      idPrograma: json['idPrograma'] as int,
      nomPrograma: json['nomPrograma'] as String,
      sigla_programa: json['sigla_programa'] as String,
      codAlumno: json['codAlumno'] as String,
      estado: json['estado'] as String,
      descripcion_ubi: json['descripcion_ubi'] as String,
      descripcion_tipo: json['descripcion_tipo'] as String,
      estado_civil: json['estado_civil'] as String,
      validado: json['validado'] as bool,
      repitencia: json['repitencia'] as String,
      id_tip_grado: json['id_tip_grado'] as int,
      id_tipo_recaudacion: json['id_tipo_recaudacion'] as int,
      observacion: json['observacion'] as String,
    );
  }
}

// A function that converts a response body into a List<Voucher>.
List<Voucher> parseVoucher(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Voucher>((json) => Voucher.fromJson(json)).toList();
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Vouchers de JHON HAMILTON AGUILAR ROMERO';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.indigo[900],
      ),
      body: FutureBuilder<List<Voucher>>(
        future: fetchVouchers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Voucher> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: photos == null ? 0 : photos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                children: <Widget>[
                  /*CircleAvatar(
                    radius: 40.0,
                    //backgroundImage: NetworkImage(photos[index]['avatar']),
                  ),*/
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${photos[index].idRec}  ${photos[index].descripcion_tipo} ${photos[index].fecha} S/. ${photos[index].importe}.00",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
