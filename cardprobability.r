#probability with cards
#both cards black aces
p.one.bace = sum((card1$NoSuits == 'Clubs' | card1$NoSuits == 'Spades') & card1$cardNamesList == 'ace')/nosamps
p.tw.bace = sum((card2$NoSuits == 'Clubs' | card2$NoSuits == 'Spades') & card2$cardNamesList == 'ace')/nosamps
p.both.bace = (sum((card1$NoSuits == 'Clubs' | card1$NoSuits == 'Spades') & card1$cardNamesList == 'ace')/nosamps)*
  (sum((card2$NoSuits == 'Clubs' | card2$NoSuits == 'Spades') & card2$cardNamesList == 'ace')/nosamps)
cat('\nthe probability that both cards picked will be black aces is P = ',p.both.bace)

#heart and club
#card 1 = heart, card 2 = club
p.one.heart = sum(card1$NoSuits == 'Hearts')/nosamps
p.two.club = sum(card2$NoSuits == 'Clubs')/nosamps
#card 1 = club, card 2 = heart
p.one.club = sum(card1$NoSuits == 'Clubs')/nosamps
p.two.heart = sum(card2$NoSuits == 'Hearts')/nosamps
#probablity of either of these combos occurring
p.heart.club = p.one.heart * p.two.club + p.one.club * p.two.heart

#red and black card
p.one.red = sum(card1$NoSuits == 'Hearts'|card1$NoSuits == 'Diamond')/nosamps
p.one.black = sum(card1$NoSuits == 'Clubs'|card1$NoSuits == 'Spades')/nosamps
p.two.red = sum(card2$NoSuits == 'Hearts'|card2$NoSuits == 'Diamond')/nosamps
p.two.black = sum(card2$NoSuits == 'Clubs'|card2$NoSuits == 'Spades')/nosamps
p.both = p.one.red*p.two.black + p.one.black*p.two.red