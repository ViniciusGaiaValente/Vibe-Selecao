import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiConnection {

  static void login({
    @required String cpf,
    @required String senha,
    @required Function onSuccess,
    @required Function onError,
    @required Function onUnknownError,
    @required Function onInvalidFields,
    @required Function onInternetError,
  }) async {

    const rules = "O cpf e a senha não podem estar em branco";

    if (cpf == '' || cpf == null || senha == '' || senha == null) {
      onInvalidFields(rules);
      return;
    }

    var requestBody = jsonEncode({
      "cpf": cpf,
      "senha": md5.convert(utf8.encode(senha)).toString(),
    });

    var response = await http.post(
      'https://vibeselecao.azurewebsites.net/api/autenticacao',
      body: requestBody,
      headers: {
        'Content-Type': 'application/json',
      },
    ).catchError((err) {
      onInternetError();
      return;
    });

    if (response == null) {
      onInternetError();
      return;
    }

    try {

      var responseBody = await jsonDecode(response.body);
      var token = responseBody['chave'];
      var message = responseBody['mensagem'];

      if (response.statusCode == 200) {
        onSuccess(token);
        return;
      } else if (message != null) {
        onError(message);
        return;
      } else {
        onUnknownError();
        return;
      }

    } catch (e) {

      onUnknownError();
      return;
    }
  }

  static void register({
    @required String nome,
    @required String cpf,
    @required String senha,
    @required String nascimento,
    @required Function onSuccess,
    @required Function onError,
    @required Function onUnknownError,
    @required Function onInvalidFields,
    @required Function onInternetError,
  }) async {

    const rules = "Os campos não podem estar em branco";

    if (cpf == '' || cpf == null || senha == '' || senha == null || nome == '' || nome == null || nascimento == null || nascimento == '') {
      onInvalidFields(rules);
      return;
    }

    var requestBody = jsonEncode({
      "nome": nome,
      "cpf": cpf.trim(),
      "nascimento": nascimento,
      "senha": md5.convert(utf8.encode(senha)).toString(),
    });

    var response = await http.post(
      'https://vibeselecao.azurewebsites.net/api/usuario',
      body: requestBody,
      headers: {
        'Content-Type': 'application/json',
      },
    ).catchError((err) {
      onInternetError();
      return;
    });

    if (response == null) {
      onInternetError();
      return;
    }

    try {

      var responseBody = await jsonDecode(response.body);
      var message = responseBody['mensagem'];

      if (response.statusCode == 200) {
        onSuccess();
        return;
      } else if (message != null) {
        onError(message);
        return;
      } else {
        onUnknownError();
        return;
      }
    } catch (e) {

      if (response.statusCode == 200) {
        onSuccess();
        return;
      } else {
        onUnknownError();
        return;
      }
    }
  }

  static showUser({
    @required String token,
    @required String cpf,
    @required Function onSuccess,
    @required Function onInvalidToken,
    @required Function onInternetError,
    @required Function onUnknownError,
  }) async {

    var response = await http.get(
      'https://vibeselecao.azurewebsites.net/api/usuario/$cpf',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).catchError((err) {
      onInternetError();
      return;
    });

    if (response == null) {
      onInternetError();
      return;
    }

    try {

      var responseBody = jsonDecode(response.body);
      var message = responseBody['mensagem'];

      if (response.statusCode == 200) {
        onSuccess(responseBody);
        return;
      } else {
        onUnknownError();
        return;
      }

    } catch (e) {

      if (response.statusCode == 401 || response.statusCode == 403) {
        onInvalidToken();
        return;
      } else {
        onUnknownError();
        return;
      }
    }
  }

  static void listClients({
    @required String token,
    @required Function onSuccess,
    @required Function onInvalidToken,
    @required Function onInternetError,
    @required Function onUnknownError,
  }) async {

    var response = await http.get(
      'https://vibeselecao.azurewebsites.net/api/cliente',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).catchError((err) {
      onInternetError();
      return;
    });

    if (response == null) {
      onInternetError();
      return;
    }

    try {

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        onSuccess(responseBody);
        return;
      } else {
        onUnknownError();
        return;
      }

    } catch (e) {

      if (response.statusCode == 401 || response.statusCode == 403) {
        onInvalidToken();
        return;
      } else {
        onUnknownError();
        return;
      }
    }
  }

  static void showClient({
    @required String token,
    @required String id,
    @required Function onSuccess,
    @required Function onInvalidToken,
    @required Function onInternetError,
    @required Function onUnknownError,
  }) async {

    var response = await http.get(
      'https://vibeselecao.azurewebsites.net/api/cliente/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).catchError((err) {
      onInternetError();
      return;
    });

    if (response == null) {
      onInternetError();
      return;
    }

    try {

      var responseBody = jsonDecode(response.body);
      var message = responseBody['mensagem'];

      if (response.statusCode == 200) {
        onSuccess(responseBody);
        return;
      } else {
        onUnknownError();
        return;
      }

    } catch (e) {

      if (response.statusCode == 401 || response.statusCode == 403) {
        onInvalidToken();
        return;
      } else {
        onUnknownError();
        return;
      }
    }
  }
}