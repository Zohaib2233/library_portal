import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/generic_response_model.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('UserDetail');
class FirebaseOperation {
  static Future<Response> addUser({
    required bool isAdmin,
     Function? callBack,
    String? uid,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc(uid);

    Map<String, dynamic> userData = <String, dynamic>{

      "isAdmin" : isAdmin
    };

    var result = await documentReferencer
        .set(userData)
        .whenComplete(() {
      response.code = 200;
      response.message = "Register User Successfully";
      callBack!(response);
    })
        .catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

}