import 'package:flutter/material.dart';

// --- KONSTANTA WARNA ---
const Color kPrimaryColor = Color(0xFF5E0821);
const Color kPrimaryColor70 = Color(0xB35E0821); // Transparansi 70%
const Color kCardColor = Color(0xFFFFFFFF);
const Color kBlackColor = Color(0xFF000000);

// --- MODEL DATA AGENDA ---
class Agenda {
  final String category;
  final String title;
  final String imagePath;
  final String year;

  Agenda({
    required this.category,
    required this.title,
    required this.imagePath,
    required this.year,
  });
}

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedYear = 'Semua Tahun';

  // --- DATA DUMMY SESUAI PERMINTAAN ---
  final List<Agenda> allAgendas = [
    // Tahun 2023
    Agenda(category: 'Ludruk', title: '“Sucining Katresnan”', imagePath: 'assets/images/agenda_sucining.png', year: '2023'),
    Agenda(category: 'Ludruk', title: '“Kepaten Obor”', imagePath: 'assets/images/agenda_kepaten.png', year: '2023'),
    // Tahun 2024
    Agenda(category: 'Ludruk', title: '“Nada Klinting”', imagePath: 'assets/images/agenda_nada.png', year: '2024'),
    Agenda(category: 'Ludruk', title: '“Sarap Tambak Oso”', imagePath: 'assets/images/agenda_sarap.png', year: '2024'),
    // Tahun 2022
    Agenda(category: 'Ludruk', title: '“Nglaras Ikhlas Noto Lelaku”', imagePath: 'assets/images/agenda_nglaras.png', year: '2022'),
    Agenda(category: 'Ludruk', title: '“Lemah Abang”', imagePath: 'assets/images/agenda_lemah.png', year: '2022'),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // --- LOGIKA FILTER & SEARCH ---
  List<Agenda> _getFilteredAgendas() {
    return allAgendas.where((agenda) {
      final matchesYear = _selectedYear == 'Semua Tahun' || agenda.year == _selectedYear;
      final matchesSearch = agenda.title.toLowerCase().contains(_searchQuery) || 
                            agenda.category.toLowerCase().contains(_searchQuery);
      return matchesYear && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCardColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Container(
              color: kCardColor,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  _buildFilterAndSearch(),
                  const SizedBox(height: 25),
                  _buildAgendaGrid(),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            image: const DecorationImage(
              image: AssetImage('assets/images/background_agenda.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(kPrimaryColor70, BlendMode.overlay),
            ),
          ),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Agenda Taman Budaya', 
                      style: TextStyle(color: kCardColor, fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Pagelaran yang telah dilaksanakan ditaman\nbudaya',
                      style: TextStyle(color: kCardColor, fontSize: 16)),
                  ],
                ),
              ),
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: kCardColor, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterAndSearch() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedYear,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                items: ['Semua Tahun', '2024', '2023', '2022'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(color: kPrimaryColor)));
                }).toList(),
                onChanged: (val) => setState(() => _selectedYear = val!),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search, color: kPrimaryColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgendaGrid() {
    final filteredData = _getFilteredAgendas();
    if (filteredData.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Text("Agenda tidak ditemukan", style: TextStyle(color: Colors.grey)),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final item = filteredData[index];
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(item.imagePath, fit: BoxFit.cover, 
                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200], child: const Icon(Icons.image, color: Colors.grey))),
              ),
            ),
            const SizedBox(height: 8),
            Text(item.category, style: const TextStyle(fontSize: 14)),
            Text(item.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        );
      },
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: const [
          Text('UPT Taman Budaya Jatim', style: TextStyle(color: Colors.grey, fontSize: 14)),
          Text('Ver 0.1 Beta', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}