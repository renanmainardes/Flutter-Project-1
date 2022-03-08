import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController peso = new TextEditingController();
  TextEditingController altura = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String info = "Digite seus dados";

  void reset() {
    peso.text = "";
    altura.text = "";
    setState(() {
      info = "Digite seus dados";
    });
  }

  void resultado() {
    setState(() {
      double pesoFinal = double.parse(peso.text);
      double alturaFinal = double.parse(altura.text) / 100;
      double imc = pesoFinal / (alturaFinal * alturaFinal);

      if (imc < 18.6) {
        info = "Abaixo do peso. imc: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        info = "Peso ideal. imc: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        info = "Levemente acima do peso. imc: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        info = "Obesidade grau 1. imc: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        info = "Obesidade grau 2. imc: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40.0) {
        info = "Obesidade grau 3. imc: ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de imc"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [IconButton(icon: Icon(Icons.refresh), onPressed: reset)],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.person_outline, color: Colors.green, size: 120),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: peso,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: altura,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                          color: Colors.green,
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              resultado;
                            }
                          },
                          child: Text("Calcular",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ),
                  ),
                  Text(
                    info,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
