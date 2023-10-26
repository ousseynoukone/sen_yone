import 'package:flutter/material.dart';
import 'package:sen_yone/utils.dart';

class LineList extends StatefulWidget {
  const LineList({super.key});

  @override
  State<LineList> createState() => _LineListState();
}

class _LineListState extends State<LineList> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // autogroup8fsxwsp (2YaRKR3CGSxc9FdqT98Fsx)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 272.5 * fem, 0 * fem),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // vectorgKc (204:220)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 16 * fem, 4 * fem),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 15 * fem,
                          height: 15 * fem,
                          child: Image.asset(
                            'assets/page-1/images/vector-EzW.png',
                            width: 15 * fem,
                            height: 15 * fem,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      // listedeslignes9yt (204:218)
                      'Ligne  25',
                      style: SafeGoogleFont(
                        'Red Hat Display',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.3225 * ffem / fem,
                        color: Color(0xff1e1d1d),
                      ),
                    ),
                  ],
                ),
              ),

              // depart
              Container(
                // autogroup8kw6iLJ (EFtX3iAkDPdTuatcRf8kW6)
                width: double.infinity,
                height: 53 * fem,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Text(
                    'Depart Terminus Parcelles Assainies',
                    style: SafeGoogleFont(
                      'Red Hat Display',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3225 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),

// checkpoint

              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    // autogroupe2hpatJ (EFtbUFTxEkW1MAMVoXe2Hp)
                    width: double.infinity,
                    height: 651 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // line2u9t (204:292)
                          left: 19.9993896484 * fem,
                          top: 46.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupss82oFG (EFtXEhrRfxqaE5fgHUsS82)
                          left: 17 * fem,
                          top: 14 * fem,
                          child: Container(
                            width: 193 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse23uJJ (204:294)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // terminusparcellesassainiesbS2 (204:295)
                                  'Terminus Parcelles Assainies',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line4K78 (204:298)
                          left: 19.9993896484 * fem,
                          top: 92.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroup1hjrDTQ (EFtXThUmwYp4nV8aJN1hJr)
                          left: 17 * fem,
                          top: 60 * fem,
                          child: Container(
                            width: 147 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse24wPQ (204:300)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // cornicheu10915GAn (204:301)
                                  'Corniche (U 10-9-15)',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line8CaE (204:306)
                          left: 19.9993896484 * fem,
                          top: 138.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupda7k6Qi (EFtXfMp1fnwdrHUFYYDa7k)
                          left: 17 * fem,
                          top: 106 * fem,
                          child: Container(
                            width: 45 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogrouph4hpopv (EFtXr717GzJhPYQqdjH4Hp)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/auto-group-h4hp.png',
                                    width: 10 * fem,
                                    height: 10 * fem,
                                  ),
                                ),
                                Text(
                                  // diorWzE (204:309)
                                  'Dior',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line12roC (204:314)
                          left: 19.9993896484 * fem,
                          top: 184.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupgcq2aUJ (EFtXwmWLaC97jch2QjGCQ2)
                          left: 17 * fem,
                          top: 152 * fem,
                          child: Container(
                            width: 65 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse286Bk (204:316)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // acapesb8W (204:317)
                                  'Acapes',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line14vga (204:318)
                          left: 19.9993896484 * fem,
                          top: 231.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupyhgnqoY (EFtY81iGUdp5iPxexeyHgN)
                          left: 17 * fem,
                          top: 199 * fem,
                          child: Container(
                            width: 139 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroupcmleNYa (EFtYKbDJvRKyBnMWHHcmLe)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/auto-group-cmle.png',
                                    width: 10 * fem,
                                    height: 10 * fem,
                                  ),
                                ),
                                Text(
                                  // dispensairenoradet18 (204:321)
                                  'Dispensaire Norade',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line18R14 (204:326)
                          left: 19.9993896484 * fem,
                          top: 277.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroup8iftjnS (EFtYQb4ywxEvnZ55fw8iFt)
                          left: 17 * fem,
                          top: 245 * fem,
                          child: Container(
                            width: 179 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse31G1g (204:328)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // passageentreu22etu24BeS (204:329)
                                  'Passage entre U22 et U24',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line20ieN (204:330)
                          left: 19.9993896484 * fem,
                          top: 323.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroup1nweF8W (EFtYcVtoXaDYdbFEgk1nWe)
                          left: 17 * fem,
                          top: 291 * fem,
                          child: Container(
                            width: 159 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroupku8aaAn (EFtYoVaUz9Rex62JYZkU8a)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/auto-group-ku8a.png',
                                    width: 10 * fem,
                                    height: 10 * fem,
                                  ),
                                ),
                                Container(
                                  // autogroupgrzcHL6 (EFtYsf8DB6BncjHchmgRZc)
                                  width: 141 * fem,
                                  height: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        // marchgrandmdinecdG (204:333)
                                        left: 0 * fem,
                                        top: 0 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 141 * fem,
                                            height: 19 * fem,
                                            child: Text(
                                              'Marché Grand-Médine',
                                              style: SafeGoogleFont(
                                                'Red Hat Display',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.3225 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        // m5Wr (204:337)
                                        left: 0 * fem,
                                        top: 0 * fem,
                                        child: Align(
                                          child: SizedBox(
                                            width: 13 * fem,
                                            height: 19 * fem,
                                            child: Text(
                                              'm',
                                              style: SafeGoogleFont(
                                                'Red Hat Display',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.3225 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line24NF4 (204:338)
                          left: 19.9993896484 * fem,
                          top: 369.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupamcnsxW (EFtYzjkkJ6Up3pdrB2AMCN)
                          left: 17 * fem,
                          top: 337 * fem,
                          child: Container(
                            width: 48 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse34nZg (204:340)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // vdn7bx (204:341)
                                  'VDN',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line26ern (204:342)
                          left: 19.9993896484 * fem,
                          top: 416.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupfsdpyu4 (EFtZBQ7ecqEBzfdcLffSDp)
                          left: 17 * fem,
                          top: 384 * fem,
                          child: Container(
                            width: 54 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroupfjcvi5x (EFtZMUfBxMfnnd1b3WFjCv)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/auto-group-fjcv.png',
                                    width: 10 * fem,
                                    height: 10 * fem,
                                  ),
                                ),
                                Text(
                                  // relaispen (204:349)
                                  'Relais',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line30xFC (204:350)
                          left: 19.9993896484 * fem,
                          top: 462.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupmg8a5Kp (EFtZSUWrytakPPjAS9mg8A)
                          left: 17 * fem,
                          top: 430 * fem,
                          child: Container(
                            width: 176 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse37bZ4 (204:352)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // avenuecheikhantadiophMC (204:353)
                                  'Avenue Cheikh Anta Diop',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line32cj4 (204:354)
                          left: 19.9993896484 * fem,
                          top: 508.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroup4kti8xJ (EFtZdZ2jivQYJJT4DX4kti)
                          left: 17 * fem,
                          top: 476 * fem,
                          child: Container(
                            width: 151 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroup5nqqefk (EFtZuDFK5C4sqvAPmp5nqQ)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/auto-group-5nqq.png',
                                    width: 10 * fem,
                                    height: 10 * fem,
                                  ),
                                ),
                                Text(
                                  // avenueblaisediagne9cW (204:357)
                                  'Avenue Blaise Diagne',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line36soQ (204:362)
                          left: 19.9993896484 * fem,
                          top: 554.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupdl6eC4z (EFtZzxajerWynQPQUMdL6E)
                          left: 17 * fem,
                          top: 522 * fem,
                          child: Container(
                            width: 144 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse407Bx (204:364)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // avenuejeanjaursSEE (204:365)
                                  'Avenue Jean Jaurés',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line38NNn (204:366)
                          left: 19.9993896484 * fem,
                          top: 601.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroupn1ia6Jn (EFtaBxGR7Rj66uAULBN1iA)
                          left: 17 * fem,
                          top: 569 * fem,
                          child: Container(
                            width: 183 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogrouppuye2CS (EFtaMwymAVZ1JSbd7UPuYe)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/auto-group-puye.png',
                                    width: 10 * fem,
                                    height: 10 * fem,
                                  ),
                                ),
                                Text(
                                  // avenuegeorgepompidoujsY (204:369)
                                  'Avenue George Pompidou',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // line424ev (204:374)
                          left: 19.9993896484 * fem,
                          top: 647.5 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 376 * fem,
                              height: 1 * fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0x4c000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // autogroup9t4nNfc (EFtaTHADKrvhGs6WCJ9T4N)
                          left: 17 * fem,
                          top: 615 * fem,
                          child: Container(
                            width: 104 * fem,
                            height: 19 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ellipse436Li (204:376)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 3 * fem, 8 * fem, 0 * fem),
                                  width: 10 * fem,
                                  height: 10 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                    color: Color(0xffb10000),
                                  ),
                                ),
                                Text(
                                  // allescanard1yU (204:377)
                                  'Allées Canard',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
