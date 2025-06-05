CREATE DATABASE IF NOT EXISTS airline DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE airline;

CREATE TABLE IF NOT EXISTS flights (
  flight_id INT NOT NULL AUTO_INCREMENT,
  airline VARCHAR(255) DEFAULT NULL,
  origin VARCHAR(255) DEFAULT NULL,
  destination VARCHAR(255) DEFAULT NULL,
  departure_time DATETIME DEFAULT NULL,
  arrival_time DATETIME DEFAULT NULL,
  price DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (flight_id)
);

INSERT INTO flights (airline, origin, destination, departure_time, arrival_time, price) VALUES
('Airline A', 'New York', 'Los Angeles', '2022-01-01 12:00:00', '2022-01-01 15:00:00', 250.00),
('Airline B', 'New York', 'Paris', '2022-01-02 08:00:00', '2022-01-02 18:00:00', 450.00);

CREATE TABLE IF NOT EXISTS reservations (
  reservation_id INT NOT NULL AUTO_INCREMENT,
  flight_id INT DEFAULT NULL,
  customer_name VARCHAR(255) DEFAULT NULL,
  seat_number VARCHAR(5) DEFAULT NULL,
  reservation_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (reservation_id),
  FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4_0900_ai_ci;

-- sample reservation (use actual flight_id valures from python or SELECT query)
-- if your're not sure what flight_id is, you can select them first  
INSERT INTO reservation (flight_id, custormer_name, seat_number, reservation_time) VALUES 
  (1,'Jonh Doe','A1','2024-01-16 05:21:58')
  (2,'Jane Smith','B2','2024-01-16 05:21:58')
  (1,'Jonh Doe','A1','2024-01-16 05:22:58')
  (1,'Jane Smith','B2','2024-01-16 05:22:58')
  (1,'Mike Brown','C3','2024-01-16 05:23:30')
  (1, 'Vaibhav Srivastava','A1',NULL)
  -- Create the seats table
CREATE TABLE IF NOT EXISTS seats (
  seat_id INT NOT NULL AUTO_INCREMENT,
  flight_id INT DEFAULT NULL,
  seat_number VARCHAR(5) DEFAULT NULL,
  status ENUM('available','reserved','sold') DEFAULT NULL,
  PRIMARY KEY (seat_id),
  KEY flight_id (flight_id)
) ENGINE = InnoDb DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--Insert seats (link them to the correct flight_id)
INSERT INTO seats (flight_id, seat_number, status) VALUES
(1, 'A1', 'reserved'), (1, 'A2', 'available'), (1, 'A3', 'available'),
(1, 'B1', 'available'), (1, 'B2', 'available'), (1, 'B3', 'available'),
(2, 'A1', 'available'), (2, 'A2', 'available'), (2, 'A3', 'available'),
(2, 'B1', 'available'), (2, 'B2', 'available'), (2, 'B3', 'available');
