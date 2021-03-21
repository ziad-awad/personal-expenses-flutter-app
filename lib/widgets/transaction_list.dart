import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions , this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: [
          Text('No Transactions Added Yet !!' , style: TextStyle(fontSize: 17 , fontFamily: 'OpenSans'),),

          SizedBox(height: 30,),

          Container(
            height: 200,
            child: Image.asset("assets/images/waiting.png" , fit: BoxFit.cover,),
          ),
        ],
      )
      : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                radius:30,
                child:Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(child: Text('\$${transactions[index].amount}'
                  , style: TextStyle(color:Colors.white),))),
              ),
              title: Text(transactions[index].title
              , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QuickSans',),),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date)
                ),
              trailing: IconButton(icon: Icon(Icons.delete), 
                     onPressed: () => _deleteTransaction(transactions[index].id) ,color: Colors.red ,),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
