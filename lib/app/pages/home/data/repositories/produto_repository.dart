import 'dart:convert';

import 'package:products/app/pages/home/data/http/exceptions.dart';
import 'package:products/app/pages/home/data/http/http_client.dart';
import 'package:products/app/pages/home/data/models/produto_model.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> getProdutos();
}

class ProdutoRepository implements IProdutoRepository {

final IHttpClient client;

  ProdutoRepository({required this.client});

  @override
  Future<List> getProdutos() async {
    final response = await client.get(
      url: 'https://dummyjson.com/products'
      );
  }

  if(response.statusCode == 200) {
    final List<ProdutoModel> produtos = [];

    final body = jsonDecode(response.body);

    body ['products'].map((item) {
      final ProdutoModel produto = ProdutoModel.fromMap(item);
      produtos.add(produto);
    }).toList();

    return produtos;
    } else if (response.statusCode = 404) {
        throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar os produtos');
    }
  }
}