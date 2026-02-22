# 🏃‍♂️ Claude Marathon

> **Seguimiento de progreso impulsado por IA para tareas épicas de múltiples sesiones en Claude Code.**
> Nunca pierdas el contexto. Auto-resúmenes con Claude Haiku. Continúa sin problemas entre sesiones.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-purple)](https://code.claude.com)
[![Haiku Powered](https://img.shields.io/badge/AI-Claude_Haiku-orange)](https://anthropic.com)

**Languages**: [English](../README.md) | [中文](./README_ZH.md) | [日本語](./README_JA.md) | [한국어](./README_KO.md) | [Русский](./README_RU.md) | [Español](./README_ES.md)

---

## ⚡ Inicio Rápido

```bash
# Instalación
cd ~/.claude/plugins
git clone https://github.com/Equality-Machine/claude-marathon.git marathon

# Habilitar en ~/.claude/settings.json
{
  "enabledPlugins": {
    "marathon": true
  }
}

# Reiniciar Claude Code - ¡Listo! 🎉
```

---

## 🎯 ¿Qué es Marathon?

Marathon resuelve un problema: **Las tareas largas pierden contexto al finalizar la sesión.**

### El Problema
Al trabajar en tareas complejas que abarcan múltiples sesiones de Claude Code, pierdes contexto valioso:
- ¿Qué hice en la sesión anterior?
- ¿Qué planeaba implementar a continuación?
- ¿Qué decisiones técnicas tomé y por qué?

### La Solución
Marathon **rastrea y resume inteligentemente** cada operación usando Claude Haiku:

**Sin Marathon**:
```
Sesión 1: Edité 20 archivos para la función de autenticación ✅
[Ocurre compresión de contexto]
Sesión 2: "¿Qué implementé ayer?" ❓
          Revisar manualmente los 20 archivos... 😓
```

**Con Marathon**:
```
Sesión 1: Edité 20 archivos ✅
          → Se activa checkpoint automático
          → Claude Haiku resume: "🎯 Sistema de autenticación JWT implementado"
[Ocurre compresión de contexto]
Sesión 2: /marathon-review
          → "Sesión anterior: Autenticación JWT 75% completa. Siguiente: Añadir tokens de actualización" ✅
          ¡Retoma al instante! 🚀
```

---

## 🎮 Flujo de Trabajo Completo

Marathon proporciona gestión completa del ciclo de vida de tareas:

```
Inicio de Sesión
  ↓
📖 /marathon-review        ← Restaurar contexto de sesiones previas
  ↓
⚙️ /marathon-config        ← (Opcional) Configurar umbral de checkpoint automático
  ↓
💻 Trabajar en la tarea...
  ├─ 🤖 Checkpoint Automático ← Fondo: Resumen IA cada 20 operaciones
  ├─ 💾 /marathon-checkpoint  ← Manual: Guardar progreso detallado en momentos clave
  └─ 🏁 /marathon-milestone   ← Manual: Marcar logros importantes
  ↓
✅ /marathon-end           ← Completar y archivar al terminar
```

### 🤖 Checkpoint Automático (Automático)

**Se ejecuta en segundo plano automáticamente - ¡sin comandos!**

- **Función**: Resumen por lotes IA de operaciones recientes usando Claude Haiku
- **Cuándo**: Cada N llamadas a herramientas (predeterminado: 20, configurable)
- **Costo**: < $0.10/mes
- **Ejemplo**:
  ```markdown
  ## 📊 Resumen Automático (11:03)
  - [11:02] 📝 Edición: test_manual.txt
  - [11:03] 🔧 Refactorización: módulo de auth (login.js, token.js)
  ```

---

## 📋 Todos los Comandos

### Ciclo de Vida de la Sesión

| Comando | Propósito | Cuándo Usar | Tipo |
|:--------|:----------|:-----------|:-----|
| **`/marathon-review`** | Restaurar contexto de sesiones previas | **Inicio de sesión** - Cargar trabajo pasado | Manual |
| **`/marathon-config`** | Configurar umbral de checkpoint automático | Cualquier momento - Ajustar frecuencia (10-50 llamadas) | Manual |
| **Checkpoint Automático** | Resumen IA por lotes vía Claude Haiku | **Durante el trabajo** - Cada N operaciones | Automático |
| **`/marathon-checkpoint`** | Guardar reporte de progreso detallado | **Durante el trabajo** - Después de hitos clave | Manual |
| **`/marathon-milestone`** | Marcar logro importante | **Durante el trabajo** - Celebrar victorias importantes | Manual |
| **`/marathon-end`** | Completar y archivar tarea | **Fin de sesión** - Resumen final y archivo | Manual |

### Distinciones Clave

**Automático vs Manual**:
- **Checkpoint Automático**: Resumen IA en segundo plano, se ejecuta automáticamente cada N operaciones
- **Checkpoint Manual** (`/marathon-checkpoint`): Guardado de progreso detallado con tu análisis
- **Hito** (`/marathon-milestone`): Marcador conmemorativo de logros importantes

---

## 🏗️ Cómo Funciona

```
Día 1: Iniciar tarea
├─ Marathon crea workspace/session_20260222_*/
├─ Rastrea automáticamente cada edición de archivo, comando git
└─ Después de 20 operaciones → Resumen IA ✅

Día 3: Continuar trabajo
├─ /marathon-review → Carga todas las sesiones previas
├─ Muestra: ¿Qué está hecho? ¿Qué sigue?
└─ Continuar con contexto completo ✅
```

**Estructura del Workspace**:
```
workspace/session_YYYYMMDD_HHMMSS/
├── progress.md          # Rastreo automático + manual
├── learnings.md         # Conocimientos técnicos
├── session.json         # Metadatos
└── logs/                # Logs de checkpoint automático
```

---

## 💡 Ejemplo de Flujo de Trabajo

```bash
# Trabajando en función de autenticación JWT...

# (Después de 20 ediciones, se activa checkpoint automático)
## 📊 Resumen Automático
- [14:10] 🎯 Implementado login JWT + generación de tokens
- [14:25] 🧪 Añadidos tests de integración

# Después de hito importante
/marathon-checkpoint
✅ Checkpoint: Endpoint de login completado

# Al completar MVP
/marathon-milestone
🏁 Hito: ¡MVP de Autenticación JWT Completado!

# Siguiente sesión
/marathon-review
🔍 Cargadas 3 sesiones, 75% completo
🎯 Siguiente: Añadir mecanismo de actualización de tokens
```

---

## ⚙️ Configuración

Ajustar frecuencia de checkpoint automático:

```bash
/marathon-config
```

**Umbrales Recomendados**:
- `10-15` → Trabajo rápido
- `20-30` → Equilibrado (predeterminado)
- `30-50` → Trabajo de concentración profunda

---

## 📊 ¿Por qué Marathon?

✅ **Rastreo automático** - Configura y olvídate
✅ **Impulsado por IA** - Claude Haiku resume inteligentemente
✅ **Económico** - <$0.10/mes
✅ **Sin interrupciones** - Ejecución en segundo plano
✅ **Multi-proyecto** - Filtrado de sesiones consciente del directorio
✅ **Continuidad sin fisuras** - Retoma exactamente donde lo dejaste

---

## 🎯 Perfecto Para

- Implementaciones de funciones multi-día
- Investigaciones de bugs que abarcan sesiones
- Proyectos de investigación y aprendizaje
- Traspasos de equipo y compartir contexto
- Cualquier tarea que dure más de una sesión

---

## 📖 Documentación

- **Guía Completa**: [INSTALL.md](../INSTALL.md)
- **English Docs**: [README.md](../README.md)
- **Issues**: [GitHub Issues](https://github.com/Equality-Machine/claude-marathon/issues)

---

## 🤝 Contribuir

¡PRs bienvenidos! Ver [CONTRIBUTING.md](../CONTRIBUTING.md)

---

## 📄 Licencia

MIT License - ver [LICENSE](../LICENSE)

---

## 🙏 Inspiración

- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

---

**¡Corre tu maratón con confianza!** 🏃‍♂️💨
