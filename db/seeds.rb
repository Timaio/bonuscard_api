user1 = User.create(email: "user1@email.com")
user2 = User.create(email: "user2@email.com")

shop1 = Shop.create(name: "Shop1")
shop2 = Shop.create(name: "Shop2")

card1 = Card.create(user: user1, shop: shop1)
card2 = Card.create(user: user1, shop: shop2)
card3 = Card.create(user: user2, shop: shop1)
card4 = Card.create(user: user2, shop: shop2)
