import 'package:flutter/material.dart';
import 'core/api.dart';
import 'package:firebase_teste/core/model/item.dart';

import 'home.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController estoqueController = TextEditingController();
  Api _api = new Api('itens');

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Nome"),
                style: TextStyle(fontSize: 16.0),
                controller: nomeController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe o Nome";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preco",
                ),
                style: TextStyle(fontSize: 16.0),
                controller: precoController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe o preço";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Estoque",
                ),
                style: TextStyle(fontSize: 16.0),
                controller: estoqueController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe o estoque";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        await _api.addDocument(Item(
                                nome: nomeController.text,
                                preco: precoController.text,
                                estoque: estoqueController.text)
                            .toJson());
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Home();
                        }));
                      }
                    },
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
