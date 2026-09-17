# Practica 02 - Fundamentos de Dart, widgets y estado

## Objetivo

Aplicar variables, funciones, conversion de tipos y manejo de estado en Flutter mediante una calculadora de consumo de combustible. Tambien incluye el ejemplo guiado de calculadora de propina.

## Requisitos

- Flutter SDK 3.x
- Dart SDK incluido con Flutter
- Un emulador, dispositivo fisico o navegador compatible

## Instalacion y ejecucion

```bash
flutter pub get
flutter run
```

## Funcionalidad evaluable

La pestana **Combustible** solicita kilometros recorridos y litros utilizados, valida que ambos sean numeros mayores que cero y calcula el rendimiento en km/L.

Niveles definidos:

- Excelente: 15 km/L o mas
- Bueno: de 10 km/L a menos de 15 km/L
- Bajo: menos de 10 km/L

El boton Limpiar restablece los campos, errores y resultado. La pestana **Propina** implementa el ejemplo guiado con `TextEditingController`, `Slider`, `setState` y `dispose`.

## Verificacion

```bash
dart format .
flutter analyze
flutter test
```

Casos manuales sugeridos:

1. 300 km y 20 L muestra 15.00 km/L y nivel Excelente.
2. 120 km y 12 L muestra 10.00 km/L y nivel Bueno.
3. Campos vacios, texto o cero muestran validacion sin cerrar la app.
4. Limpiar elimina resultado y contenido de los campos.

## Participantes

- Agrega aqui los nombres y matriculas del equipo.

## Evidencias y entrega

Guarda las capturas en `docs/evidencias/practica-02/`. Antes de entregar, agrega en la plataforma la URL de la pull request hacia `develop` y la URL del commit final de la rama `practica-02-dart-estado`.
