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
VALUES ('portal gun', 'a gadget that allows the user(s) to travel between different universes/dimensions/realities', 150, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest?cb=20140509065310');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('butter robot', 'a small, two armed, mobile robot created for the sole purpose of passing butter.', 75, 5, 'https://vignette.wikia.nocookie.net/rickandmorty/images/6/67/Butter_Robot_Picture.png/revision/latest?cb=20171106225602');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('plumbus', 'an all-purpose home device. Everyone knows what it does, so there is no reason to explain it.', 100, 3, 'https://vignette.wikia.nocookie.net/rickandmorty/images/d/d1/Everybody_has_a_Plumbus.JPG/revision/latest?cb=20170926163022');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('mr meeseeks box', 'a gadget that creates a Mr. Meeseeks for the purpose of completing one given objective.', 250, 2, 'https://vignette.wikia.nocookie.net/rickandmorty/images/f/f7/Mr._Meeseeks_Box.png/revision/latest?cb=20160909153718');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('microverse battery', 'a miniature universe with a planet inhabited by intelligent life. These lifeforms use kinetic devices to produce electricity.', 300, 3, 'https://vignette.wikia.nocookie.net/rickandmorty/images/8/86/Microverse_Battery.png/revision/latest?cb=20160910010946');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('time crystal', 'a material that is capable of interacting with the flow of time and bypassing split timelines.', 50, 6, 'https://vignette.wikia.nocookie.net/rickandmorty/images/c/c0/Time_Crystal.png/revision/latest?cb=20160910011054');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('interdimensional cable', 'a cable box that gives access to television shows across every dimension.', 125, 3, 'https://vignette.wikia.nocookie.net/rickandmorty/images/2/27/Interdimensional_Cable_Box.png/revision/latest?cb=20160910005523');

INSERT INTO inventories (name, description, price, quantity, image_url)
VALUES ('IQ enhancing helmet', 'boosts the wearers IQ considerably', 400, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/9/9c/IQ_Enhancing_Helmet.png/revision/latest?cb=20160910011355');

-- CARTS

-- INSERT INTO carts(inventory_id, quantity, user_id)
-- VALUES (1, 1, 2);

-- USERS

-- INSERT INTO users (name, email, password_digest)
-- VALUES ('james', 'james@ga.co', '$2a$10$XuY4QtlKrI08gzms40QCu.KzUKLLVyf3IUz/NAAbbeu4Jvtbx9fQq');

-- REVIEWS