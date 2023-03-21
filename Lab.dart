///
/// Laboratorio 1:
/// 
/// Un programa en consola, para una pizzeria utilizar todo lo visto en clase:
/// 
/// 
/// La consola debe mostrar el menu
/// 
/// 1). Pizza Grande = 6.000
/// 2). Pizza Mediana = 3.000
/// 3). Pizza Pequeña = 1.000
///
///
/// Espera que el usuario escoja del menu la opción
/// 
/// 3
/// 
/// Pregunta cuantas pizzas quiere
/// 
/// 8
/// 
/// Espera que escriba la cantidad
/// 
/// 
/// Finaliza mostrando la orden 
/// 
/// Total: 8.000 por 8 pizza pequeña
///
///
///

import 'dart:io';
void main() {
  List<Map> products = [{'name':'Pizza Grande','value':6000},{'name':'Pizza Mediana','value':3000},{'name':'Pizza Pequeña','value':1000}];
  Pizzeria pizzeria = Pizzeria('Delizioso', products);
  pizzeria.sell();
}

abstract class Store {
  String _name;
  int? id;
  String? field;
  List<Map> products;

  Store(this._name, this.products, this.id, this.field);

  Store.essentialInfo(this._name, this.products, {this.id, this.field});

  String get getName {
    return _name;
  }

  void set setName(String name) {
    _name = name;
  }

  int _showProducts (){
    int? product;
    int pro = 0;
    if (products.length > 0){
      print('Nuestros productos: ');
      for (var i = 0; i < products.length; i++) {
        String productName = products[i]['name'];
        int j = i+1;
        print('$j) $productName');
      }
      print('Escriba el número de opción que desea y presione la tecla Enter');
      var prod = stdin.readLineSync();
      product = int.tryParse(prod ?? "");
      if (product == null){
        _showProducts ();
      } else {
        pro = product - 1;
      }
    } else {
      print('Recuerde ingresar los productos');
    }
    return pro;
  }

  int _howManyProducts (){
    int? quantity;
    int quant = 0;
    if (products.length > 0){
      print('Escriba la cantidad: ');
      var quantityString = stdin.readLineSync();
      quantity = int.tryParse(quantityString ?? "");
      if (quantity == null){
        _howManyProducts ();
      } else {
        quant = quantity;
      }
    }
    return quant;
  }

  sell (){
    int productSelected = _showProducts();
    int quantity = _howManyProducts();
    var totalValue = quantity * products[productSelected]['value'];
    String productName = products[productSelected]['name'];
    print('Total: $totalValue por $quantity $productName');
  }

}

enum Flavors {
  Hawaiana,
  Peperoni,
  Vegetales,
  Anchoas
}

class Pizzeria extends Store {
  String name;
  int? id;
  String? field;
  List<Map> products;
  Flavors? _flavor;

  Flavors? get flavor => _flavor;

  set flavor(Flavors? value) => _flavor  = Flavors.Hawaiana;

  Pizzeria(this.name, this.products,{this.id, this.field}):super.essentialInfo(name, products, id: id, field: field) ;

  _showFlavors (){
    int? productFlavor;
    if (products.length > 0){
      print('Nuestros sabores: ');
      List <String> flavors = ['Hawaiana','Peperoni','Vegetariana','Anchoas'];
      for (var i = 0; i < flavors.length; i++) {
        int j = i+1;
        var showFlavor = flavors[i];
        print('$j) $showFlavor');
      }
      print('Escriba el número de opción que desea y presione la tecla Enter');
      var flavor = stdin.readLineSync();
      productFlavor = int.tryParse(flavor ?? "");
      switch (productFlavor) {
        case 1:
          this._flavor = Flavors.Hawaiana;
          break;
        case 2:
          this._flavor = Flavors.Peperoni;
          break;
        case 3:
          this._flavor = Flavors.Vegetales;
          break;
        case 4:
          this._flavor = Flavors.Anchoas;
          break;
        default:
          _showFlavors ();
      }
    }
  }

  @override
  sell (){
    _showFlavors ();
    super.sell();
    var flavor = _flavor.toString().split(".")[1];
    print('Disfrute su pizza de $flavor');
  }
}