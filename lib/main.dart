import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Name'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.logout),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              leading: Icon(Icons.dashboard),
              onTap: () {},
            ),
            ListTile(
              title: Text('Orders'),
              leading: Icon(Icons.receipt),
              onTap: () {},
            ),
            ListTile(
              title: Text('Products'),
              leading: Icon(Icons.shopping_cart),
              onTap: () {},
            ),
            ListTile(
              title: Text('Customers'),
              leading: Icon(Icons.people),
              onTap: () {},
            ),
            ListTile(
              title: Text('Reports'),
              leading: Icon(Icons.bar_chart),
              onTap: () {},
            ),
            ListTile(
              title: Text('Integrations'),
              leading: Icon(Icons.layers),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CardList(),
              SizedBox(height: 20),
              ProjectsTable(),
              SizedBox(height: 20),
              ChartData(),
            ],
          ),
        ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        DashboardCard(
          color: Colors.blue,
          title: 'All Projects',
          value: '89',
          icon: Icons.upload,
          stat: '13% increase',
        ),
        DashboardCard(
          color: Colors.green,
          title: 'Team Members',
          value: '5,990',
          icon: Icons.upload,
          stat: '4% increase',
        ),
        DashboardCard(
          color: Colors.orange,
          title: 'Total Budget',
          value: '\$80,990',
          icon: Icons.download,
          stat: '13% decrease',
        ),
        DashboardCard(
          color: Colors.red,
          title: 'New Customers',
          value: '3',
          icon: Icons.download,
          stat: '13% decrease',
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final Color color;
  final String title;
  final String value;
  final IconData icon;
  final String stat;

  DashboardCard({
    required this.color,
    required this.title,
    required this.value,
    required this.icon,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Icon(icon, color: Colors.white),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            stat,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ProjectsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Ongoing Projects'),
            trailing: Text('32 Projects'),
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('Project')),
              DataColumn(label: Text('Deadline')),
              DataColumn(label: Text('Leader + Team')),
              DataColumn(label: Text('Budget')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('New Dashboard')),
                DataCell(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('17th Oct, 15'),
                    Text('Overdue', style: TextStyle(color: Colors.red)),
                  ],
                )),
                DataCell(Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://s3-us-west-2.amazonaws.com/s.cdpn.io/584938/people_8.png'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Myrtle Erickson'),
                        Text('UK Design Team'),
                      ],
                    ),
                  ],
                )),
                DataCell(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$4,670'),
                    Text('Paid'),
                  ],
                )),
                DataCell(Text('In progress',
                    style: TextStyle(color: Colors.orange))),
                DataCell(DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                      child: Text('Actions'),
                      value: 'Actions',
                    ),
                    DropdownMenuItem(
                      child: Text('Start project'),
                      value: 'Start project',
                    ),
                    DropdownMenuItem(
                      child: Text('Send for QA'),
                      value: 'Send for QA',
                    ),
                    DropdownMenuItem(
                      child: Text('Send invoice'),
                      value: 'Send invoice',
                    ),
                  ],
                  onChanged: (value) {},
                  hint: Text('Actions'),
                )),
              ]),
              // Repeat DataRow for other projects
            ],
          ),
        ],
      ),
    );
  }
}

class ChartData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        ChartCard(
          title: 'Household Expenditure',
          subtitle: 'Yearly',
          chart: Container(), // Replace with your chart widget
        ),
        ChartCard(
          title: 'Monthly Revenue',
          subtitle: '2015 (in thousands US\$)',
          chart: Container(), // Replace with your chart widget
        ),
        ChartCard(
          title: 'Exports of Goods',
          subtitle: '2015 (in billion US\$)',
          chart: Container(), // Replace with your chart widget
        ),
      ],
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget chart;

  ChartCard({
    required this.title,
    required this.subtitle,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: PopupMenuButton<String>(
              onSelected: (String result) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Action',
                  child: Text('Action'),
                ),
                const PopupMenuItem<String>(
                  value: 'Another action',
                  child: Text('Another action'),
                ),
                const PopupMenuItem<String>(
                  value: 'Something else here',
                  child: Text('Something else here'),
                ),
              ],
            ),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white54),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: chart,
          ),
        ],
      ),
    );
  }
}
