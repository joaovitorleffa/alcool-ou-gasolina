import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController gasolinaController = TextEditingController();
  TextEditingController alcoolController = TextEditingController();

  String _infoText = "Informe o valor de cada combustível";

  void _resetFields() {
    gasolinaController.text = "";
    alcoolController.text = "";
    setState(() {
      _infoText = "Informe o valor de cada combustível";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calcula() {
    setState(() {
      double gasolina = double.parse(gasolinaController.text);
      double alcool = double.parse(alcoolController.text);
      double resultado = (alcool / gasolina);

      if (resultado > 0.70) {
        _infoText =
            "Percentual : (${resultado.toStringAsPrecision(3)})\n\nVale a pena abastecer com Gasolina";
      } else {
        _infoText =
            "Percentual : (${resultado.toStringAsPrecision(3)})\n\nVale a pena abastecer com Álcool";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alcool ou Gasolina?'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh), onPressed: () => _resetFields())
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.directions_car, size: 60.0, color: Colors.blue[900]),
                buildTextFormFieldGasolina(),
                buildTextFormFieldAlcool(),
                buildContainerButton(context),
                buildTextInfo()
              ],
            ),
          ),
        ));
  }

  Text buildTextInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 20.0),
    );
  }

  TextFormField buildTextFormFieldGasolina() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Preço da Gasolina",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
      controller: gasolinaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Informe o valor da gasolina';
        }
        return null;
      },
    );
  }

  TextFormField buildTextFormFieldAlcool() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Preço do Alcool",
        labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      controller: alcoolController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Informe o valor do álcool';
        }
        return null;
      },
    );
  }

  Container buildContainerButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 60.0,
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calcula();
            FocusScope.of(context).requestFocus(new FocusNode());
          }
        },
        child: Text("Calcular",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        color: Colors.green,
      ),
    );
  }
}
