import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:productapp/core/models/productModel.dart';
import './views/addProduct.dart';
import './views/productDetails.dart';
import './views/homeView.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/addProduct':
        return MaterialPageRoute(builder: (_) => AddProduct());
      case '/productDetails':
        return MaterialPageRoute(
            builder: (_) => ProductDetails(
                  product: new Product(id: '', price: '', name: '', img: ''),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
