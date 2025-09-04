CREATE DATABASE IF NOT EXISTS brigitte_bdd;

USE brigitte_bdd;

-- CREATION DES TABLES
-- TABLES SANS CLEF ETRANGERE
CREATE TABLE IF NOT EXISTS espece (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS famille (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS ordre (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS classe ( 
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) UNIQUE NOT NULL,
  adoptable BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS origine (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS maladie (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS fonctionnalite (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(254) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS poste (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS adresse (
  id INT AUTO_INCREMENT PRIMARY KEY,
  rueEtNumero VARCHAR(254),
  ville VARCHAR(50) NOT NULL,
  codePostal VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS parent (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS enfant (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) UNIQUE NOT NULL
);

-- TABLES AVEC CLEF ETRANGERE

CREATE TABLE IF NOT EXISTS vaccin (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) UNIQUE NOT NULL,
  id_classe INT NOT NULL,
  FOREIGN KEY (id_classe) REFERENCES classe(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS employe (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  id_adresse INT NOT NULL,
  id_poste INT NOT NULL,
  FOREIGN KEY (id_adresse) REFERENCES adresse(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_poste) REFERENCES poste(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS adoptant (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  id_adresse INT NOT NULL,
  FOREIGN KEY (id_adresse) REFERENCES adresse(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS menu (
  id INT AUTO_INCREMENT PRIMARY KEY,
  viande INT NOT NULL DEFAULT 0,
  legume INT NOT NULL DEFAULT 0,
  id_employe INT NOT NULL,
  FOREIGN KEY (id_employe) REFERENCES employe(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS allee (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_employe INT NOT NULL,
  FOREIGN KEY (id_employe) REFERENCES employe(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS cage (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_fonctionnalite INT NOT NULL,
  id_allee INT NOT NULL,
  FOREIGN KEY (id_fonctionnalite) REFERENCES fonctionnalite(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_allee) REFERENCES allee(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS animal (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  race VARCHAR(50) NOT NULL,
  sexe CHAR(1) NOT NULL CHECK (sexe IN ('M', 'F')),
  dateNaissance DATE NOT NULL,
  dateArrivee DATE NOT NULL,
  domestique BOOLEAN DEFAULT FALSE,
  id_classe INT NOT NULL,
  id_ordre INT NOT NULL,
  id_famille INT NOT NULL,
  id_espece INT NOT NULL,
  id_origine INT,
  id_menu INT NOT NULL,
  id_cage INT NOT NULL,
  FOREIGN KEY (id_classe) REFERENCES classe(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_ordre) REFERENCES ordre(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_famille) REFERENCES famille(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_espece) REFERENCES espece(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_origine) REFERENCES origine(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_menu) REFERENCES menu(id) ON DELETE RESTRICT,
  FOREIGN KEY (id_cage) REFERENCES cage(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS carnet (
  id INT AUTO_INCREMENT PRIMARY KEY,
  prochaineVaccination DATE,
  id_animal INT UNIQUE NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE
);

-- TABLES ASSOCIATIVES

CREATE TABLE IF NOT EXISTS carnet_vaccin (
  id_carnet INT NOT NULL,
  id_vaccin INT NOT NULL,
  dateVaccination DATE NOT NULL,
  FOREIGN KEY (id_carnet) REFERENCES carnet(id) ON DELETE CASCADE,
  FOREIGN KEY (id_vaccin) REFERENCES vaccin(id) ON DELETE RESTRICT,
  PRIMARY KEY (id_carnet, id_vaccin)
);

CREATE TABLE IF NOT EXISTS carnet_maladie (
  id_carnet INT NOT NULL,
  id_maladie INT NOT NULL,
  dateContraction DATE NOT NULL,
  FOREIGN KEY (id_carnet) REFERENCES carnet(id) ON DELETE CASCADE,
  FOREIGN KEY (id_maladie) REFERENCES maladie(id) ON DELETE RESTRICT,
  PRIMARY KEY (id_carnet, id_maladie)
);

CREATE TABLE IF NOT EXISTS animal_parent (
  id_animal INT NOT NULL,
  id_parent INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE,
  FOREIGN KEY (id_parent) REFERENCES parent(id) ON DELETE RESTRICT,
  PRIMARY KEY (id_animal, id_parent)
);

CREATE TABLE IF NOT EXISTS animal_enfant (
  id_animal INT NOT NULL,
  id_enfant INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE,
  FOREIGN KEY (id_enfant) REFERENCES enfant(id) ON DELETE RESTRICT,
  PRIMARY KEY (id_animal, id_enfant)
);

CREATE TABLE IF NOT EXISTS animal_employe (
  id_animal INT NOT NULL,
  id_employe INT NOT NULL,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE CASCADE,
  FOREIGN KEY (id_employe) REFERENCES employe(id) ON DELETE RESTRICT,
  PRIMARY KEY (id_animal, id_employe)
);

CREATE TABLE IF NOT EXISTS cage_employe (
  id_cage INT NOT NULL,
  id_employe INT NOT NULL,
  FOREIGN KEY (id_cage) REFERENCES cage(id) ON DELETE CASCADE,
  FOREIGN KEY (id_employe) REFERENCES employe(id) ON DELETE RESTRICT,
  PRIMARY KEY (id_cage, id_employe)
);

CREATE TABLE IF NOT EXISTS adoptant_animal (
  id_adoptant INT NOT NULL,
  id_animal INT NOT NULL,
  FOREIGN KEY (id_adoptant) REFERENCES adoptant(id) ON DELETE CASCADE,
  FOREIGN KEY (id_animal) REFERENCES animal(id) ON DELETE RESTRICT,
  PRIMARY KEY (id_adoptant, id_animal)
);

-- INSERTION DES DONNEES

SET FOREIGN_KEY_CHECKS = 0;


INSERT INTO espece (nom) VALUES
('Lion'), ('Tigre'), ('Léopard'), ('Éléphant'), ('Girafe'),
('Aigle'), ('Faucon'), ('Perroquet'), ('Singe'), ('Gorille'),
('Serpent'), ('Crocodile'), ('Tortue'), ('Grenouille'), ('Salamandre'),
('Chien'), ('Chat'), ('Lapin'), ('Hamster'), ('Poisson rouge');

INSERT INTO famille (nom) VALUES
('Félidé'), ('Bovidé'), ('Canidé'), ('Accipitridé'), ('Psittacidé'),
('Cercopithécidé'), ('Hominidé'), ('Colubridé'), ('Crocodilidé'), ('Testudidé'),
('Ranidé'), ('Salamandridé'), ('Leporidé'), ('Cricetidé'), ('Cyprinidé'),
('Ursidé'), ('Équidé'), ('Suidé'), ('Viperidé'), ('Strigidé');

INSERT INTO ordre (nom) VALUES
('Carnivore'), ('Herbivore'), ('Omnivore'), ('Rongeur'), ('Strigiforme'),
('Chélonien'), ('Primat'), ('Rapace'), ('Passereau'), ('Aquatique'),
('Reptile'), ('Amphibien'), ('Mammifère'), ('Oiseau'), ('Poisson'),
('Insectivore'), ('Frugivore'), ('Piscivore'), ('Nectarivore'), ('Granivore');

INSERT INTO classe (nom, adoptable) VALUES
('Mammifère', TRUE), ('Oiseau', TRUE), ('Reptile', FALSE), ('Amphibien', FALSE), 
('Poisson', TRUE), ('Félin', TRUE), ('Canin', TRUE), ('Primate', FALSE),
('Rapace', FALSE), ('Rongeur', TRUE), ('Herbivore', TRUE), ('Carnivore', FALSE),
('Aquatique', TRUE), ('Domestique', TRUE), ('Sauvage', FALSE), ('Exotique', FALSE),
('Tropical', FALSE), ('Nocturne', FALSE), ('Diurne', TRUE), ('Migrateur', FALSE);

INSERT INTO origine (nom) VALUES
('Kenya'), ('Afrique'), ('France'), ('Brésil'), ('Inde'),
('Australie'), ('Canada'), ('Japon'), ('Madagascar'), ('Indonésie'),
('Pérou'), ('Argentine'), ('Chine'), ('Russie'), ('Norvège'),
('Égypte'), ('Maroc'), ('Thaïlande'), ('Mexique'), ('Chili');

INSERT INTO maladie (nom) VALUES
('Grippe'), ('Rage'), ('Tuberculose'), ('Pneumonie'), ('Gastrite'),
('Arthrite'), ('Conjonctivite'), ('Dermatite'), ('Parasitose'), ('Anémie'),
('Diabète'), ('Hypertension'), ('Allergie'), ('Infection'), ('Fracture'),
('Blessure'), ('Malnutrition'), ('Déshydratation'), ('Stress'), ('Dépression');

INSERT INTO fonctionnalite (nom) VALUES
('Cage pour grands fauves'), ('Volière pour oiseaux'), ('Terrarium'), ('Aquarium'),
('Enclos herbivores'), ('Cage primates'), ('Nursery'), ('Quarantaine'),
('Soins intensifs'), ('Cage reproduction'), ('Enclos extérieur'), ('Cage nocturne'),
('Bassin aquatique'), ('Cage tropicale'), ('Enclos désertique'), ('Cage polaire'),
('Cage d\'isolement'), ('Cage de transit'), ('Enclos familial'), ('Cage médicale');

INSERT INTO poste (nom) VALUES
('Soigneur'), ('Responsable');

INSERT INTO adresse (rueEtNumero, ville, codePostal) VALUES
('15 rue Peyrin', 'Nouméa', '98800'),
('23 avenue Berrut', 'Sartène', '20100'),
('8 place Sicard', 'Calvi', '20260'),
('45 boulevard Voiron', 'Pointe à Pitre', '97110'),
('12 rue Scholl', 'Ushuaia', '9410'),
('67 chemin Adiba', 'Papeete', '98714'),
('34 rue de la Paix', 'Paris', '75001'),
('56 avenue Victor Hugo', 'Lyon', '69001'),
('78 boulevard Gambetta', 'Marseille', '13001'),
('90 rue Nationale', 'Tours', '37000'),
('123 avenue des Champs', 'Bordeaux', '33000'),
('456 rue Saint-Michel', 'Toulouse', '31000'),
('789 place Bellecour', 'Lille', '59000'),
('321 rue de Rivoli', 'Strasbourg', '67000'),
('654 avenue Foch', 'Nice', '06000'),
('987 boulevard Haussmann', 'Nantes', '44000'),
('147 rue Lafayette', 'Montpellier', '34000'),
('258 avenue Pasteur', 'Rennes', '35000'),
('369 place Wilson', 'Dijon', '21000'),
('741 rue Carnot', 'Angers', '49000');

INSERT INTO parent (nom) VALUES
('Simba Senior'), ('Nala Mère'), ('Rex Papa'), ('Luna Maman'), ('Kovu Père'),
('Sarabi Grand-mère'), ('Mufasa Grand-père'), ('Timon Papa'), ('Pumbaa Père'), ('Zazu Senior'),
('Bagheera Père'), ('Baloo Papa'), ('Shere Khan Senior'), ('Akela Chef'), ('Raksha Mère'),
('Kaa Ancien'), ('King Louie Père'), ('Hathi Papa'), ('Winifred Maman'), ('Buzzie Senior');

INSERT INTO enfant (nom) VALUES
('Simba Junior'), ('Kiara Fille'), ('Kovu Fils'), ('Vitani Petite'), ('Nuka Enfant'),
('Timon Fils'), ('Pumbaa Junior'), ('Zazu Petit'), ('Rafiki Enfant'), ('Sarabi Fille'),
('Mowgli Petit'), ('Bagheera Fils'), ('Baloo Junior'), ('Shere Khan Fils'), ('Akela Petit'),
('Raksha Fille'), ('Kaa Petit'), ('King Louie Fils'), ('Hathi Junior'), ('Winifred Fille');


INSERT INTO vaccin (nom, id_classe) VALUES
('Vaccin antirabique', 1), ('Vaccin contre la grippe aviaire', 2), ('Vaccin reptilien', 3),
('Vaccin amphibien', 4), ('Vaccin aquatique', 5), ('Vaccin félin', 6), ('Vaccin canin', 7),
('Vaccin primate', 8), ('Vaccin rapace', 9), ('Vaccin rongeur', 10), ('Vaccin herbivore', 11),
('Vaccin carnivore', 12), ('Vaccin tropical', 14), ('Vaccin domestique', 14), ('Vaccin exotique', 16),
('Vaccin polyvalent', 1), ('Vaccin saisonnier', 2), ('Vaccin préventif', 3), ('Vaccin curatif', 4),
('Vaccin renforcé', 5);


INSERT INTO employe (nom, prenom, id_adresse, id_poste) VALUES
-- Soigneurs (poste 1)
('Peyrin', 'Jean', 1, 1), ('Berrut', 'Marie', 2, 1), ('Sicard', 'Paul', 3, 1),
('Scholl', 'Pierre', 5, 1), ('Adiba', 'Fatima', 6, 1), ('Dubois', 'Emma', 8, 1),
('Simon', 'Léa', 10, 1), ('Michel', 'Noah', 11, 1), ('Leroy', 'Chloé', 12, 1),
('David', 'Manon', 14, 1), ('Bertrand', 'Gabriel', 15, 1), ('Morel', 'Jade', 16, 1),
('Fournier', 'Raphaël', 17, 1), ('Bonnet', 'Jules', 19, 1), ('Dupont', 'Inès', 20, 1),
-- Responsables (poste 2)
('Voiron', 'Sophie', 4, 2), ('Moreau', 'Hugo', 9, 2), ('Roux', 'Louis', 13, 2), ('Girard', 'Alice', 18, 2),
('Martin', 'Lucas', 7, 2);


INSERT INTO adoptant (nom, prenom, id_adresse) VALUES
('Famille', 'Adopteuse1', 1), ('Maison', 'Accueillante1', 2), ('Foyer', 'Chaleureux1', 3),
('Famille', 'Adopteuse2', 4), ('Maison', 'Accueillante2', 5), ('Foyer', 'Chaleureux2', 6),
('Famille', 'Adopteuse3', 7), ('Maison', 'Accueillante3', 8), ('Foyer', 'Chaleureux3', 9),
('Famille', 'Adopteuse4', 10), ('Maison', 'Accueillante4', 11), ('Foyer', 'Chaleureux4', 12),
('Famille', 'Adopteuse5', 13), ('Maison', 'Accueillante5', 14), ('Foyer', 'Chaleureux5', 15),
('Famille', 'Adopteuse6', 16), ('Maison', 'Accueillante6', 17), ('Foyer', 'Chaleureux6', 18),
('Famille', 'Adopteuse7', 19), ('Maison', 'Accueillante7', 20);


INSERT INTO menu (viande, legume, id_employe) VALUES
(500, 200, 1), (0, 800, 2), (300, 400, 3), (200, 600, 4), (400, 300, 5),
(100, 700, 6), (250, 500, 7), (350, 350, 8), (150, 650, 9), (650, 50, 10),
(300, 300, 11), (400, 400, 12), (200, 200, 13), (500, 500, 14), (100, 100, 15),
(600, 100, 15);


INSERT INTO allee (id_employe) VALUES
(16), (17), (18), (19), (20);


INSERT INTO cage (id_fonctionnalite, id_allee) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1), (7, 2), (8, 3),
(9, 4), (10, 5), (11, 1), (12, 2), (13, 3), (14, 4), (15, 5),
(16, 1), (17, 2), (18, 3), (19, 4), (20, 5);


INSERT INTO animal (nom, race, sexe, dateNaissance, dateArrivee, domestique, id_classe, id_ordre, id_famille, id_espece, id_origine, id_menu, id_cage) VALUES
('Charly', 'Léopard d\'Afrique', 'M', '1985-03-15', '1990-05-20', FALSE, 6, 1, 1, 3, 2, 1, 1),
('HECTOR', 'Lion du Kenya', 'M', '1988-07-10', '1991-08-15', FALSE, 6, 1, 1, 1, 1, 2, 2),
('Léopard1', 'Léopard des neiges', 'F', '1990-11-20', '1992-01-10', FALSE, 6, 1, 1, 3, 14, 3, 3),
('Léopard2', 'Léopard du Kenya', 'M', '1989-04-05', '1991-06-12', FALSE, 6, 1, 1, 3, 1, 4, 4),
('Singe1', 'Chimpanzé', 'M', '2005-02-14', '2010-03-20', FALSE, 8, 7, 6, 9, 2, 5, 5),
('Singe2', 'Gorille des montagnes', 'F', '2000-08-30', '2005-09-15', FALSE, 8, 7, 7, 10, 2, 6, 6),
('Kenya1', 'Éléphant d\'Afrique', 'M', '1991-12-25', '1993-01-30', FALSE, 1, 2, 2, 4, 1, 7, 7),
('Kenya2', 'Girafe du Kenya', 'F', '1990-06-18', '1992-07-22', FALSE, 1, 2, 2, 5, 1, 8, 8),
('Tigre1', 'Tigre de Sibérie', 'M', '2010-01-15', '2012-03-20', FALSE, 6, 1, 1, 2, 14, 9, 9),
('Aigle1', 'Aigle royal', 'F', '2015-05-10', '2016-06-15', FALSE, 9, 8, 4, 6, 15, 10, 10),
('Serpent1', 'Python royal', 'M', '2018-09-12', '2019-10-18', FALSE, 3, 11, 8, 11, 2, 11, 11),
('Tortue1', 'Tortue géante', 'F', '1995-03-08', '2000-04-12', FALSE, 3, 6, 10, 13, 9, 12, 12),
('Chat1', 'Chat persan', 'M', '2020-07-22', '2021-08-25', TRUE, 14, 1, 1, 17, 3, 13, 13),
('Chien1', 'Berger allemand', 'F', '2019-11-05', '2020-12-10', TRUE, 14, 1, 3, 16, 3, 14, 14),
('Perroquet1', 'Ara bleu', 'M', '2016-04-18', '2017-05-20', FALSE, 2, 14, 5, 8, 4, 15, 15),
('Lapin1', 'Lapin nain', 'F', '2021-02-28', '2021-03-30', TRUE, 10, 4, 13, 18, 3, 16, 16);


INSERT INTO carnet (prochaineVaccination, id_animal) VALUES
('2024-06-15', 1), ('2024-07-20', 2), ('2024-08-25', 3), ('2024-09-30', 4), ('2024-10-05', 5),
('2024-11-10', 6), ('2024-12-15', 7), ('2025-01-20', 8), ('2025-02-25', 9), ('2025-03-30', 10),
('2025-04-05', 11), ('2025-05-10', 12), ('2025-06-15', 13), ('2025-07-20', 14), ('2025-08-25', 15),
('2025-09-30', 16);


INSERT INTO carnet_vaccin (id_carnet, id_vaccin, dateVaccination) VALUES
(1, 1, '2023-06-15'), (2, 1, '2023-07-20'), (3, 1, '2023-08-25'), (4, 1, '2023-09-30'),
(5, 8, '2023-10-05'), (6, 8, '2023-11-10'), (7, 11, '2023-12-15'), (8, 11, '2024-01-20'),
(9, 1, '2024-02-25'), (10, 9, '2024-03-30'), (11, 3, '2024-04-05'), (12, 3, '2024-05-10'),
(13, 14, '2024-06-15'), (14, 14, '2024-07-20'), (15, 17, '2024-08-25'), (16, 10, '2024-09-30');


INSERT INTO carnet_maladie (id_carnet, id_maladie, dateContraction) VALUES
(1, 1, '2023-01-15'), (2, 1, '2023-02-20'), (4, 1, '2023-03-25'),
(3, 2, '2023-04-10'), (5, 3, '2023-05-15'), (6, 4, '2023-06-20'),
(7, 5, '2023-07-25'), (8, 6, '2023-08-30'), (9, 7, '2023-09-05'),
(10, 8, '2023-10-10'), (11, 9, '2023-11-15'), (12, 10, '2023-12-20'),
(13, 11, '2024-01-25'), (14, 12, '2024-02-28'), (15, 13, '2024-03-05'),
(16, 14, '2024-04-10');


INSERT INTO animal_parent (id_animal, id_parent) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (4, 8),
(5, 9), (5, 10), (6, 11), (6, 12), (7, 13), (7, 14), (8, 15), (8, 16),
(9, 17), (9, 18), (10, 19), (10, 20), (11, 1), (12, 2), (13, 3), (14, 4),
(15, 5), (15, 6), (16, 7), (16, 8);


INSERT INTO animal_enfant (id_animal, id_enfant) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (4, 8),
(5, 9), (5, 10), (6, 11), (6, 12), (7, 13), (7, 14), (8, 15), (8, 16),
(9, 17), (9, 18), (10, 19), (10, 20), (11, 1), (12, 2), (13, 3), (14, 4),
(15, 5), (15, 6), (16, 7), (16, 8);


INSERT INTO animal_employe (id_animal, id_employe) VALUES
(1, 1), (1, 16),
(2, 2), (2, 17),
(3, 3), (3, 18),
(4, 4), (4, 19),
(5, 5), (5, 16),
(6, 6), (6, 17),
(7, 7), (7, 18),
(8, 8), (8, 19),
(9, 9), (9, 16),
(10, 10), (10, 17),
(11, 11), (11, 18),
(12, 12), (12, 19),
(13, 13), (13, 16),
(14, 14), (14, 17),
(15, 15), (15, 18),
(16, 15), (16, 19);


INSERT INTO cage_employe (id_cage, id_employe) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8),
(9, 9), (10, 10), (11, 11), (12, 12), (13, 13), (14, 14), (15, 15),
(16, 15);


INSERT INTO adoptant_animal (id_adoptant, id_animal) VALUES
(1, 13), (2, 14), (3, 16),
(4, 1), (5, 7), (6, 8), (7, 15);


SET FOREIGN_KEY_CHECKS = 1;

