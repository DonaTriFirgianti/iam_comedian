import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// Aplikasi utama yang menampilkan interface komedian
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<Color> _gradientColors = [
    const Color(0xFFFFB7D5),
    const Color(0xFF81D4FA),
    const Color(0xFFFFF59D),
  ];

  @override
  void initState() {
    super.initState();
    // Mengatur controller animasi untuk efek pulsating
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Mengatur animasi scaling dengan kurva easing
    _animation = Tween<double>(
      begin: 0.98,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    // Membersihkan controller saat widget dihapus
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Judul dengan efek gradient warna
              ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      colors: _gradientColors,
                      tileMode: TileMode.mirror,
                    ).createShader(bounds),
                child: const Text(
                  'I Am Comedian ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              // Emoji dengan animasi rotasi
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (context, val, child) {
                  return Transform(
                    transform:
                        Matrix4.identity()
                          ..rotateZ(val * 6.28) // Rotasi 360 derajat
                          ..scale(1.0 + val * 0.2), // Efek scaling
                    child: child,
                  );
                },
                child: const Text('🎭', style: TextStyle(fontSize: 35)),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFFF3E0),
          centerTitle: true,
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
                ),
              ),
              child: Column(
                children: [
                  // Bagian gambar dengan animasi naik turun
                  SizedBox(
                    height: constraints.maxHeight * 0.35,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 10 * _animation.value),
                          child: Transform.scale(
                            scale: _animation.value,
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: PhysicalModel(
                          color: Colors.transparent,
                          elevation: 20,
                          shadowColor: const Color(0xFFF5E6CA),
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFF59D), Color(0xFFFFCCBC)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: const Color(0xFFD5BDAF),
                                width: 3,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Image.asset(
                                'assets/img/comedian.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Daftar joke cards dalam ListView
                  SizedBox(
                    height: constraints.maxHeight * 0.55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Card(
                        elevation: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: const Color(0xFFF5E6CA),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFFD5BDAF),
                              width: 2,
                            ),
                            color: const Color(0xFFF5E6CA),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildJokeCard(
                                '🧊',
                                Colors.blue,
                                '"Kenapa kulkas dingin?" Karena kalau panas, namanya jadi kompor.',
                              ),
                              _buildJokeCard(
                                '😅',
                                Colors.orange,
                                '1 kalimat lucu : \n"Spontan Uhuyyyy..."',
                              ),
                              _buildJokeCard(
                                '💪',
                                Colors.green,
                                'Belajar dari BULU KETEK walaupun slalu terhimpit tapi tetap TEGAR dan TETAP TUMBUH',
                              ),
                              _buildJokeCard(
                                '🦋',
                                Colors.purple,
                                'Kupu kupu terbang melayang, i love you sayang',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Footer dengan quote komedi
                  SizedBox(
                    height: constraints.maxHeight * 0.08,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShaderMask(
                            shaderCallback:
                                (bounds) => LinearGradient(
                                  colors: _gradientColors,
                                ).createShader(bounds),
                            child: const Text(
                              '"Komedi itu kayak kentut\nKalau dipaksa, hasilnya nggak akan bagus 🤭"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Membuat widget kartu joke dengan emoji dan warna tertentu
  /// [emoji] - Emoji untuk ikon kartu
  /// [color] - Warna tema kartu
  /// [text] - Teks joke yang akan ditampilkan
  Widget _buildJokeCard(String emoji, Color color, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(100), width: 1.5),
      ),
      child: ListTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 26)),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
            height: 1.5,
          ),
          maxLines: 4,
          overflow: TextOverflow.visible,
        ),
        minLeadingWidth: 5,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        dense: true,
      ),
    );
  }
}
