import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "Informe os Valores";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculaCombustivelIdeal() {
    double vEtanol = double.parse(etanolController.text.replaceAll(',', '.'));
    double vGasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));
    double proporcao = vEtanol / vGasolina;
    // Se a proporçao for menor que 0.7, deve-se abasteer com etanil, caso contrario com gasolina
    setState(() {
      _resultado =
          (proporcao <= 0.70) ? "Abasteça com Etanol" : "Abasteça com Gasolina";
    });
  }

  void _reset() {
    gasolinaController.text = "";
    etanolController.text = "";
    setState(() {
      _resultado = "Informe os valores";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Etanol - Gasolina",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink[500],
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _reset();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 20),
            Icon(
              Icons.local_gas_station_rounded,
              size: 130,
              color: Colors.pink[500],
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: etanolController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe corretamente o valor do etanol";
                } else {
                  if (double.tryParse(value) != null) {
                    if (double.parse(value.toString()) <= 0) {
                      return "O Valor deve ser positivo";
                    }
                    return null;
                  }
                }
              },
              textAlign: TextAlign.center,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: 'Valor do Etanol',
                  labelStyle: TextStyle(color: Colors.pink[500])),
              style: TextStyle(color: Colors.pink[500], fontSize: 26),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: gasolinaController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe corretamente o valor do etanol";
                } else {
                  if (double.tryParse(value) != null) {
                    if (double.parse(value.toString()) <= 0) {
                      return "O Valor deve ser positivo";
                    }
                    return null;
                  }
                }
              },
              textAlign: TextAlign.center,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: 'Valor da Gasolina',
                  labelStyle: TextStyle(color: Colors.pink[500])),
              style: TextStyle(color: Colors.pink[500], fontSize: 26),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculaCombustivelIdeal();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pink[500], elevation: 15),
                    child: const Text(
                      "Verificar",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ),
            ),
            Text(_resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pink[500], fontSize: 26.0))
          ]),
        ),
      ),
    );
  }
}
