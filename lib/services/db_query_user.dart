import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_library/models/books.dart';
import 'package:smart_library/models/carts.dart';

class DBQueryUser {
  // Collection Reference (Products)
  final CollectionReference _booksCollection =
      FirebaseFirestore.instance.collection('books');

  // Collection Reference (Carts)
  final CollectionReference _cartsCollection =
      FirebaseFirestore.instance.collection('carts');

  // Add Book for Confirmation Borrow
  Future addGroceries(String userId, String borrowId) async {
    try {
      QuerySnapshot snapshot =
          await _cartsCollection.where('user_id', isEqualTo: userId).get();

      List<Carts> _cart = snapshot.docs
          .map(
            (e) => Carts(
              id: e.get('id'),
              userId: e.get('user_id'),
              bookId: e.get('book_id'),
              quantity: e.get('quantity'),
            ),
          )
          .toList();

      for (int i = 0; i < _cart.length; i++) {
        String refId = _cartsCollection.doc().id;
        await _cartsCollection.doc(refId).set({
          'id': refId,
          'borrow_id': borrowId,
          'book_id': _cart[i].bookId,
          'quantity': _cart[i].quantity,
        });
        await deleteCart(_cart[i].id);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Update Quantity Item in Cart
  void updateQuantityInCart(String action, int quantity, String borrowId) {
    try {
      if (action == 'minus') {
        quantity--;

        _cartsCollection.doc(borrowId).update({
          'quantity': quantity,
        });
      } else if (action == 'plus') {
        quantity++;

        _cartsCollection.doc(borrowId).update({
          'quantity': quantity,
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // View List of Borrows
  Future cartsList(String custId) async {
    try {
      QuerySnapshot snapshot =
          await _cartsCollection.where('customer_id', isEqualTo: custId).get();

      return snapshot.docs
          .map(
            (e) => Carts(
              id: e.get('id'),
              userId: e.get('user_id'),
              bookId: e.get('book_id'),
              quantity: e.get('quantity'),
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future bookDetailBorrows(String id) async {
    try {
      QuerySnapshot snapshotProducts =
          await _cartsCollection.where('id', isEqualTo: id).get();

      return snapshotProducts.docs
          .map(
            (e) => Carts(
              id: e.get('id'),
              userId: e.get('user_id'),
              bookId: e.get('book_id'),
              quantity: e.get('quantity'),
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  // Delete Cart
  Future deleteCart(String id) async {
    await _cartsCollection.doc(id).delete();
  }

  // Add Product to Cart
  Future addProductToCart(String custId, String productId, int quantity,
      bool fromRecipe, String recipeId) async {
    String refId = _cartsCollection.doc().id;

    try {
      QuerySnapshot snapshot = await _cartsCollection
          .where('product_id', isEqualTo: productId)
          .where('customer_id', isEqualTo: custId)
          .get();

      if (snapshot.size == 0 && fromRecipe == false) {
        await _cartsCollection.doc(refId).set({
          'id': refId,
          'customer_id': custId,
          'product_id': productId,
          'quantity': quantity,
          'from_recipe': fromRecipe,
          'recipe_id': null,
        });
      } else if (snapshot.size == 0 && fromRecipe == true) {
        await _cartsCollection.doc(refId).set({
          'id': refId,
          'customer_id': custId,
          'product_id': productId,
          'quantity': quantity,
          'from_recipe': fromRecipe,
          'recipe_id': recipeId
        });
      } else {
        QuerySnapshot snapshot = await _cartsCollection
            .where('product_id', isEqualTo: productId)
            .where('customer_id', isEqualTo: custId)
            .limit(1)
            .get();

        DocumentSnapshot documentSnapshot = snapshot.docs.first;
        final userDocId = documentSnapshot.id;

        _cartsCollection.doc(userDocId).update({
          'quantity': quantity,
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Get All Books Data from Snapshot
  Future<List<Books>> booksList(String uid) async {
    try {
      final QuerySnapshot snapshot = await _booksCollection.get();

      return snapshot.docs
          .map(
            (e) => Books(
              uid: e.id,
              title: e.get('title') ?? '',
              author: e.get('author') ?? '',
              category: e.get('category') ?? '',
              synopsis: e.get('synopsis') ?? '',
              url: e.get('url') ?? '',
              shelves: e.get('shelves') ?? '',
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  //Get One Book Data from Snapshot
  Future bookDetailCarts(uid) async {
    try {
      final DocumentSnapshot snapshot = await _booksCollection.doc(uid).get();
      return Books(
        uid: uid,
        title: snapshot.get('title') ?? '',
        author: snapshot.get('author') ?? '',
        category: snapshot.get('category') ?? '',
        shelves: snapshot.get('shelves') ?? '',
        url: snapshot.get('url') ?? '',
        synopsis: snapshot.get('synopsis') ?? '',
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //Get All book level 1 Data
  Future bookLevel1(String uid) async {
    try {
      QuerySnapshot snapshot = await _booksCollection
          .where('beaconId', isEqualTo: 'b9407f30-f5f8-466e-aff9-25556b57fe6a')
          .get();

      return snapshot.docs
          .map(
            (e) => Books(
              uid: e.id,
              title: e.get('title') ?? '',
              author: e.get('author') ?? '',
              category: e.get('category') ?? '',
              synopsis: e.get('synopsis') ?? '',
              url: e.get('url') ?? '',
              shelves: e.get('shelves') ?? '',
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  //Get All book level 2 Data
  Future bookLevel2(String uid) async {
    try {
      QuerySnapshot snapshot = await _booksCollection
          .where('beaconId', isEqualTo: 'b9407f30-f5f8-466e-aff9-25556b57fe6b')
          .get();

      return snapshot.docs
          .map(
            (e) => Books(
              uid: e.id,
              title: e.get('title') ?? '',
              author: e.get('author') ?? '',
              category: e.get('category') ?? '',
              synopsis: e.get('synopsis') ?? '',
              url: e.get('url') ?? '',
              shelves: e.get('shelves') ?? '',
            ),
          )
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }
}
