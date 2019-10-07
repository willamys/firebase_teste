import 'package:firebase_teste/core/model/item.dart';
import 'package:firebase_teste/edititem.dart';
import 'package:flutter/material.dart';

import 'core/api.dart';
import 'home.dart';

class Detail extends StatefulWidget {
  Item item;
  int index;

  Detail(this.item, this.index);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Api _api = new Api('itens');
  void _confirm() {
    AlertDialog alert = AlertDialog(
      content:
          new Text("Deseja realmente deletar o item '${widget.item.nome}'"),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "Sim",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            await _api.removeDocument(widget.item.id);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return Home();
            }));
          },
        ),
        RaisedButton(
          child: Text("Não", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: context, child: alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.item.nome}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _confirm();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return EditItem(item: widget.item);
              }));
            },
          )
        ],
      ),
      body: new Container(
        height: 220.0,
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                Text(
                  widget.item.nome,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "Preço: ${widget.item.preco}",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "Estoque: ${widget.item.estoque}",
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
