import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


//background color
const kMainBackgroundColor = Color(0xFFFFC12F);
const kSecondaryColor = Color(0xFFFFE6AC);
const kInactiveColor = Color(0xFFC1BDB8);


///product field constants
const kProductName = 'Name';
const kProductPrice = 'Price';
const kProductDescription = 'Description';
const kProductCategory = 'Category';
const kProductLocation = 'Location';
const kProductId = 'id';


///Product collection on FirebaseFirestore
const kProductCollection = 'Products';

const kIsProductEdit = false;
const kProductIdentifier = 'product';

///Product Categories
const kJackets = 'jackets';
const kShoes = 'Shoes';
const kTrousers = 'Trousers';
const kTShirts = 'T-Shirts';

///Order Details
const kOrders = 'Orders';
const kOrderDetails = 'OrderDetails';
const kTotalPrice = 'TotalPrice';
const kAddress = 'Address';
const kQuantity = 'Quantity';


///For Remembering the user
const kKeepMeLoggedIn = 'Login';
