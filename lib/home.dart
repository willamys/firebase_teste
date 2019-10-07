import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_teste/userlogged.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'additem.dart';
import 'core/api.dart';
import 'core/model/item.dart';
import 'details.dart';

class Home extends StatefulWidget {
   
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  GoogleSignIn signIn = GoogleSignIn();
  
  List<Item> itens;
  Api _api = new Api('itens');

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
             icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await signIn.signOut();
               Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return UserLogin();
                          }));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return new AddItem();
          }));
        },
      ),
      body: Container(
        child: StreamBuilder(
          stream: fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              itens = snapshot.data.documents
                  .map((doc) => Item.fromMap(doc.data, doc.documentID))
                  .toList();
              return ListView.builder(
                  itemCount: itens.length,
                  itemBuilder: (buidContext, index) {
                    return new Container(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return new Detail(itens[index], index);
                          }));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(itens[index].nome),
                            leading: Icon(Icons.widgets),
                            subtitle: Text("Estoque: ${itens[index].estoque}"),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}