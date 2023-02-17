import 'package:flutter/material.dart';
import 'package:flutter_forms/models/cliente.dart';
import 'package:flutter_forms/screens/authentication/login.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<Cliente>(builder: (context, cliente, child) {
              if (cliente.nome.isNotEmpty) {
                return Text(
                  'Olá, ${cliente.nome.split(" ")[0]}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              return const Text(
                'Olá!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
              },
              child: const Text('Sair'),
            )
          ],
        ),
      ),
      backgroundColor: Colors.pinkAccent,
    );
  }
}
