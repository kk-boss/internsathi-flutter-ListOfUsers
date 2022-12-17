import 'dart:convert';

import 'package:listofitems/screens/home/model/user.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

final usersProvider = StateNotifierProvider<Users, List<User>?>((ref) {
  return Users()..loadUsers();
});

class Users extends StateNotifier<List<User>?> {
  Users() : super(null);
  final allUsers = <User>[];

  void loadUsers() async {
    final res =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    final usersMap = json.decode(res.body) as List<dynamic>;
    final users = usersMap.map((e) => User.fromMap(e));
    allUsers.addAll(users);
    state = [...allUsers];
  }

  void filter(String username) {
    final filteredUsers = allUsers.where((element) => element.username
        .toLowerCase()
        .startsWith(username.trim().toLowerCase()));

    state = [...filteredUsers];
  }
}
