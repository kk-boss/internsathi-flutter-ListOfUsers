import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listofitems/screens/home/providers/users.dart';
import 'package:listofitems/typography/colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: TextField(
            autofocus: true,
            cursorColor: kWhiteColor,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: kWhiteColor,
            ),
            decoration: const InputDecoration(
              hintText: "Search by Username",
              isCollapsed: true,
              contentPadding: EdgeInsets.all(10.0),
            ),
            onChanged: (s) {
              ref.read(usersProvider.notifier).filter(s);
            },
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
      body: Consumer(
        builder: (_, cRef, __) {
          final users = cRef.watch(usersProvider);
          if (users == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (users.isEmpty) {
            return const Center(
              child: Text("No such user"),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (_, i) {
              final user = users[i];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Text(user.id.toString()),
                  title: Text(
                    user.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  subtitle: Text('${user.username}\n${user.email}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(user.name),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Center(
                                        child: Text(
                                      user.company.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                    )),
                                    subtitle: Center(
                                        child: Text(user.company.catchPhrase)),
                                  ),
                                  Wrap(
                                    children: [
                                      ...user.company.bs
                                          .split(" ")
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Chip(
                                                  label: Text(e),
                                                  backgroundColor:
                                                      kPrimaryLight,
                                                ),
                                              ))
                                    ],
                                  )
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Done'),
                                )
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.info,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              );
            },
            itemCount: users.length,
          );
        },
      ),
    );
  }
}
