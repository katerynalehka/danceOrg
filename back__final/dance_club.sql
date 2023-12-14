-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:8889
-- Время создания: Май 01 2023 г., 18:32
-- Версия сервера: 5.7.34
-- Версия PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `dance_club`
--

-- --------------------------------------------------------

--
-- Структура таблицы `club`
--

CREATE TABLE `club` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `coach_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `club`
--

INSERT INTO `club` (`id`, `title`, `city`, `coach_id`) VALUES
(1, 'Dance Academy', 'Lviv', 1),
(2, 'Step Up Dance', 'Kyiv', 2),
(3, 'Dance Academy', 'Lviv', 3),
(4, 'Dance Academy', 'Lviv', 4),
(5, 'Step Up Dance', 'Kyiv', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `coach`
--

CREATE TABLE `coach` (
  `id` int(11) NOT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `club_name` varchar(200) DEFAULT NULL,
  `EDRPOU` varchar(45) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `coach`
--

INSERT INTO `coach` (`id`, `full_name`, `email`, `password`, `club_name`, `EDRPOU`, `city`) VALUES
(1, 'John Smith', 'johnsmith@gmail.com', '$2y$10$YFyA3rTBEa1dNfeDNdeRn.Jpi1B0UKIsH3bhqTkhLVU91kcuK8yfC', 'Dance Academy', '1234567890', 'Lviv'),
(2, 'Alice Johnson', 'alicej@gmail.com', '$2y$10$l25sDUR/f0mR5Z2BHkAMQec2lhXJ/VOD78woz5krgWjvuHBG52WEy', 'Step Up Dance', '0987654321', 'Kyiv'),
(3, 'Michael Brown', 'mikeb@gmail.com', '$2y$10$e/HQkNoDyn5BIST58IlXf.96yHtWdSPiQvojYFEv8O67NDODVvaXW', 'Dance Academy', '1357924680', 'Lviv'),
(4, 'Emily Davis', 'emilyd@gmail.com', '$2y$10$afDack25VGS0dG8vH28c4ujEM4WxxNl7nmFvm41wpE6xFmOETNYNm', 'Dance Academy', '2468013579', 'Lviv'),
(5, 'William Lee', 'wlee@gmail.com', '$2y$10$a9z00TljccwTHHHXeNuxceCfjCk8dBSGCy8HhBP4pspOvOLf35xja', 'Step Up Dance', '9876543210', 'Kyiv');

--
-- Триггеры `coach`
--
DELIMITER $$
CREATE TRIGGER `insert_into_club` AFTER INSERT ON `coach` FOR EACH ROW BEGIN
    INSERT INTO dance_club.club (title, city, coach_id)
    VALUES (NEW.club_name, NEW.city, NEW.id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `competition`
--

CREATE TABLE `competition` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `organizator_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `competition`
--

INSERT INTO `competition` (`id`, `title`, `date`, `location`, `description`, `organizator_id`) VALUES
(1, 'Dance Challenge 2023', '12.08.2023', 'New York City', 'An annual dance competition for all ages and styles', 1),
(2, 'International Latin Dance Cup', '23.09.2023', 'Miami Beach', 'A prestigious competition for Latin dancers from around the world', 1),
(3, 'Hip Hop Jam', '15.07.2023', 'Los Angeles', 'A showcase of the best hip hop dancers in the country', 1),
(4, 'Classic Ballroom Open', '14.10.2023', 'Chicago', 'A celebration of traditional ballroom dancing', 1),
(5, 'Breakout Battle', '11.11.2023', 'San Francisco', 'A competition for breakdancers of all ages', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `couples`
--

CREATE TABLE `couples` (
  `id` int(11) NOT NULL,
  `dancer_id1` int(11) NOT NULL,
  `dancer_id2` int(11) NOT NULL,
  `age_category` varchar(200) DEFAULT NULL,
  `class` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `couples`
--

INSERT INTO `couples` (`id`, `dancer_id1`, `dancer_id2`, `age_category`, `class`) VALUES
(1, 1, 2, 'Ювенали 1', 'Hobby'),
(2, 3, 4, 'Ювенали 1', 'E'),
(3, 5, 6, 'Молодь', 'D');

-- --------------------------------------------------------

--
-- Структура таблицы `dancer`
--

CREATE TABLE `dancer` (
  `id` int(11) NOT NULL,
  `first_name` varchar(200) DEFAULT NULL,
  `second_name` varchar(200) DEFAULT NULL,
  `age_category` varchar(200) DEFAULT NULL,
  `class` varchar(45) DEFAULT NULL,
  `coach_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `dancer`
--

INSERT INTO `dancer` (`id`, `first_name`, `second_name`, `age_category`, `class`, `coach_id`) VALUES
(1, 'Sarah', 'Taylor', 'Ювенали 1', 'Hobby', 1),
(2, 'Adam', 'Lee', 'Ювенали 2', 'Hobby', 1),
(3, 'Olivia', 'Brown', 'Ювенали 1', 'E', 1),
(4, 'Ben', 'Smith', 'Ювенали 2', 'E', 1),
(5, 'Sophie', 'Davis', 'Молодь', 'D', 1),
(6, 'Oleh', 'Orenchuk', 'Молодь', 'D', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `organizator`
--

CREATE TABLE `organizator` (
  `id` int(11) NOT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `company_name` varchar(200) DEFAULT NULL,
  `EDRPOU` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `organizator`
--

INSERT INTO `organizator` (`id`, `full_name`, `email`, `password`, `company_name`, `EDRPOU`) VALUES
(1, 'Mark Johnson', 'markj@gmail.com', '$2y$10$QhLzodS925Yjtje0.9LD.OM6a2FbQggkiVGMqRLvIBehbpvmDt3OG', 'ABC Events', '1357902468');

-- --------------------------------------------------------

--
-- Структура таблицы `results`
--

CREATE TABLE `results` (
  `competition_id` int(11) NOT NULL,
  `couples_id` int(11) NOT NULL,
  `win_place` int(11) DEFAULT NULL,
  `couples_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `results`
--

INSERT INTO `results` (`competition_id`, `couples_id`, `win_place`, `couples_number`) VALUES
(1, 1, 2, 12),
(1, 2, 4, 24),
(1, 3, 1, 21),
(2, 1, 1, 16),
(2, 2, 6, 30),
(2, 3, 2, 45),
(3, 1, 1, 49),
(3, 2, 2, 12),
(3, 3, 3, 18),
(4, 1, 1, 22),
(4, 2, 4, 95),
(4, 3, 7, 28),
(5, 1, 2, 8),
(5, 2, 1, 20),
(5, 3, 4, 16);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `club`
--
ALTER TABLE `club`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dance_club_coach1` (`coach_id`);

--
-- Индексы таблицы `coach`
--
ALTER TABLE `coach`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Индексы таблицы `competition`
--
ALTER TABLE `competition`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_competition_organizator1` (`organizator_id`);

--
-- Индексы таблицы `couples`
--
ALTER TABLE `couples`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_competition_has_couples_dancer1` (`dancer_id1`),
  ADD KEY `fk_competition_has_couples_dancer2` (`dancer_id2`);

--
-- Индексы таблицы `dancer`
--
ALTER TABLE `dancer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dancer_coach` (`coach_id`);

--
-- Индексы таблицы `organizator`
--
ALTER TABLE `organizator`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Индексы таблицы `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`competition_id`,`couples_id`),
  ADD KEY `fk_competition_has_couples1_couples1` (`couples_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `club`
--
ALTER TABLE `club`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `coach`
--
ALTER TABLE `coach`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `competition`
--
ALTER TABLE `competition`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `couples`
--
ALTER TABLE `couples`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `dancer`
--
ALTER TABLE `dancer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `organizator`
--
ALTER TABLE `organizator`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `club`
--
ALTER TABLE `club`
  ADD CONSTRAINT `fk_dance_club_coach1` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `competition`
--
ALTER TABLE `competition`
  ADD CONSTRAINT `fk_competition_organizator1` FOREIGN KEY (`organizator_id`) REFERENCES `organizator` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `couples`
--
ALTER TABLE `couples`
  ADD CONSTRAINT `fk_competition_has_couples_dancer1` FOREIGN KEY (`dancer_id1`) REFERENCES `dancer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competition_has_couples_dancer2` FOREIGN KEY (`dancer_id2`) REFERENCES `dancer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `dancer`
--
ALTER TABLE `dancer`
  ADD CONSTRAINT `fk_dancer_coach` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `fk_competition_has_couples1_competition1` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_competition_has_couples1_couples1` FOREIGN KEY (`couples_id`) REFERENCES `couples` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
