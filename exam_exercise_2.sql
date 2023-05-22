-- Inserting data into units table

INSERT INTO units (unit_id, unit_name) VALUES
(1, 'unit 1'),
(2, 'unit 2'),
(3, 'unit 3'),
(4, 'unit 4'),
(5, 'unit 5'),
(6, 'unit 6'),
(7, 'unit 7'),
(8, 'unit 8'),
(9, 'unit 9'),
(10, 'unit 10');

-- Inserting data into employees table


INSERT INTO employees (employee_id, employee_name, employee_type, unit_id) VALUES
(1, 'Eero Kallio', 'officer', 1),
(2, 'Laura Salminen', 'paramedic', 2),
(3, 'Sari Rantanen', 'fire fighter', 3),
(4, 'Niklas Lindström', 'fire fighter', 4),
(5, 'Ville Korpela', 'fire fighter', 5),
(6, 'Anni Huhtala', 'paramedic', 6),
(7, 'Mikko Vainio', 'officer', 7),
(8, 'Tiina Ahonen', 'fire fighter', 8),
(9, 'Joonas Kärkkäinen', 'fire fighter', 9),
(10, 'Henna Laine', 'paramedic', 10);


-- Inserting data into vehicles table

INSERT INTO vehicles (vehicle_id, vehicle_type, unit_id) VALUES
(1, 'Engine', 1),
(2, 'Truck', 2),
(3, 'Ambulance', 3),
(4, 'Engine', 4),
(5, 'Engine', 5),
(6, 'Truck', 6),
(7, 'Ambulance', 7),
(8, 'Engine', 8),
(9, 'Ambulance', 9),
(10, 'Engine', 10);

-- Inserting data i nto missions table


INSERT INTO missions (mission_id, mission_type, mission_start, mission_end, mission_severity, mission_description, mission_location, unit_id)
VALUES (1, 'fire', '2023-03-23 12:00:00', '2023-03-23 17:00:00', 'High', 'Fire broke out in a residential building', '123 Oak St', 1),
       (2, 'fire','2023-03-23 14:00:00', '2023-03-23 17:00:00', 'Medium', 'Responded to a heart attack call',  '456 Maple St', 2),
       (3, 'Fire', '2022-03-13 10:00:00', '2022-03-13 11:30:00', 'High', 'Building on fire, multiple trapped', '123 Main St', 3),
	   (4, 'Medical', '2023-03-12 08:30:00', '2023-03-12 09:15:00', 'Low', 'Patient with minor injuries', '456 Oak Ave', 4),
	   (5, 'Fire', '2023-03-10 18:00:00', '2023-03-10 19:30:00', 'Medium', 'Car on fire on highway', '789 Elm St', 5),
	   (6, 'Fire Prevention', '2023-03-09 14:00:00', '2023-03-09 14:45:00', 'Low', 'Inspecton of building', '555 Pine St', 6),
	   (7, 'Fire', '2022-03-08 21:00:00', '2022-03-08 23:00:00', 'High', 'Apartment complex on fire', '987 Maple Ave', 7),
	   (8, 'Medical', '2023-03-07 11:00:00', '2023-03-07 12:30:00', 'Medium', 'Patient with broken leg', '444 Walnut St', 8),
	   (9, 'Fire', '2023-03-05 19:30:00', '2023-03-05 01:00:00', 'High', 'Wildfire in the forest', '321 Cedar Rd', 9),
       (10, 'Medical', '2023-03-05 19:30:00', '2023-03-05 01:00:00', 'High', 'Wildfire in the forest', '321 Cedar Rd', 10),
	   (11, 'Medical', '2023-03-04 16:00:00', '2023-03-04 16:45:00', 'Low', 'Patient with flu symptoms', '777 Oak Ave', 1),
	   (12, 'Fire', '2023-03-02 08:00:00', '2023-03-02 10:00:00', 'Medium', 'House fire', '222 Pine St', 2),
       (13, 'Medical', '2022-03-02 06:00:00', '2022-03-02 06:30:00', 'Medium', 'Patient with heart condition', '232 Grove St', 3),
       (14, 'Fire', '2023-03-05 19:30:00', '2023-03-05 01:00:00', 'High', 'Wildfire in the forest', '321 Cedar Rd', 5),
	   (15, 'Medical', '2023-03-10 18:00:00', '2023-03-10 19:30:00', 'Medium', 'Car on fire on highway', '789 Elm St', 2);