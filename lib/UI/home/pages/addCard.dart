import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/UI/home/pages/details_All/card_details.dart';
import 'package:e_commerce/UI/route/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../const/appColor.dart';
import '../../../widget/fatchData.dart';

class Add_to_Card extends StatefulWidget {
  @override
  State<Add_to_Card> createState() => _Add_to_CardState();
}

class _Add_to_CardState extends State<Add_to_Card> {
  List _products = [];
  var _fireStoreInstance = FirebaseFirestore.instance;
  fetchProduct() async {
    QuerySnapshot qn =
        await _fireStoreInstance.collection('card-add-data').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]['name'],
          "product-description": qn.docs[i]['description'],
          "product-price": qn.docs[i]['price'],
          "product-img": qn.docs[i]['img'],
          "product-subtitle": qn.docs[i]['subtitle'],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("card-add-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(
                  msg: "Something is wrong",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColor.black,
                  textColor: Colors.white,
                  fontSize: 13.0);
            }

            return ListView.builder(
                itemCount:
                    snapshot.data == null ? 0 : snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];

                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {},
                      //=> Get.toNamed(card_Details,
                      //  arguments: Card_details(_products[index]),
                      // ),
                      leading: Container(
                        width: 80,
                        child: Image.network(_documentSnapshot['img'][0])),
                      title: Text(_documentSnapshot['name']),
                      subtitle: Text(
                        "\$ ${_documentSnapshot['price']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.remove_circle),
                        ),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("card-add-data")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("items")
                              .doc(_documentSnapshot.id)
                              .delete()
                              .whenComplete(() {
                            Fluttertoast.showToast(
                                msg: "Deleted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColor.black,
                                textColor: Colors.white,
                                fontSize: 13.0);
                          });
                        },
                      ),
                    ),
                  );
                });
          },
        ),
      )),
    );
  }
}
