import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir untuk menambahkan riwayat pendidikan (Education) ke portofolio.
class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String _institution = "";
  String _degree = "S1";
  String _fieldOfStudy = "";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;
  String _gpa = "";
  String _institutionUrl = "";
  String _description = "";

  final List<String> _degrees = [
    'SMA / Sederajat',
    'D3',
    'S1',
    'S2',
    'S3',
    'Bootcamp / Kursus',
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  /// Memformat [DateTime] menjadi string `YYYY-MM-DD`.
  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  /// Membuka date picker untuk memilih tanggal mulai atau tanggal selesai.
  Future<void> _selectDate({required bool isStartDate}) async {
    final DateTime initialDate = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2040),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = _formatDate(picked);
        } else {
          _endDate = picked;
          _endDateController.text = _formatDate(picked);
        }
      });
    }
  }

  /// Mereset seluruh state dan field formulir ke kondisi awal.
  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _institution = "";
      _degree = "S1";
      _fieldOfStudy = "";
      _startDate = null;
      _endDate = null;
      _isCurrent = false;
      _gpa = "";
      _institutionUrl = "";
      _description = "";
      _startDateController.clear();
      _endDateController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Education Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Institusi ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Universitas Indonesia",
                    labelText: "Nama Institusi",
                    prefixIcon: const Icon(Icons.account_balance),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _institution = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama institusi tidak boleh kosong!";
                    }
                    if (value.trim().length < 3) {
                      return "Nama institusi minimal 3 karakter!";
                    }
                    if (value.trim().length > 100) {
                      return "Nama institusi maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Jenjang Pendidikan ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Jenjang Pendidikan",
                    prefixIcon: const Icon(Icons.school),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  initialValue: _degree,
                  items: _degrees
                      .map(
                        (degree) => DropdownMenuItem(
                          value: degree,
                          child: Text(degree),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _degree = newValue;
                      });
                    }
                  },
                ),
              ),

              // === Jurusan / Program Studi ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Ilmu Komputer",
                    labelText: "Jurusan / Program Studi",
                    prefixIcon: const Icon(Icons.menu_book),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _fieldOfStudy = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Jurusan / program studi tidak boleh kosong!";
                    }
                    if (value.trim().length > 100) {
                      return "Jurusan / program studi maksimal 100 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tanggal Mulai ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pilih tanggal mulai",
                    labelText: "Tanggal Mulai",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onTap: () => _selectDate(isStartDate: true),
                  validator: (String? value) {
                    if (_startDate == null ||
                        value == null ||
                        value.trim().isEmpty) {
                      return "Tanggal mulai wajib dipilih!";
                    }
                    return null;
                  },
                ),
              ),

              // === Status Masih Menempuh Pendidikan ===
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "Masih menempuh pendidikan di sini (Saat ini)",
                ),
                value: _isCurrent,
                activeColor: primaryColor,
                onChanged: (bool? value) {
                  setState(() {
                    _isCurrent = value ?? false;
                    if (_isCurrent) {
                      _endDate = null;
                      _endDateController.clear();
                    }
                  });
                },
              ),

              // === Tanggal Selesai (jika tidak sedang berlangsung) ===
              if (!_isCurrent)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _endDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Pilih tanggal selesai / lulus",
                      labelText: "Tanggal Selesai",
                      prefixIcon: const Icon(Icons.event_available),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onTap: () => _selectDate(isStartDate: false),
                    validator: (String? value) {
                      if (_endDate == null ||
                          value == null ||
                          value.trim().isEmpty) {
                        return "Tanggal selesai wajib dipilih!";
                      }
                      if (_startDate != null &&
                          _endDate!.isBefore(_startDate!)) {
                        return "Tanggal selesai tidak boleh sebelum tanggal mulai!";
                      }
                      return null;
                    },
                  ),
                ),

              // === IPK / Nilai (Opsional) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: "Contoh: 3.85 (opsional, skala 0.00 - 4.00)",
                    labelText: "IPK / Nilai (Opsional)",
                    prefixIcon: const Icon(Icons.grade),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _gpa = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    final parsed = double.tryParse(value.trim());
                    if (parsed == null) {
                      return "IPK harus berupa angka desimal yang valid!";
                    }
                    if (parsed < 0.0 || parsed > 4.0) {
                      return "IPK harus berada di antara 0.00 hingga 4.00!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tautan Institusi / Sertifikat (Opsional) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "Contoh: https://cs.ui.ac.id (opsional)",
                    labelText: "Tautan Institusi / Sertifikat (Opsional)",
                    prefixIcon: const Icon(Icons.link),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _institutionUrl = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null ||
                        !(uri.isScheme('http') || uri.isScheme('https')) ||
                        uri.host.isEmpty) {
                      return "URL harus diawali http:// atau https:// yang valid!";
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi / Pencapaian (Opsional) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Organisasi, mata kuliah favorit, atau pencapaian (opsional)",
                    labelText: "Deskripsi / Pencapaian (Opsional)",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value != null && value.trim().length > 500) {
                      return "Deskripsi maksimal 500 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(primaryColor),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 14.0),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String endDateText = _isCurrent
                              ? 'Saat ini'
                              : _endDateController.text;
                          final String gpaText = _gpa.trim().isEmpty
                              ? '-'
                              : _gpa.trim();
                          final String urlText = _institutionUrl.trim().isEmpty
                              ? '-'
                              : _institutionUrl.trim();
                          final String descText = _description.trim().isEmpty
                              ? '-'
                              : _description.trim();

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Edukasi berhasil ditambahkan!',
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Institusi: ${_institution.trim()}'),
                                      Text('Jenjang: $_degree'),
                                      Text('Jurusan: ${_fieldOfStudy.trim()}'),
                                      Text(
                                        'Periode: ${_startDateController.text} s/d $endDateText',
                                      ),
                                      Text('IPK / Nilai: $gpaText'),
                                      Text('Tautan: $urlText'),
                                      Text('Deskripsi: $descText'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _resetForm();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
