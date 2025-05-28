CREATE DATABASE IF NOT EXISTS airline DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE airline;

CREATE TABLE IF NOT EXISTS flights (
  flight_id INT NOT NULL AUTO_INCREMENT,
  airline VARCHAR(255),
  origin VARCHAR(255),
  destination VARCHAR(255),
  departure_time DATETIME,
  arrival_time DATETIME,
  price DECIMAL(10,2),
  PRIMARY KEY (flight_id)
);

INSERT INTO flights (airline, origin, destination, departure_time, arrival_time, price) VALUES
('Airline A', 'New York', 'Los Angeles', '2022-01-01 12:00:00', '2022-01-01 15:00:00', 250.00),
('Airline B', 'New York', 'Paris', '2022-01-02 08:00:00', '2022-01-02 18:00:00', 450.00);

CREATE TABLE IF NOT EXISTS reservations (
  reservation_id INT NOT NULL AUTO_INCREMENT,
  flight_id INT,
  customer_name VARCHAR(255),
  seat_number VARCHAR(5),
  reservation_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (reservation_id),
  FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

CREATE TABLE IF NOT EXISTS seats (
  seat_id INT NOT NULL AUTO_INCREMENT,
  flight_id INT,
  seat_number VARCHAR(5),
  status ENUM('available','reserved','sold'),
  PRIMARY KEY (seat_id),
  FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

INSERT INTO seats (flight_id, seat_number, status) VALUES
(1, 'A1', 'reserved'), (1, 'A2', 'available'), (1, 'A3', 'available'),
(1, 'B1', 'available'), (1, 'B2', 'available'), (1, 'B3', 'available'),
(2, 'A1', 'available'), (2, 'A2', 'available'), (2, 'A3', 'available'),
(2, 'B1', 'available'), (2, 'B2', 'available'), (2, 'B3', 'available');
