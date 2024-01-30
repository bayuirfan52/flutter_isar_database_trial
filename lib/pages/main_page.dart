import 'package:flutter/material.dart';
import 'package:isardb_trial/model/user_model.dart';
import 'package:isardb_trial/repository/repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;
  var page = 1;
  final data = <Data>[];
  final _repository = Repository();
  final scrollController = ScrollController();

  Future<void> getUser(int page) async {
    data.clear();
    setState(() {
      isLoading = true;
    });
    final response = await _repository.getUser(page: page);
    setState(() {
      data.addAll(response);
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUser(page);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
          page += 1;
          getUser(page);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Isar DB Trial',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade500,
      ),
      body: Visibility(
        visible: isLoading,
        replacement: Scrollbar(
          child: RefreshIndicator(
            onRefresh: () => getUser(1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                controller: scrollController,
                itemBuilder: (ctx, i) {
                  final item = data[i];
                  return Card(
                    elevation: 0,
                    color: Colors.blue.shade500,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${item.firstName} ${item.lastName}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemCount: data.length,
              ),
            ),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
