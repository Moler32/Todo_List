import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../widgets/groups_model.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final model = GroupWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupWidgetModelProvider(model: model, child: const _GroupsWidgetBody());
  }
}

class _GroupsWidgetBody extends StatelessWidget {
  const _GroupsWidgetBody({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Группы'),
      ),
      body: const _GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupWidgetModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}


class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   final groupsCount = GroupWidgetModelProvider.watch(context)?.model.groups.length ?? 0;

    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
           return _GroupListRowWidget(indexInList: index);
          
          
        },
        separatorBuilder: (BuildContext context, int index) {
         return const Divider(
            height: 1,
          );
        },
        itemCount: groupsCount);
  }
}



class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;

  const _GroupListRowWidget({Key? key, required this.indexInList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final model = GroupWidgetModelProvider.read(context)!.model;

    final group = model.groups[indexInList];

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) =>  model.deleteGroup(context, indexInList)),
            backgroundColor: const Color.fromARGB(255, 188, 3, 3),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: ListTile(
        title: Text(group.name),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => model.showTasks(context, indexInList),
      ),
    );
  }

  
}
