import 'package:flutter/material.dart';

void main() => runApp(const PracticaDosApp());

class PracticaDosApp extends StatelessWidget {
  const PracticaDosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practica 02',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const InicioPage(),
    );
  }
}

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Practica 02: Dart y estado'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.local_gas_station), text: 'Combustible'),
              Tab(icon: Icon(Icons.attach_money), text: 'Propina'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [CalculadoraCombustiblePage(), PropinaPage()],
        ),
      ),
    );
  }
}

class CalculadoraCombustiblePage extends StatefulWidget {
  const CalculadoraCombustiblePage({super.key});

  @override
  State<CalculadoraCombustiblePage> createState() =>
      _CalculadoraCombustiblePageState();
}

class _CalculadoraCombustiblePageState
    extends State<CalculadoraCombustiblePage> {
  final _kilometrosController = TextEditingController();
  final _litrosController = TextEditingController();
  String? _error;
  double? _rendimiento;

  double? _numeroValido(String texto) {
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  void _calcular() {
    final kilometros = _numeroValido(_kilometrosController.text);
    final litros = _numeroValido(_litrosController.text);

    setState(() {
      if (kilometros == null ||
          litros == null ||
          kilometros <= 0 ||
          litros <= 0) {
        _error = 'Ingresa kilometros y litros validos mayores que cero.';
        _rendimiento = null;
        return;
      }
      _error = null;
      _rendimiento = kilometros / litros;
    });
  }

  void _limpiar() {
    _kilometrosController.clear();
    _litrosController.clear();
    setState(() {
      _error = null;
      _rendimiento = null;
    });
  }

  String _clasificacion(double valor) {
    // Niveles definidos para esta practica: >= 15 excelente, >= 10 bueno.
    if (valor >= 15) return 'Excelente';
    if (valor >= 10) return 'Bueno';
    return 'Bajo';
  }

  Color _colorClasificacion(double valor) {
    if (valor >= 15) return Colors.green;
    if (valor >= 10) return Colors.orange;
    return Colors.red;
  }

  @override
  void dispose() {
    _kilometrosController.dispose();
    _litrosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rendimiento = _rendimiento;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Calculadora de consumo de combustible',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'Ingresa el recorrido y el combustible utilizado para conocer el rendimiento.',
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _kilometrosController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Kilometros recorridos',
            suffixText: 'km',
            prefixIcon: Icon(Icons.route),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _litrosController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Litros utilizados',
            suffixText: 'L',
            prefixIcon: Icon(Icons.water_drop_outlined),
            border: OutlineInputBorder(),
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(
            _error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _calcular,
                icon: const Icon(Icons.calculate),
                label: const Text('Calcular'),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: _limpiar,
              icon: const Icon(Icons.cleaning_services_outlined),
              label: const Text('Limpiar'),
            ),
          ],
        ),
        if (rendimiento != null) ...[
          const SizedBox(height: 24),
          Card(
            color: _colorClasificacion(rendimiento).withValues(alpha: 0.12),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rendimiento obtenido'),
                  const SizedBox(height: 6),
                  Text(
                    '${rendimiento.toStringAsFixed(2)} km/L',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nivel: ${_clasificacion(rendimiento)}',
                    style: TextStyle(
                      color: _colorClasificacion(rendimiento),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class PropinaPage extends StatefulWidget {
  const PropinaPage({super.key});

  @override
  State<PropinaPage> createState() => _PropinaPageState();
}

class _PropinaPageState extends State<PropinaPage> {
  final _consumoController = TextEditingController();
  double _porcentaje = 10;
  double _propina = 0;
  double _total = 0;

  void _calcular() {
    final consumo =
        double.tryParse(_consumoController.text.trim().replaceAll(',', '.')) ??
            0;
    setState(() {
      _propina = consumo * _porcentaje / 100;
      _total = consumo + _propina;
    });
  }

  @override
  void dispose() {
    _consumoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Calculadora de propina',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _consumoController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Consumo',
            prefixIcon: Icon(Icons.attach_money),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Text('Propina: ${_porcentaje.toInt()} %'),
        Slider(
          value: _porcentaje,
          min: 0,
          max: 30,
          divisions: 6,
          label: '${_porcentaje.toInt()}%',
          onChanged: (valor) => setState(() => _porcentaje = valor),
        ),
        FilledButton(onPressed: _calcular, child: const Text('Calcular')),
        const SizedBox(height: 20),
        Text('Propina: \$${_propina.toStringAsFixed(2)}'),
        Text(
          'Total: \$${_total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
