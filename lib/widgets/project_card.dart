import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  Future<void> _handleTap(BuildContext context) async {
    switch (item.name) {
      case 'View Projects':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProjectListScreen()),
        );
      case 'Add Project':
        final loggedIn = await ensureLoggedIn(context);
        if (!loggedIn || !context.mounted) return;
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProjectFormPage()),
        );
      case 'Add Education':
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EducationFormPage()),
        );
      case 'Logout':
        final authState = context.read<AuthState>();
        if (!authState.isLoggedIn) {
          await ensureLoggedIn(context);
          return;
        }
        final messenger = ScaffoldMessenger.of(context);
        await authState.logout();
        messenger.showSnackBar(
          const SnackBar(content: Text('Logged out successfully.')),
        );
      default:
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text("You pressed the ${item.name} button!")),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _handleTap(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
