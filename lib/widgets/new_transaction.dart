import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControler = TextEditingController();
  final amountControler = TextEditingController();
  DateTime _pickedDate;

  void submitTrans(){
    final newTiltle = titleControler.text;
    final newAmount = double.parse(amountControler.text) ;

    if (newTiltle.isEmpty || newAmount <= 0 || _pickedDate == null){
      return;
    }
    widget._addNewTransaction(newTiltle, newAmount , _pickedDate);
    Navigator.of(context).pop();
  }

  void _dateView(){
    showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2019), 
    lastDate: DateTime.now()).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
              _pickedDate = pickedDate;        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
           elevation: 5,
           child: Container(
             height: 250,
             margin: EdgeInsets.all(10),
             padding: EdgeInsets.all(10),
             child: Column(
               children: [
                 TextField( 
                   decoration: InputDecoration(labelText: 'Title'),
                   controller: titleControler,
                   onSubmitted: (_) => submitTrans(),
                    ),
                 TextField(
                   decoration: InputDecoration(labelText: 'Amount'),
                   controller: amountControler,
                   onSubmitted: (_) => submitTrans(),
                   keyboardType: TextInputType.numberWithOptions(decimal:true,),),
                 Container(
                   height: 50,
                   child: Row(
                     children: [
                       Expanded(child: Text(_pickedDate == null ? 'No Date Chosen !' : DateFormat.yMd().format(_pickedDate))),
                       FlatButton(onPressed: _dateView, 
                       child: Text('Choose Date', style: TextStyle(color: Colors.purple , fontWeight:FontWeight.bold,),),)
                     ],
                   ),
                 ),
                 Container(
                   color: Colors.purple,
                   child: TextButton(
                    onPressed: submitTrans,
                    child: Text("Add Transaction" , style: TextStyle(color: Colors.white),) ,),
                 ),
               ],
             ),
           ),
         ),
    );
  }
}