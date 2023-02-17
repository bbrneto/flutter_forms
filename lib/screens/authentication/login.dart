import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_forms/components/message.dart';
import 'package:flutter_forms/screens/authentication/register.dart';
import 'package:flutter_forms/screens/dashboard/dashboard.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class Login extends StatelessWidget {
  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 430,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _construirFormulario(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(71, 161, 56, 1),
    );
  }

  Widget _construirFormulario(context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const Text(
            'Faça seu login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'CPF',
            ),
            maxLength: 14,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) => Validator.cpf(value) ? 'CPF inválido' : null,
            keyboardType: TextInputType.number,
            controller: _cpfController,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Senha',
            ),
            maxLength: 15,
            validator: (value) {
              return value!.isEmpty ? 'Informe a senha!' : null;
            },
            keyboardType: TextInputType.text,
            controller: _senhaController,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  if (_cpfController.text == '451.339.011-51' && _senhaController.text == '123') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ),
                        (route) => false);
                  } else {
                    showAlert(
                      context: context,
                      title: 'ATENÇÃO',
                      content: 'CPF ou senha incorretos!',
                    );
                  }
                }
              },
              child: const Text('CONTINUAR'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ));
            },
            child: const Text(
              'Criar uma conta >',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
