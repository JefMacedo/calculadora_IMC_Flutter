import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 25 && imc < 29.9) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 30 && imc < 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 35 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade mórbida (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.purple,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.person_outline,
                          size: 155, color: Colors.purple),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Peso (KG)",
                              labelStyle: TextStyle(color: Colors.purple)),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.purple, fontSize: 23),
                          controller: weightController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira seu peso";
                            }
                          }),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (cm)",
                            labelStyle: TextStyle(color: Colors.purple)),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.purple, fontSize: 23),
                        controller: heightController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira sua altura";
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Container(
                          height: 55,
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _calculate();
                              }
                            },
                            child: Text("Calcular",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Text(
                        _infoText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.purple, fontSize: 25),
                      )
                    ]))));
  }
}
