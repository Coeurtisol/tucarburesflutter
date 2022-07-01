import 'package:flutter/material.dart';
import 'package:tucarburesflutter/model/gas_station.dart';
import 'package:tucarburesflutter/model/statement.dart';
import 'package:tucarburesflutter/util/date_util.dart';

class StatementListItem extends StatefulWidget {
  final GasStation gasStation;
  final Statement statement;
  final Function updateStatementPrice;

  const StatementListItem(
      {Key? key,
      required this.gasStation,
      required this.statement,
      required this.updateStatementPrice})
      : super(key: key);

  @override
  State<StatementListItem> createState() => _StatementListItemState();
}

class _StatementListItemState extends State<StatementListItem> {
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _priceController.text = widget.statement.price.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var gasStation = widget.gasStation;
    var statement = widget.statement;
    var updateStatementPrice = widget.updateStatementPrice;
    return ElevatedButton(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Row(
          children: [
            Text(DateUtil().convertDate(statement.localDate)),
            const SizedBox(width: 5),
            Text(statement.gasoline.name),
            const SizedBox(width: 5),
            Text("(${statement.gasoline.code}) :"),
            const SizedBox(width: 5),
            Text(statement.price.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text(" €"),
          ],
        ),
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Le prix a changé?', textScaleFactor: 1.5),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Text(
                          gasStation.name,
                          textScaleFactor: 1.2,
                        ),
                        Text(gasStation.city),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText:
                                'Prix observé pour le ${statement.gasoline.name}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                      child: const Text("Valider"),
                      onPressed: () => {
                            Navigator.pop(context),
                            updateStatementPrice(gasStation.id, statement,
                                double.parse(_priceController.text))
                          })
                ],
              );
            });
      },
    );
  }
}
