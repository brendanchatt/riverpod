// ignore_for_file: use_key_in_widget_constructors, omit_local_variable_types

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Package {
  static Package fromJson(dynamic json) {
    throw UnimplementedError();
  }
}

/* SNIPPET START */

// Recupera l'elenco dei package da pub.dev
final fetchPackagesProvider = FutureProvider.autoDispose
    .family<List<Package>, ({int page, String? search})>((ref, params) async {
  final page = params.page;
  final search = params.search ?? '';
  final dio = Dio();
  // Effettua una richiesta API. Qui stiamo utilizzando il package 'dio', ma potremmo usare qualsiasi altro package.
  final response = await dio.get<List<Object?>>(
    'https://pub.dartlang.org/api/search?page=$page&q=${Uri.encodeQueryComponent(search)}',
  );

  // Decodifica la risposta JSON in una classe Dart.
  return response.data?.map(Package.fromJson).toList() ?? const [];
});
