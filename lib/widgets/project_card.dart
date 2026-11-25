import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menggunakan warna spesifik dari masing-masing item.
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Area responsif terhadap sentuhan
        onTap: () async {
          final messenger = ScaffoldMessenger.of(context);

          if (item.name == 'Logout') {
            final authState = context.read<AuthState>();
            if (!authState.isLoggedIn) {
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Kamu belum login!')),
                );
              return;
            }
            await authState.logout();
            if (!context.mounted) return;
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text('Berhasil logout!')));
            return;
          }

          // Memunculkan SnackBar ketika diklik
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
              ),
            );

          // Navigate ke halaman yang sesuai
          if (item.name == 'Lihat Proyek') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ProjectListScreen(),
              ),
            );
          } else if (item.name == 'Tambah Proyek') {
            final ok = await ensureLoggedIn(context);
            if (!ok || !context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ProjectFormPage(),
              ),
            );
          } else if (item.name == 'Tambah Edukasi') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const EducationFormPage(),
              ),
            );
          }
        },
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
