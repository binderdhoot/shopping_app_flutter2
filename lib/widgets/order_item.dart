import 'dart:math';
import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  //const OrderItem({Key? key}) : super(key: key);
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text('£${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd-MM-yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),
          if (_expanded)
            DataTable(
              columnSpacing: 0,
              columns: const [
                DataColumn(label: Text('Product Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Qty')),
                DataColumn(label: Text('Sub Total')),
              ],
              rows: widget.order.products
                  .map(
                    ((element) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(element.title)),
                            DataCell(Text('£${element.price}')),
                            DataCell(Text('${element.qty}')),
                            DataCell(
                              Text('£${element.qty * element.price}'),
                            )
                          ],
                        )),
                  )
                  .toList(),
            ),
          /* Container(
            padding: const EdgeInsets.all(15),
            height: min(widget.order.products.length * 20 + 100, 180),
            child: ListView(
              children: widget.order.products
                  .map(
                    (prod) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          prod.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${prod.qty} x £${prod.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ), */
        ],
      ),
    );
  }
}
