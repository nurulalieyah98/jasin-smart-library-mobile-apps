// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:smart_library/models/carts.dart';
// import 'package:egroceryapp/models/products.dart';
// import 'package:egroceryapp/models/recipes.dart';
// import 'package:egroceryapp/screens/customer/cart/change_cart_based_recipe.dart';
// import 'package:egroceryapp/screens/customer/payment/check_out.dart';
// import 'package:egroceryapp/services/db_query_customer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class Cart extends StatefulWidget {
//   final String uid;

//   Cart({this.uid});

//   @override
//   _CartState createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   double _price;


//   @override
//   Widget build(BuildContext context) {a
//     return FutureBuilder(
//       future: DBQueryCustomer().cartsList(widget.uid),
//       builder: (context, snapshot) {
//         List<Carts> _cartsList = snapshot.data;
//         if (snapshot.connectionState != ConnectionState.done) {
//           return Scaffold(
//             body: SpinKitCircle(
//               color: Colors.deepOrange,
//             ),
//           );
//         }
//         if (snapshot.hasData) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Cart'),
//             ),
//             body: Column(
//               children: <Widget>[
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _cartsList.length,
//                     itemBuilder: (context, index) {
//                       return FutureBuilder(
//                         future: DBQueryCustomer()
//                             .productDetailCarts(_cartsList[index].productId),
//                         builder: (context, snapshot) {
//                           List<Products> _productsList = snapshot.data;
//                           if (snapshot.connectionState !=
//                               ConnectionState.done) {
//                             return SpinKitCircle(
//                               color: Colors.deepOrange,
//                             );
//                           }
//                           if (!snapshot.hasData) {
//                             return SpinKitCircle(
//                               color: Colors.deepOrange,
//                             );
//                           }
//                           return ListView.separated(
//                             physics: ClampingScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: _productsList.length,
//                             separatorBuilder: (context, index) => Divider(
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             itemBuilder: (context, index1) => Column(
//                               children: <Widget>[
//                                 Divider(
//                                   thickness: 3.0,
//                                 ),
//                                 Dismissible(
//                                   key: Key(_cartsList[index].id),
//                                   direction: DismissDirection.endToStart,
//                                   onDismissed: (direction) async {
//                                     await DBQueryCustomer()
//                                         .deleteCart(_cartsList[index].id);
//                                     setState(() {
//                                       DBQueryCustomer().totalPrice(widget.uid);
//                                     });
//                                   },
//                                   background: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             MediaQuery.of(context).size.width /
//                                                 15),
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFFFFE6E6),
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Spacer(),
//                                         SvgPicture.asset(
//                                           'assets/icons/trash.svg',
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               15,
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height /
//                                               15,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   child: Card(
//                                     margin: EdgeInsets.symmetric(vertical: 0.0),
//                                     color: Colors.white,
//                                     elevation: 3.0,
//                                     child: Container(
//                                       padding: EdgeInsets.only(
//                                         top: MediaQuery.of(context).size.width /
//                                             25,
//                                         bottom:
//                                             MediaQuery.of(context).size.width /
//                                                 25,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           titleRecipe(_cartsList, index),
//                                           Row(
//                                             children: <Widget>[
//                                               Container(
//                                                 padding: EdgeInsets.all(
//                                                   MediaQuery.of(context)
//                                                           .size
//                                                           .width /
//                                                       25,
//                                                 ),
//                                                 child: Image(
//                                                   image: NetworkImage(
//                                                       _productsList[index1]
//                                                           .image),
//                                                   width: 120.0,
//                                                   height: 120.0,
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Container(
//                                                   padding: EdgeInsets.only(
//                                                       right:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width /
//                                                               25),
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: <Widget>[
//                                                       Text(
//                                                         _productsList[index1]
//                                                             .name,
//                                                         style: TextStyle(
//                                                           fontSize: 17.0,
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 12.0,
//                                                       ),
//                                                       Row(
//                                                         children: <Widget>[
//                                                           Text(
//                                                             'RM ' +
//                                                                 _productsList[
//                                                                         index1]
//                                                                     .price
//                                                                     .toStringAsFixed(
//                                                                         2)
//                                                                     .toString(),
//                                                             style: TextStyle(
//                                                               fontSize: 20.0,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                             ),
//                                                           ),
//                                                           Spacer(),
//                                                           Container(
//                                                             height: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width /
//                                                                 15,
//                                                             width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width /
//                                                                 15,
//                                                             child:
//                                                                 FloatingActionButton(
//                                                               heroTag: null,
//                                                               child: Icon(
//                                                                 Icons.remove,
//                                                                 color: Colors
//                                                                     .black87,
//                                                                 size: 20.0,
//                                                               ),
//                                                               backgroundColor:
//                                                                   Colors.white,
//                                                               onPressed:
//                                                                   () async {
//                                                                 setState(() {
//                                                                   if (_cartsList[
//                                                                               index]
//                                                                           .quantity ==
//                                                                       1) {
//                                                                     _cartsList[
//                                                                             index]
//                                                                         .quantity = 1;
//                                                                   } else {
//                                                                     DBQueryCustomer().updateQuantityInCart(
//                                                                         'minus',
//                                                                         _cartsList[index]
//                                                                             .quantity,
//                                                                         _cartsList[index]
//                                                                             .id);
//                                                                   }
//                                                                 });
//                                                               },
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                             child: Text(
//                                                               _cartsList[index]
//                                                                   .quantity
//                                                                   .toString(),
//                                                               style: TextStyle(
//                                                                 fontSize: 19.0,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                               ),
//                                                             ),
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                               right: MediaQuery.of(
//                                                                           context)
//                                                                       .size
//                                                                       .width /
//                                                                   30,
//                                                               left: MediaQuery.of(
//                                                                           context)
//                                                                       .size
//                                                                       .width /
//                                                                   30,
//                                                             ),
//                                                           ),
//                                                           Container(
//                                                             height: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width /
//                                                                 15,
//                                                             width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width /
//                                                                 15,
//                                                             child:
//                                                                 FloatingActionButton(
//                                                               heroTag: null,
//                                                               child: Icon(
//                                                                 Icons.add,
//                                                                 color: Colors
//                                                                     .black87,
//                                                                 size: 20.0,
//                                                               ),
//                                                               backgroundColor:
//                                                                   Colors.white,
//                                                               onPressed: () {
//                                                                 setState(() {
//                                                                   if (_cartsList[
//                                                                               index]
//                                                                           .quantity >=
//                                                                       _productsList[
//                                                                               index1]
//                                                                           .quantity) {
//                                                                     _cartsList[
//                                                                             index]
//                                                                         .quantity = _cartsList[
//                                                                             index]
//                                                                         .quantity;
//                                                                   } else {
//                                                                     DBQueryCustomer().updateQuantityInCart(
//                                                                         'plus',
//                                                                         _cartsList[index]
//                                                                             .quantity,
//                                                                         _cartsList[index]
//                                                                             .id);
//                                                                   }
//                                                                 });
//                                                               },
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         height: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .height /
//                                                             200,
//                                                       ),
//                                                       Text(
//                                                         'Quantity: ' +
//                                                             _productsList[
//                                                                     index1]
//                                                                 .quantity
//                                                                 .toString(),
//                                                       ),
//                                                       changeProducts(
//                                                           _productsList[index1]
//                                                               .subCategoryId,
//                                                           _productsList[index1]
//                                                               .uid,
//                                                           _cartsList[index].id,
//                                                           _cartsList[index]
//                                                               .fromRecipe),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 FutureBuilder(
//                   future: DBQueryCustomer().totalPrice(widget.uid),
//                   builder: (context, snapshot) {
//                     _price = snapshot.data;

//                     if (!snapshot.hasData) {
//                       return SpinKitCircle(
//                         color: Colors.deepOrange,
//                       );
//                     } else {
//                       return Card(
//                         margin: EdgeInsets.symmetric(vertical: 0.0),
//                         color: Colors.white,
//                         elevation: 3.0,
//                         child: Container(
//                           padding: EdgeInsets.all(
//                             MediaQuery.of(context).size.width / 25,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     'Total:',
//                                   ),
//                                   SizedBox(
//                                     height: 5.0,
//                                   ),
//                                   Text(
//                                     'RM ' +
//                                         _price.toStringAsFixed(2).toString(),
//                                     style: TextStyle(
//                                         fontSize: 17.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width / 5,
//                               ),
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.width / 8,
//                                   width:
//                                       MediaQuery.of(context).size.width / 2.5,
//                                   child: FlatButton(
//                                     color: Colors.deepOrange,
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => CheckOut(
//                                             price: _price,
//                                             uid: widget.uid,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Text(
//                                       'Borrow',
//                                       style: TextStyle(
//                                         fontSize: 17.0,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return SpinKitRing(
//             color: Colors.deepPurple,
//           );
//         }
//       },
//     );
//   }
// }
