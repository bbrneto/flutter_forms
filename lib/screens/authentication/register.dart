import 'package:brasil_fields/brasil_fields.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_forms/models/cliente.dart';
import 'package:flutter_forms/screens/dashboard/dashboard.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formUserData = GlobalKey<FormState>();

  final TextEditingController _nomeControler = TextEditingController();

  final TextEditingController _emailControler = TextEditingController();

  final TextEditingController _cpfControler = TextEditingController();

  final TextEditingController _celularControler = TextEditingController();

  final TextEditingController _nascimentoControler = TextEditingController();

  final _formUserAddress = GlobalKey<FormState>();

  final TextEditingController _cepControler = TextEditingController();

  final TextEditingController _estadoControler = TextEditingController();

  final TextEditingController _cidadeControler = TextEditingController();

  final TextEditingController _bairroControler = TextEditingController();

  final TextEditingController _logradouroControler = TextEditingController();

  final TextEditingController _numeroControler = TextEditingController();

  final _formUserAuth = GlobalKey<FormState>();

  final TextEditingController _senhaControler = TextEditingController();

  final TextEditingController _confirmarSenhaControler = TextEditingController();

  int _stepAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de cliente'),
      ),
      body: Consumer<Cliente>(builder: (context, cliente, child) {
        return Stepper(
          currentStep: _stepAtual,
          onStepContinue: () {
            final functions = [
              _salvarStep1,
              _salvarStep2,
              _salvarStep3,
            ];

            functions[_stepAtual](context);
          },
          onStepCancel: () {
            _stepAnterior();
          },
          steps: _construirSteps(context, cliente),
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Continuar'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 15),
                  ),
                  ElevatedButton(
                    onPressed: details.onStepCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  _salvarStep1(context) {
    if (_formUserData.currentState!.validate()) {
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.nome = _nomeControler.text;

      _proximoStep();
    }
  }

  _salvarStep2(context) {
    if (_formUserAddress.currentState!.validate()) {
      _proximoStep();
    }
  }

  _salvarStep3(context) {
    if (_formUserAuth.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      _salvar(context);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
          (route) => false);
    }
  }

  _proximoStep() {
    setState(() {
      _stepAtual = _stepAtual + 1;
    });
  }

  _stepAnterior() {
    setState(() {
      _stepAtual = _stepAtual > 0 ? _stepAtual - 1 : 0;
    });
  }

  void _salvar(context) {
    // Atenção: Foi incluído o parâmetro listen: false
    Provider.of<Cliente>(context, listen: false).nome = _nomeControler.text;
  }

  List<Step> _construirSteps(context, cliente) {
    List<Step> steps = [
      Step(
        title: const Text('Seus dados'),
        isActive: _stepAtual >= 0,
        content: Form(
          key: _formUserData,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                controller: _nomeControler,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) {
                    return 'Nome inválido!';
                  }

                  if (!value.contains(" ")) {
                    return 'Informe pelo menos um sobrenome';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                controller: _emailControler,
                maxLength: 255,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validator.email(value) ? 'Email inválido' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CPF',
                ),
                controller: _cpfControler,
                maxLength: 14,
                keyboardType: TextInputType.number,
                validator: (value) => Validator.cpf(value) ? 'CPF inválido' : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Celular',
                ),
                controller: _celularControler,
                maxLength: 14,
                keyboardType: TextInputType.number,
                validator: (value) => Validator.phone(value) ? 'Celular inválido' : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
              ),
              DateTimePicker(
                controller: _nascimentoControler,
                type: DateTimePickerType.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Nascimento',
                dateMask: 'dd/MM/yyyy',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Data inválida!';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Endereço'),
        isActive: _stepAtual >= 1,
        content: Form(
          key: _formUserAddress,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CEP',
                ),
                controller: _cepControler,
                maxLength: 10,
                keyboardType: TextInputType.number,
                validator: (value) => Validator.cep(value) ? 'CEP inválido' : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(ponto: false),
                ],
              ),
              DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                ),
                items: Estados.listaEstadosSigla.map((String estado) {
                  return DropdownMenuItem(
                    value: estado,
                    child: Text(estado),
                  );
                }).toList(),
                onChanged: (novoEstadoSelecionado) {
                  _estadoControler.text = novoEstadoSelecionado!;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um estado!';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                ),
                controller: _cidadeControler,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) {
                    return 'Cidade inválida!';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Bairro',
                ),
                controller: _bairroControler,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) {
                    return 'Bairro inválido!';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Logradouro',
                ),
                controller: _logradouroControler,
                maxLength: 255,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 3) {
                    return 'Logradouro inválido!';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Número',
                ),
                controller: _numeroControler,
                maxLength: 5,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Autenticação'),
        isActive: _stepAtual >= 2,
        content: Form(
          key: _formUserAuth,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                controller: _senhaControler,
                maxLength: 64,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 8) {
                    return 'Senha curta!';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmar',
                ),
                controller: _confirmarSenhaControler,
                maxLength: 64,
                obscureText: true,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value != _senhaControler.text) {
                    return 'Este campo está diferente da senha informada!';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    ];

    return steps;
  }
}
