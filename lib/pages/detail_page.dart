// ignore_for_file: use_key_in_widget_constructors

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:isardb_trial/repository/repository.dart';
import 'package:isardb_trial/model/object_model.dart';

@RoutePage()
class DetailPage extends StatefulWidget {
  const DetailPage({required this.id});

  final String id;

  @override
  State<DetailPage> createState() => _State();
}

class _State extends State<DetailPage> {
  var isLoading = false;
  var data = Object();
  final _repository = Repository();

  Future<void> getObject(String id) async {
    setState(() {
      isLoading = true;
    });
    final response = await _repository.getObjectById(id);
    setState(() {
      data = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getObject(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Visibility(
        visible: isLoading == false,
        replacement: const Center(child: CircularProgressIndicator(),),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Generation : ${data.data?.generation}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Color : ${data.data?.color}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Price : ${data.data?.dataPrice}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
