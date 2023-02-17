import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  String _nome = '';
  late String _email;
  late String _celular;
  late String _cpf;
  late String _nascimento;

  late String _cep;
  late String _estado;
  late String _cidade;
  late String _bairro;
  late String _logradouro;
  late String _numero;

  late String _senha;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;

    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get celular => _celular;

  set celular(String value) {
    _celular = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get nascimento => _nascimento;

  set nascimento(String value) {
    _nascimento = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get logradouro => _logradouro;

  set logradouro(String value) {
    _logradouro = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }
}
