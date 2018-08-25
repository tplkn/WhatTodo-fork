import 'package:flutter/material.dart';
import 'package:flutter_app/models/Project.dart';
import 'package:flutter_app/pages/home/side_drawer.dart';
import 'package:flutter_app/pages/projects/add_project.dart';

class ProjectsList extends StatefulWidget {
  @override
  _ProjectsListState createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {

  List<Project> _projects;


  @override
  void initState() {
    super.initState();
    setState(() {
      _projects = List();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Test"),),
      body: Column(
        children: <Widget>[
          Text("Projects"),
          Expanded(
              flex: 1,
              child: ListView(
                key: Key('projects'),
                children: _buildProjects(),
              )
          ),
          RaisedButton(
            key: Key('add-project'),
            child: Text("Add project"),
            onPressed: () async {
              Project project = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddProject()));
              if(project != null) {
                setState(() {
                  _projects.add(project);
                });
              }
            },
          )
        ],
      ),
    );
  }

  List<Widget> _buildProjects() {
    List<Widget> projectWidgetList = new List();
    _projects.forEach((project) => projectWidgetList.add(new ProjectRow(
      project,
      projectSelection: (selectedProject) {
        Navigator.pop(context);
      },
    )));
    return projectWidgetList;
  }
}
