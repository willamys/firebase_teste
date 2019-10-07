class Item{

  String id;
  String nome;
  String preco;
  String estoque;

  Item({this.id, this.nome, this.preco, this.estoque});

  Item.fromMap(Map snapshot, String id):
    id = id ?? '',
    nome = snapshot['nome']  ?? '',
    preco = snapshot['preco']  ?? '',
    estoque = snapshot['estoque']  ?? '';

 toJson(){
   return {
     "nome": nome,
     "preco": preco,
     "estoque": estoque,
   };
 }

}