CREATE TABLE IF NOT EXISTS `elite_houses` (
  `id` varchar(10) DEFAULT NULL,
  `owner` longtext DEFAULT NULL,
  `interior` longtext DEFAULT '',
  `positions` longtext DEFAULT '',
  `furnish` longtext DEFAULT '{}',
  `data` longtext DEFAULT '{}',
  `garage` longtext DEFAULT '[]',
  `inventory` longtext DEFAULT NULL,
  KEY `Índice 1` (`id`)
);

INSERT INTO `jobs` (name, label) VALUES
  ('dynasty', 'Dynasty8');

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('dynasty', 0, 'empleado', 'Empleado', 20, '{}', '{}');

ALTER TABLE `users`
  ADD COLUMN `UltimaCasa` VARCHAR(255) NULL;