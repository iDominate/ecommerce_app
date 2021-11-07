

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';

FirebaseFirestore _fireStore = FirebaseFirestore.instance;




addProduct(Product product) async{
 await _fireStore.collection(kProductCollection).add(product.toMap());


}

 Stream<QuerySnapshot<Map<String, dynamic>>> retrieveAllProducts() {

 return  _fireStore.collection(kProductCollection).snapshots();





 }

 Stream<QuerySnapshot<Map<String, dynamic>>> retrieveProductByCategory(String category){
  return  _fireStore.collection(kProductCollection).where(kProductCategory, isEqualTo: category).snapshots();
 }


 ///A method for deleting a single product from fireStore
deleteProduct(String documentId){

 _fireStore.collection(kProductCollection).doc(documentId).delete();

}

editProduct(Product product){
  _fireStore.collection(kProductCollection).doc(product.id).update(product.toMap());
}

 storeOrders(data, List<Product> products){
 var ref =_fireStore.collection(kOrders).doc();
 ref.set(data);
 products.forEach((element) {
  ref.collection(kOrderDetails).doc().set({
   kProductName : element.name,
   kProductPrice : element.price,
   kQuantity : element.quantity,
   kProductLocation : element.location,
   kProductCategory : element.category
  });
 });
}

Stream<QuerySnapshot> loadOrders(){
 return _fireStore.collection(kOrders).snapshots();
}

Stream<QuerySnapshot> loadOrderDetails(String documentId){
 return _fireStore.collection(kOrders).doc(documentId).collection(kOrderDetails).snapshots();
}