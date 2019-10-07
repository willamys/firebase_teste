import 'package:cloud_firestore/cloud_firestore.dart';

class Api{

  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api(this.path){
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() { //buscar todos os dados
    return ref.getDocuments() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) { //buscar por id
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){ //excluir por id
    return ref.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) { // salvar novo produto
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) { // atualizar um produto
    return ref.document(id).updateData(data) ;
  }
}