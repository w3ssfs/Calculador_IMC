import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  String _infoText = "Informe seus Dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus Dados";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculate(){
   setState(() {
     double weight = double.parse(weightController.text);
     double height = double.parse(heightController.text) / 100;
     double imc = weight / (height * height);
     print(imc);
     if(imc < 18.6){
       _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
     }else if(imc >= 18.6 && imc < 24.9){
       _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
     }else if(imc >= 24.9 && imc < 29.9) {
       _infoText = "levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
     }else if(imc >= 29.9 && imc < 34.9) {
       _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
     }else if(imc >= 34.9 && imc < 9.9) {
       _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
     }else if(imc >= 40) {
       _infoText = "obesidade grau III (${imc.toStringAsPrecision(4)})";
     }
   });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: [IconButton(onPressed:_resetFields,
            icon: Icon(Icons.refresh))],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                size: 120.0,
                color: Colors.greenAccent,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.greenAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent, fontSize: 28.0),
                controller: weightController,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.greenAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent, fontSize: 28.0),
                controller: heightController,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.greenAccent, fontSize: 25.0),
              )
            ],
          ),
        ) ,
      ),
    );
  }
}
