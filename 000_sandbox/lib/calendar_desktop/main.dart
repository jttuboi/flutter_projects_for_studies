import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: CustomCalendarPage()));
}

// --- MODELOS DE DADOS ---

class CalendarCategory {
  final String id;
  final String name;
  final Color color;
  bool isVisible;

  CalendarCategory({required this.id, required this.name, required this.color, this.isVisible = true});
}

class CalendarEvent {
  String id;
  String title;
  DateTime date;
  String calendarId;

  CalendarEvent({required this.id, required this.title, required this.date, required this.calendarId});
}

// --- TELA PRINCIPAL ---

class CustomCalendarPage extends StatefulWidget {
  const CustomCalendarPage({super.key});

  @override
  State<CustomCalendarPage> createState() => _CustomCalendarPageState();
}

class _CustomCalendarPageState extends State<CustomCalendarPage> {
  // Configurações do PageView
  late PageController _pageController;
  DateTime _focusedDate = DateTime.now();
  // Usamos um indice inicial grande para permitir scroll para o passado e futuro
  final int _initialPage = 1000;

  // Dados Mockados
  late List<CalendarCategory> _calendars;
  late List<CalendarEvent> _events;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);

    // Inicializando categorias
    _calendars = [
      CalendarCategory(id: '1', name: 'Pessoal', color: Colors.blueAccent),
      CalendarCategory(id: '2', name: 'Trabalho', color: Colors.redAccent),
      CalendarCategory(id: '3', name: 'Feriados', color: Colors.green),
    ];

    // Inicializando alguns eventos de exemplo
    _events = [
      CalendarEvent(id: 'e1', title: 'Reunião', date: DateTime.now(), calendarId: '2'),
      CalendarEvent(id: 'e2', title: 'Jantar', date: DateTime.now().add(const Duration(days: 2)), calendarId: '1'),
    ];
  }

  // --- LÓGICA DE DATAS ---

  // Calcula a data baseada no índice do PageView
  DateTime _getDateFromIndex(int index) {
    final now = DateTime.now();
    return DateTime(now.year, now.month + (index - _initialPage));
  }

  // Retorna dias no mês
  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  // Retorna offset do primeiro dia da semana (0 = Domingo, etc)
  int _firstDayOffset(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday % 7;
  }

  // --- CRUD LÓGICA ---

  void _addEvent(String title, DateTime date, String calendarId) {
    setState(() {
      _events.add(CalendarEvent(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, date: date, calendarId: calendarId));
    });
  }

  void _editEvent(CalendarEvent event, String newTitle, String newCalendarId) {
    setState(() {
      event.title = newTitle;
      event.calendarId = newCalendarId;
    });
  }

  void _deleteEvent(String id) {
    setState(() {
      _events.removeWhere((e) => e.id == id);
    });
  }

  // --- DIALOGS ---

  void _showEventDialog({CalendarEvent? eventToEdit, DateTime? dateForNew}) {
    final isEditing = eventToEdit != null;
    final titleController = TextEditingController(text: isEditing ? eventToEdit.title : '');
    String selectedCalendarId = isEditing ? eventToEdit.calendarId : _calendars.first.id;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(isEditing ? 'Editar Evento' : 'Novo Evento'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedCalendarId,
                    items: _calendars.map((cal) {
                      return DropdownMenuItem(value: cal.id, child: Text(cal.name));
                    }).toList(),
                    onChanged: (val) {
                      setStateDialog(() => selectedCalendarId = val!);
                    },
                    decoration: const InputDecoration(labelText: 'Calendário'),
                  ),
                ],
              ),
              actions: [
                if (isEditing)
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () {
                      _deleteEvent(eventToEdit.id);
                      Navigator.pop(context);
                    },
                    child: const Text('Deletar'),
                  ),
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty) return;

                    if (isEditing) {
                      _editEvent(eventToEdit, titleController.text, selectedCalendarId);
                    } else {
                      _addEvent(titleController.text, dateForNew!, selectedCalendarId);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // --- WIDGET BUILDERS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ÁREA DO CALENDÁRIO (Esquerda)
          Expanded(
            flex: 4,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _focusedDate = _getDateFromIndex(index);
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildMonthView(_getDateFromIndex(index));
                    },
                  ),
                ),
              ],
            ),
          ),

          // DIVISOR
          const VerticalDivider(width: 1),

          // SIDEBAR (Direita)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Meus Calendários", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _calendars.length,
                      itemBuilder: (context, index) {
                        final cal = _calendars[index];
                        return CheckboxListTile(
                          title: Text(cal.name),
                          value: cal.isVisible,
                          activeColor: cal.color,
                          secondary: CircleAvatar(backgroundColor: cal.color, radius: 6),
                          onChanged: (val) {
                            setState(() {
                              cal.isVisible = val ?? true;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final monthName = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Text("${monthName[_focusedDate.month - 1]} ${_focusedDate.year}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
            },
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMonthView(DateTime monthDate) {
    final daysInMonth = _daysInMonth(monthDate);
    final firstDayOffset = _firstDayOffset(monthDate);
    final weekDays = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];

    return Column(
      children: [
        // Cabeçalho dos dias da semana
        Row(
          children: weekDays
              .map(
                (day) => Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      day,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        // Grid dos dias
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(), // Scroll é controlado pelo PageView
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2, // Ajuste isso para mudar a altura das células
            ),
            itemCount: daysInMonth + firstDayOffset,
            itemBuilder: (context, index) {
              if (index < firstDayOffset) {
                return Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                ); // Célula vazia
              }

              final day = index - firstDayOffset + 1;
              final currentDayDate = DateTime(monthDate.year, monthDate.month, day);

              // Filtrar eventos deste dia E que pertençam a calendários visíveis
              final dayEvents = _events.where((e) {
                final isSameDay = e.date.year == currentDayDate.year && e.date.month == currentDayDate.month && e.date.day == currentDayDate.day;

                final isCalendarVisible = _calendars.firstWhere((c) => c.id == e.calendarId).isVisible;

                return isSameDay && isCalendarVisible;
              }).toList();

              final isToday =
                  DateTime.now().year == currentDayDate.year &&
                  DateTime.now().month == currentDayDate.month &&
                  DateTime.now().day == currentDayDate.day;

              return InkWell(
                onTap: () => _showEventDialog(dateForNew: currentDayDate),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: isToday ? const BoxDecoration(color: Colors.blue, shape: BoxShape.circle) : null,
                          child: Text(
                            "$day",
                            style: TextStyle(fontWeight: FontWeight.bold, color: isToday ? Colors.white : Colors.black87),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: dayEvents.map((event) {
                            final category = _calendars.firstWhere((c) => c.id == event.calendarId);
                            return GestureDetector(
                              onTap: () => _showEventDialog(eventToEdit: event),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: category.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border(left: BorderSide(color: category.color, width: 3)),
                                ),
                                child: Text(
                                  event.title,
                                  style: TextStyle(color: category.color.withOpacity(0.9), fontSize: 10, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
