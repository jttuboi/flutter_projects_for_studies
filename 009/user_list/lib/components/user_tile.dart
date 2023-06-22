import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list/models/user.dart';
import 'package:user_list/provider/users.dart';
import 'package:user_list/routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Delete user"),
                    content: Text("Are you sure?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("NO"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("YES"),
                      ),
                    ],
                  ),
                ).then((confirmed) async {
                  if (confirmed) {
                    await Provider.of<Users>(context, listen: false)
                        .remove(user);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
