CREATE TABLE `case` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `priority` VARCHAR(255) NOT NULL
);

CREATE TABLE `module` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `last_run` DATE,
  `total_cases` INTEGER,
  `name` VARCHAR(255) NOT NULL,
  `total_checklists` INTEGER
);

CREATE TABLE `checklist` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `module` INTEGER NOT NULL
);

CREATE INDEX `idx_checklist__module` ON `checklist` (`module`);

ALTER TABLE `checklist` ADD CONSTRAINT `fk_checklist__module` FOREIGN KEY (`module`) REFERENCES `module` (`id`) ON DELETE CASCADE;

CREATE TABLE `case_checklist` (
  `case` INTEGER NOT NULL,
  `checklist` INTEGER NOT NULL,
  PRIMARY KEY (`case`, `checklist`)
);

CREATE INDEX `idx_case_checklist` ON `case_checklist` (`checklist`);

ALTER TABLE `case_checklist` ADD CONSTRAINT `fk_case_checklist__case` FOREIGN KEY (`case`) REFERENCES `case` (`id`);

ALTER TABLE `case_checklist` ADD CONSTRAINT `fk_case_checklist__checklist` FOREIGN KEY (`checklist`) REFERENCES `checklist` (`id`);

CREATE TABLE `testrun` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `module` INTEGER NOT NULL
);

CREATE INDEX `idx_testrun__module` ON `testrun` (`module`);

ALTER TABLE `testrun` ADD CONSTRAINT `fk_testrun__module` FOREIGN KEY (`module`) REFERENCES `module` (`id`) ON DELETE CASCADE;

CREATE TABLE `runcase` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `case` INTEGER NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `comment` VARCHAR(255) NOT NULL,
  `test_run` INTEGER NOT NULL
);

CREATE INDEX `idx_runcase__case` ON `runcase` (`case`);

CREATE INDEX `idx_runcase__test_run` ON `runcase` (`test_run`);

ALTER TABLE `runcase` ADD CONSTRAINT `fk_runcase__case` FOREIGN KEY (`case`) REFERENCES `case` (`id`) ON DELETE CASCADE;

ALTER TABLE `runcase` ADD CONSTRAINT `fk_runcase__test_run` FOREIGN KEY (`test_run`) REFERENCES `testrun` (`id`) ON DELETE CASCADE