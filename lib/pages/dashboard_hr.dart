import 'package:flutter/material.dart';

class DashboardHR extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const DashboardHR({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600;
        return _buildDashboard(context, isTablet);
      },
    );
  }

  Widget _buildDashboard(BuildContext context, bool isTablet) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                'https://picsum.photos/seed/logo/40/40',
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.business, size: 32);
                },
              ),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text('PT Maju Bersama', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://picsum.photos/seed/user/50/50',
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BANNER SAPAAN
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? const [Color(0xFF263B60), Color(0xFF344F78)]
                      : [colors.primary, colors.tertiary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    left: 20,
                    top: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Selamat Pagi, Admin!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Senin, 7 Oktober 2024',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    bottom: 20,
                    child: Icon(
                      Icons.waving_hand,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: 64,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // GRID STATISTIK
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isTablet ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isTablet ? 1.4 : 1.3,
              children: [
                _kartuStat('248', 'Karyawan', Icons.people, colors.primary),
                _kartuStat(
                  '95%',
                  'Hadir',
                  Icons.check_circle,
                  colors.secondary,
                ),
                _kartuStat('12', 'Cuti', Icons.beach_access, colors.tertiary),
                _kartuStat('3', 'Rekrut', Icons.person_add, colors.error),
              ],
            ),

            const SizedBox(height: 24),

            // KEHADIRAN PER DIVISI
            Text(
              'Kehadiran per Divisi',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            _kartuKehadiran('Engineering', 92, Colors.blue),
            _kartuKehadiran('Sales', 85, Colors.orange),
            _kartuKehadiran('HR', 97, Colors.green),
            _kartuKehadiran('Finance', 90, Colors.purple),

            const SizedBox(height: 20),

            // AKTIVITAS TERKINI
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aktivitas Terkini',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(onPressed: () {}, child: const Text('Lihat Semua')),
              ],
            ),

            ..._aktivitas.map((data) => _kartuAktivitas(data)),
          ],
        ),
      ),
    );
  }

  // KARTU STATISTIK
  Widget _kartuStat(String nilai, String label, IconData icon, Color warna) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warna.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: warna, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nilai,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: warna,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // GRAFIK KEHADIRAN
  Widget _kartuKehadiran(String divisi, int persen, Color warna) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(divisi, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('$persen%'),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Expanded(
                  flex: persen,
                  child: Container(height: 10, color: warna),
                ),
                Expanded(
                  flex: 100 - persen,
                  child: Container(
                    height: 10,
                    color: warna.withValues(alpha: 0.15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DATA AKTIVITAS
  static const List<Map<String, dynamic>> _aktivitas = [
    {
      'nama': 'Budi Santoso',
      'aksi': 'Mengajukan cuti',
      'waktu': '09:14',
      'icon': Icons.beach_access,
      'warna': Colors.orange,
    },
    {
      'nama': 'Citra Dewi',
      'aksi': 'Check-in absensi',
      'waktu': '08:02',
      'icon': Icons.check_circle,
      'warna': Colors.green,
    },
    {
      'nama': 'Eko Wahyudi',
      'aksi': 'Upload kontrak baru',
      'waktu': '07:45',
      'icon': Icons.description,
      'warna': Colors.blue,
    },
  ];

  // KARTU AKTIVITAS
  Widget _kartuAktivitas(Map<String, dynamic> data) {
    final warna = data['warna'] as Color;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: warna.withValues(alpha: 0.15),
          child: Icon(data['icon'] as IconData, color: warna, size: 20),
        ),
        title: Text(
          data['nama'] as String,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(data['aksi'] as String),
        trailing: Text(
          data['waktu'] as String,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
      ),
    );
  }
}
