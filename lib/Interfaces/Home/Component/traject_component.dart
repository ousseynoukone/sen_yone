import 'package:SenYone/utils.dart';
import 'package:flutter/material.dart';

class TrajectComponent extends StatelessWidget {
  const TrajectComponent({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Trajet direct: ",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  busNumero(29, width, context),
                ],
              ),
              Row(children: [trajectDetail(width)])
            ],
          ),
        ),
      )
    ]);
  }

  Widget busNumero(numero, width, context) {
    return Container(
      // group34019g5G (210:864)
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // Ktv (210:861)
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                numero.toString(),
                style: SafeGoogleFont(
                  'Red Hat Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.3225,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 21,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              width: 22,
              height: 24,
              child: Image.asset(
                'assets/page-1/images/vector-Bkv.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget trajectDetail(width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // group34009Fg6 (210:817)
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                // dpartB3x (210:818)
                child: Text(
                  'Départ         : ',
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              RichText(
                // prendrele29casebafjp (210:819)
                text: TextSpan(
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                  children: [
                    TextSpan(
                      text: 'Prendre le  ',
                    ),
                    TextSpan(
                      text: '29',
                      style: SafeGoogleFont(
                        'Red Hat Display',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.3225,
                        color: Color(0xffffffff),
                      ),
                    ),
                    TextSpan(
                      text: ' à ',
                    ),
                    TextSpan(
                      text: 'Case-Ba',
                      style: SafeGoogleFont(
                        'Red Hat Display',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.3225,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          // group34009Fg6 (210:817)
          margin: EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // dpartB3x (210:818)
                child: Text(
                  'Arrivé           : ',
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              RichText(
                // prendrele29casebafjp (210:819)
                text: TextSpan(
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                  children: [
                    TextSpan(
                      text: 'Descendre  ',
                    ),
                    TextSpan(
                      text: ' à ',
                    ),
                    TextSpan(
                      text: 'Petersen',
                      style: SafeGoogleFont(
                        'Red Hat Display',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.3225,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          // group34009Fg6 (210:817)
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                // dpartB3x (210:818)
                child: Text(
                  'Fréquence : ',
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              RichText(
                // prendrele29casebafjp (210:819)
                text: TextSpan(
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                  children: [
                    TextSpan(
                      text: 'Descendre ',
                    ),
                    TextSpan(
                      text: ' à ',
                    ),
                    TextSpan(
                      text: 'Petersen',
                      style: SafeGoogleFont(
                        'Red Hat Display',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.3225,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                SizedBox(
                  // vectorzcz (212:1464)
                  width: 19,
                  height: 21,
                  child: Image.asset(
                    'assets/page-1/images/vector-g3C.png',
                    width: 19,
                    height: 21,
                  ),
                ),
                Text(
                  // moinslongK9U (212:1466)
                  'Moins long',
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: width / 1.94,
            ),
            Container(
              // group34007exS (210:813)
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff810000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    // vectorkka (210:816)
                    margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                    width: 22,
                    height: 24,
                    child: Image.asset(
                      'assets/page-1/images/vector-j22.png',
                      width: 22,
                      height: 24,
                    ),
                  ),
                  Container(
                    // dtailfce (210:815)
                    margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(
                      'Détail',
                      style: SafeGoogleFont(
                        'Red Hat Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.3225,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
