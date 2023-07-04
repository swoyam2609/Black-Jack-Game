import 'dart:math';
import 'package:flutter/material.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({super.key});

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool _isStarted = false;

  // My cards
  List<Image> dealersCards = [];
  List<Image> myCards = [];

  //Dealers Cards
  String? dealersFirstCard;
  String? dealersSecondCard;

  //My Cards
  String? myFirstCard;
  String? mySecondCard;

  //Scores
  int dealersScore = 0;
  int myScore = 0;

  //Deck of cards
  final Map<String, int> deckOfCards = {
    "lib/cards/2.1.png": 2,
    "lib/cards/2.2.png": 2,
    "lib/cards/2.3.png": 2,
    "lib/cards/2.4.png": 2,
    "lib/cards/3.1.png": 3,
    "lib/cards/3.2.png": 3,
    "lib/cards/3.3.png": 3,
    "lib/cards/3.4.png": 3,
    "lib/cards/4.1.png": 4,
    "lib/cards/4.2.png": 4,
    "lib/cards/4.3.png": 4,
    "lib/cards/4.4.png": 4,
    "lib/cards/5.1.png": 5,
    "lib/cards/5.2.png": 5,
    "lib/cards/5.3.png": 5,
    "lib/cards/5.4.png": 5,
    "lib/cards/6.1.png": 6,
    "lib/cards/6.2.png": 6,
    "lib/cards/6.3.png": 6,
    "lib/cards/6.4.png": 6,
    "lib/cards/7.1.png": 7,
    "lib/cards/7.2.png": 7,
    "lib/cards/7.3.png": 7,
    "lib/cards/7.4.png": 7,
    "lib/cards/8.1.png": 8,
    "lib/cards/8.2.png": 8,
    "lib/cards/8.3.png": 8,
    "lib/cards/8.4.png": 8,
    "lib/cards/9.1.png": 9,
    "lib/cards/9.2.png": 9,
    "lib/cards/9.3.png": 9,
    "lib/cards/9.4.png": 9,
    "lib/cards/10.1.png": 10,
    "lib/cards/10.2.png": 10,
    "lib/cards/10.3.png": 10,
    "lib/cards/10.4.png": 10,
    "lib/cards/J1.png": 10,
    "lib/cards/J2.png": 10,
    "lib/cards/J3.png": 10,
    "lib/cards/J4.png": 10,
    "lib/cards/Q1.png": 10,
    "lib/cards/Q2.png": 10,
    "lib/cards/Q3.png": 10,
    "lib/cards/Q4.png": 10,
    "lib/cards/K1.png": 10,
    "lib/cards/K2.png": 10,
    "lib/cards/K3.png": 10,
    "lib/cards/K4.png": 10,
    "lib/cards/A1.png": 11,
    "lib/cards/A2.png": 11,
    "lib/cards/A3.png": 11,
    "lib/cards/A4.png": 11,
  };

  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  // Reset the cards and reset the rounds
  void changeCards() {
    _isStarted = true;
    dealersCards.clear();
    myCards.clear();
    playingCards.clear();
    playingCards.addAll(deckOfCards);

    Random random = Random();

    // Getting the dealers card
    dealersFirstCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == dealersFirstCard);
    dealersSecondCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == dealersSecondCard);

    // getting the players card
    myFirstCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == myFirstCard);
    mySecondCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == mySecondCard);

    // Adding the image assets to the lists
    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));
    myCards.add(Image.asset(myFirstCard!));
    myCards.add(Image.asset(mySecondCard!));

    // Calculating the scores
    dealersScore =
        deckOfCards[dealersFirstCard]! + deckOfCards[dealersSecondCard]!;
    myScore = deckOfCards[myFirstCard]! + deckOfCards[mySecondCard]!;

    setState(() {});
  }

  // Add an extra card to the player
  void addCards() {
    if (playingCards.isNotEmpty) {
      Random random = Random();

      String newCard =
          playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));

      playingCards.removeWhere((key, value) => key == newCard);

      myScore += deckOfCards[newCard]!;

      myCards.add(Image.asset(newCard));
    }

    if (dealersScore <= 17 && playingCards.isNotEmpty) {
      Random random = Random();
      String newCard =
          playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
      playingCards.removeWhere((key, value) => key == newCard);
      dealersScore += deckOfCards[newCard]!;
      dealersCards.add(Image.asset(newCard));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isStarted
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Dealers Column
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "Dealer's Score $dealersScore",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: dealersScore > myScore
                                      ? Colors.green
                                      : dealersScore == myScore
                                          ? Color(0xFFAB9D22)
                                          : Colors.red),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: dealersCards.length == 2
                                ? 2
                                : dealersCards.length == 3
                                    ? 3
                                    : 4,
                          ),
                          itemCount: dealersCards.length,
                          itemBuilder: (context, index) {
                            // TODO:- return builders card
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: dealersCards[index],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Text(
                          "Players's Score $myScore",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: myScore < dealersScore
                                      ? Colors.red
                                      : myScore == dealersScore
                                          ? Color(0xFFAB9D22)
                                          : Colors.green),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: myCards.length == 2
                                ? 2
                                : myCards.length == 3
                                    ? 3
                                    : 4,
                          ),
                          itemCount: myCards.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: myCards[index],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          addCards();
                        },
                        color: Colors.green[900],
                        child: Text("Another Card"),
                      ),
                      MaterialButton(
                        color: Color(0xFF0D3557),
                        onPressed: () {
                          changeCards();
                        },
                        child: Text("Next Round"),
                      )
                    ],
                  )
                ],
              ),
            )
          : Center(
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _isStarted = true;
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Text(
                    "Start Game",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                ),
                color: Colors.purple[800],
                minWidth: 200,
              ),
            ),
    );
  }
}
