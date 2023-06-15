import 'package:flutter/cupertino.dart';
import 'package:products/app/pages/home/data/http/exceptions.dart';
import 'package:products/app/pages/home/data/models/produto_model.dart';
import 'package:products/app/pages/home/data/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false); 

  final ValueNotifier<List<ProdutoModel>> state =
    ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } 
    catch(e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}