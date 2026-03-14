import 'package:flutter/material.dart';
import '../controllers/registration_controller.dart';
import '../models/registration_model.dart';

class FormScreen extends StatefulWidget {
  final Registration? existingData;

  const FormScreen({super.key, this.existingData});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = RegistrationController();
  
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _dateController;
  
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingData?.clientName ?? '');
    _phoneController = TextEditingController(text: widget.existingData?.phoneNumber ?? '');
    _addressController = TextEditingController(text: widget.existingData?.address ?? '');
    _dateController = TextEditingController(text: widget.existingData?.visitDate ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);
      
      final data = Registration(
        id: widget.existingData?.id,
        clientName: _nameController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        visitDate: _dateController.text,
      );

      try {
        if (widget.existingData == null) {
          await _controller.addRegistration(data);
        } else {
          await _controller.updateRegistration(data);
        }
        if (mounted) Navigator.pop(context, true);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")),
          );
        }
      } finally {
        if (mounted) setState(() => _isSaving = false);
      }
    }
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFFB71C1C)),
      filled: true,
      fillColor: Theme.of(context).brightness == Brightness.dark 
          ? Colors.grey.shade900 
          : Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFB71C1C), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingData == null ? "Registrasi Baru" : "Edit Jadwal",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: _buildInputDecoration("Nama Klien / Instansi", Icons.business_center_rounded),
                validator: (val) => val!.isEmpty ? "Nama tidak boleh kosong" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _buildInputDecoration("Nomor WhatsApp", Icons.phone_android_rounded),
                validator: (val) => val!.isEmpty ? "Nomor wajib diisi" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFFB71C1C),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    });
                  }
                },
                decoration: _buildInputDecoration("Pilih Tanggal Kunjungan", Icons.calendar_today_rounded),
                validator: (val) => val!.isEmpty ? "Tanggal wajib dipilih" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                maxLines: 4,
                decoration: _buildInputDecoration("Alamat Lengkap Lokasi", Icons.map_rounded),
                validator: (val) => val!.isEmpty ? "Alamat wajib diisi" : null,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isSaving ? null : _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: _isSaving
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : const Text(
                        "SIMPAN DATA",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}