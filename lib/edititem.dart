import 'package:flutter/material.dart';

import 'core/api.dart';
import 'core/model/item.dart';

class EditItem extends StatefulWidget {
  final Item item;

  EditItem({@required this.item});

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {

String nome ;

String preco ;

String estoque ;

Api _api = new Api('itens');

GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: Text("Edit Item"),),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  initialValue: widget.item.nome,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nome"
                  ),
                  style: TextStyle(fontSize: 16.0),
                 // controller: nomeController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Informe o Nome";
                    }
                  },
                  onSaved: (value){
                    return nome = value;
                  },
                ),
                TextFormField(
                  initialValue: widget.item.preco,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Preco",
                  ),
                  style: TextStyle(fontSize: 16.0),
                  //controller: precoController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Informe o preço";
                    }
                  },
                  onSaved: (value){
                    return preco = value;
                  },
                ),
                TextFormField(
                   initialValue: widget.item.estoque,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Estoque",
                  ),
                  style: TextStyle(fontSize: 16.0),
                 // controller: estoqueController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Informe o estoque";
                    }
                  },
                  onSaved: (value){
                    return estoque = value;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          await _api.updateDocument(
                            Item(nome: nome, 
                            preco: preco, 
                            estoque: estoque).toJson(), widget.item.id);
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Modificar', style: TextStyle(color: Colors.white)),
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