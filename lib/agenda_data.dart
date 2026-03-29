class Agenda {
  final String id;
  final String title;
  final String category;
  final String imagePath;
  final String year;

  Agenda({
    required this.id,
    required this.title,
    required this.category,
    required this.imagePath,
    required this.year,
  });
}

final List<Agenda> allAgendas = [
  // Tahun 2023
  Agenda(
    id: "1",
    category: 'Ludruk',
    title: '“Sucining Katresnan”',
    imagePath: 'assets/images/agenda_sucining.png',
    year: '2023',
  ),
  Agenda(
    id: "2",
    category: 'Ludruk',
    title: '“Kepaten Obor”',
    imagePath: 'assets/images/agenda_kepaten.png',
    year: '2023',
  ),
  // Tahun 2024
  Agenda(
    id: "3",
    category: 'Ludruk',
    title: '“Nada Klinting”',
    imagePath: 'assets/images/agenda_nada.png',
    year: '2024',
  ),
  Agenda(
    id: "4",
    category: 'Ludruk',
    title: '“Sarap Tambak Oso”',
    imagePath: 'assets/images/agenda_sarap.png',
    year: '2024',
  ),
  // Tahun 2022
  Agenda(
    id: "5",
    category: 'Ludruk',
    title: '“Nglaras Ikhlas Noto Lelaku”',
    imagePath: 'assets/images/agenda_nglaras.png',
    year: '2022',
  ),
  Agenda(
    id: "6",
    category: 'Ludruk',
    title: '“Lemah Abang”',
    imagePath: 'assets/images/agenda_lemah.png',
    year: '2022',
  ),
];
