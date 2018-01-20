-- TRUNCATE TABLE carts;
-- TRUNCATE TABLE reviews;
-- TRUNCATE TABLE users;
-- TRUNCATE TABLE inventories;
DELETE FROM carts;
DELETE FROM reviews;
DELETE FROM users;
DELETE FROM inventories;

ALTER SEQUENCE inventories_id_seq RESTART WITH 1;
ALTER SEQUENCE carts_id_seq RESTART WITH 1;
ALTER SEQUENCE users_id_seq RESTART WITH 1;
ALTER SEQUENCE reviews_id_seq RESTART WITH 1;

-- INVENTORIES

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('portal gun', 'A gadget that allows the user(s) to travel between different universes/dimensions/realities.', 150, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest?cb=20140509065310');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('butter robot', 'A small, two armed, mobile robot created for the sole purpose of passing butter.', 75, 5, 'https://vignette.wikia.nocookie.net/rickandmorty/images/6/67/Butter_Robot_Picture.png/revision/latest?cb=20171106225602');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('plumbus', 'An all-purpose home device. Everyone knows what it does, so there is no reason to explain it.', 100, 20, 'https://vignette.wikia.nocookie.net/rickandmorty/images/d/d1/Everybody_has_a_Plumbus.JPG/revision/latest?cb=20170926163022');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('mr meeseeks box', 'A gadget that creates a Mr. Meeseeks for the purpose of completing one given objective.', 250, 2, 'https://vignette.wikia.nocookie.net/rickandmorty/images/f/f7/Mr._Meeseeks_Box.png/revision/latest?cb=20160909153718');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('microverse battery', 'A miniature universe with a planet inhabited by intelligent life. These lifeforms use kinetic devices to produce electricity.', 300, 3, 'https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest?cb=20160910010946');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('time crystal', 'A material that is capable of interacting with the flow of time and bypassing split timelines.', 50, 6, 'https://vignette.wikia.nocookie.net/rickandmorty/images/c/c0/Time_Crystal.png/revision/latest?cb=20160910011054');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('interdimensional cable', 'A cable box that gives access to television shows across every dimension.', 125, 3, 'https://vignette.wikia.nocookie.net/rickandmorty/images/2/27/Interdimensional_Cable_Box.png/revision/latest?cb=20160910005523');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('IQ enhancing helmet', 'Boosts the wearers IQ considerably.', 400, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/9/9c/IQ_Enhancing_Helmet.png/revision/latest?cb=20160910011355');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('turbulent juice', 'A multi-purpose cleaning product and nutritional supplement fluid advertised on cable channels based in dimensions other than C-137.', 80, 5, 'https://vignette.wikia.nocookie.net/rickandmorty/images/f/f5/Turbulent_Juice_Tube.png/revision/latest?cb=20160910012824');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('Roy VR Headset', 'How far can you take Rocket Roy?', 300, 2, 'https://vignette.wikia.nocookie.net/rickandmorty/images/0/04/Roy_VR_Headset.png/revision/latest?cb=20160909154240');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('love potion', 'Move things well outside of the "friendzone".', 175, 3, 'https://vignette.wikia.nocookie.net/rickandmorty/images/3/3b/Love_Potion.png/revision/latest?cb=20160909140255');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('neutrino bomb', 'Kills all the living things. (Stand back.)', 500, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/b/b1/Neutrino_Bomb.png/revision/latest/scale-to-width-down/310?cb=20160910005717');


-- CARTS

-- INSERT INTO carts(inventory_id, quantity, user_id)
-- VALUES (1, 1, 2);

-- USERS

-- INSERT INTO users (name, email, password_digest)
-- VALUES ('james', 'james@ga.co', '$2a$10$XuY4QtlKrI08gzms40QCu.KzUKLLVyf3IUz/NAAbbeu4Jvtbx9fQq');

-- REVIEWS