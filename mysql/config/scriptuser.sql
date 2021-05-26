CREATE USER IF NOT EXISTS 'as02'@'%' IDENTIFIED BY 'impacta2021';

CREATE DATABASE IF NOT EXISTS impacta;

ALTER DATABASE impacta
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON impacta.* TO 'as02'@'%' IDENTIFIED BY 'impacta2021';