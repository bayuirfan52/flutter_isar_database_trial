import 'package:flutter/material.dart';
import 'package:isardb_trial/repository/repository.dart';
import 'package:isardb_trial/model/object_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;
  var page = 1;
  final data = <Object>[];
  final _repository = Repository();
  final scrollController = ScrollController();

  Future<void> getObject(int page) async {
    data.clear();
    setState(() {
      isLoading = true;
    });
    final response = await _repository.getObject(page: page);
    setState(() {
      data.addAll(response);
      isLoading = false;
    });
  }

  @override
  void initState() {
    getObject(page);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
          page += 1;
          getObject(page);
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
          controller: scrollController,
          child: RefreshIndicator(
            onRefresh: () => getObject(1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemBuilder: (ctx, i) {
                  final item = data[i];
                  return Card(
                    elevation: 0,
                    color: Colors.blue.shade400,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            foregroundImage: NetworkImage('https://pbs.twimg.com/profile_images/1272593825223995397/RwW_1GMN_400x400.jpg'),
                            radius: 36,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.name}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                item.data?.price ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
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
