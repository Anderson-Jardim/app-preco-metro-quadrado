import 'package:flutter/material.dart';
import '../adsense/adsense.dart';
import '../style/buttons.dart';
import '../style/calculation_result.dart';
import '../style/drawer.dart';
import '../style/textfield.dart';

class Home extends StatefulWidget {
  Home({key});

  @override
  State<Home> createState() => _InputTextState();
}

class _InputTextState extends State<Home> {
  String meuPreco = "R\$ 0,00";
  String meuLucro = "R\$ 0,00";
  TextEditingController precoCusto = TextEditingController();
  TextEditingController lucroDesejado = TextEditingController();
  TextEditingController custosFixos = TextEditingController();
  TextEditingController custosVariaveis = TextEditingController();

  void _calcular() {
    num pCusto = num.parse(precoCusto.text);
    num lDesejado = num.parse(lucroDesejado.text);
    num cFixos = num.parse(custosFixos.text);
    num cVariaveis = num.parse(custosVariaveis.text);

// Calculo PMZ

    num pmz = cFixos + cVariaveis;
    num pmz2 = 100 - pmz;
    num pmz3 = pmz2 / 100;
    num pmz4 = pCusto / pmz3;
    num precoFinal1 = 100 - lDesejado;
    num precoFinal2 = precoFinal1 / 100;
    num precoFinal3 = pmz4 / precoFinal2;
    String precoVenda = precoFinal3.toStringAsFixed(2);

    setState(() {
      meuPreco = "R\$ $precoVenda";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ShowDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InputTextfield(
                  texto: "Preço Custo em M²",
                  c: precoCusto,
                  textoFixo: "M²",
                ),
                InputTextfield(
                  texto: "Impostos %",
                  c: custosFixos,
                  textoFixo: "%",
                ),
                InputTextfield(
                  texto: "Custos Variáveis %",
                  c: custosVariaveis,
                  textoFixo: "%",
                ),
                InputTextfield(
                  texto: "Lucro Desejado %",
                  c: lucroDesejado,
                  textoFixo: "%",
                ),
                const SizedBox(
                  height: 20,
                ),
                CalculationResult(
                  texto: "Meu Preço:",
                  numero: meuPreco,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Buttons(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (_) => false,
                        ),
                        iconn: const Icon(Icons.close),
                        colorButtom: const Color(0xFFF44336),
                      ),
                      Buttons(
                        onTap: _calcular,
                        iconn: const Icon(Icons.check),
                        colorButtom: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AdSense(adScreen: AdSense.homeScreen),
          ),
        ],
      ),
    );
  }
}
