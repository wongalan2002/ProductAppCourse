import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../services/api.dart';
import '../models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api? _api = getIt<Api>();

  List<Product>? products;

  Product _myProduct =
      new Product(id: 'null', price: 'null', name: 'null', img: 'null');
  Product get myProduct => _myProduct;

  Future<List<Product>?> fetchProducts() async {
    var result = await _api!.getDataCollection();
    products = result.docs
        .map((doc) =>
            Product.fromMap(doc.data() as Map<dynamic, dynamic>, doc.id))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api!.streamDataCollection();
  }

  void getProductById(String id) async {
    var doc = await _api!.getDocumentById(id);
    // notifyListeners();
    _myProduct = Product.fromMap(doc.data() as Map<dynamic, dynamic>, doc.id);
    // print(_myProduct.name);
    notifyListeners();
    // return Product.fromMap(doc.data() as Map<dynamic, dynamic>, doc.id);
  }

  // Future<Product> getProductById(String id) async {
  //   var doc = await _api!.getDocumentById(id);
  //   // notifyListeners();
  //   _myProduct = Product.fromMap(doc.data() as Map<dynamic, dynamic>, doc.id);
  //   // print(_myProduct.name);
  //   notifyListeners();
  //   return _myProduct;
  //   // return Product.fromMap(doc.data() as Map<dynamic, dynamic>, doc.id);
  // }

  Future removeProduct(String? id) async {
    await _api!.removeDocument(id);
    notifyListeners();
    return;
  }

  Future updateProduct(Product data, String? id) async {
    await _api!.updateDocument(data.toJson(), id);
    notifyListeners();
    return;
  }

  Future addProduct(Product data) async {
    var result = await _api!.addDocument(data.toJson());
    notifyListeners();
    return;
  }
}
