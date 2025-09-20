-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-09-2025 a las 22:45:23
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tejobar`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apartados`
--

CREATE TABLE `apartados` (
  `idApartado` int(11) NOT NULL,
  `idPersona` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fechaApartado` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('pendiente','comprado') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancha`
--

CREATE TABLE `cancha` (
  `idCancha` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `disponibilidad` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cancha`
--

INSERT INTO `cancha` (`idCancha`, `estado`, `disponibilidad`) VALUES
(1, 1, 'Disponible'),
(2, 1, 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `idCompra` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `total` double DEFAULT NULL,
  `idJugador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`idCompra`, `fecha`, `total`, `idJugador`) VALUES
(1, '2025-07-15', 28000, 101),
(2, '2025-07-16', 37500, 102),
(3, '2025-07-17', 56000, 103);

--
-- Disparadores `compra`
--
DELIMITER $$
CREATE TRIGGER `asignar_fecha_compra` BEFORE INSERT ON `compra` FOR EACH ROW BEGIN
  SET NEW.fecha = CURDATE();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

CREATE TABLE `equipo` (
  `idEquipo` int(11) NOT NULL,
  `nombreEquipo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`idEquipo`, `nombreEquipo`) VALUES
(1, 'Equipo A'),
(2, 'Equipo B'),
(3, 'Equipo C');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `idPersona` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `rut` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`idPersona`, `estado`, `rut`) VALUES
(101, 1, 'RUT101'),
(102, 1, 'RUT102'),
(103, 1, 'RUT103'),
(105, 1, 'RUT105');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador_equipo`
--

CREATE TABLE `jugador_equipo` (
  `idJugador` int(11) NOT NULL,
  `idEquipo` int(11) NOT NULL,
  `esCapitan` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `jugador_equipo`
--

INSERT INTO `jugador_equipo` (`idJugador`, `idEquipo`, `esCapitan`) VALUES
(101, 1, 1),
(102, 2, 1),
(103, 3, 1),
(105, 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partido`
--

CREATE TABLE `partido` (
  `idPartido` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` varchar(20) NOT NULL,
  `capitan` varchar(100) NOT NULL,
  `cancha` int(11) NOT NULL,
  `estado` enum('Pendiente','Confirmada','Cancelada') NOT NULL DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `partido`
--

INSERT INTO `partido` (`idPartido`, `fecha`, `hora`, `capitan`, `cancha`, `estado`) VALUES
(1, '2025-07-24', '10:00-12:00 AM', 'Felipe Parra', 1, 'Confirmada'),
(2, '2025-07-24', '10:00-12:00 AM', 'Kevin Franco', 2, 'Confirmada'),
(3, '2025-06-25', '08:00-10:00 AM', 'Andres Ibarra', 1, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contrasena` varchar(100) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `rol` enum('jugador','capitan','admin') NOT NULL DEFAULT 'jugador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `nombre`, `correo`, `contrasena`, `numero`, `rol`) VALUES
(101, 'Jugador', 'jugador@gmail.com', '1234', '3001234567', 'jugador'),
(102, 'Capitan', 'capitan@gmail.com', '1234', '3001234568', 'capitan'),
(103, 'Andres Ibarra', 'andres@example.com', '1234', '3001234569', 'jugador'),
(104, 'Andres Cardona', 'andres.cardona@example.com', 'admin2025', '3001234570', 'admin'),
(105, 'admin', 'admin@gmail.com', '1234', '3001234567', 'admin');

--
-- Disparadores `persona`
--
DELIMITER $$
CREATE TRIGGER `correo_unico_persona` BEFORE INSERT ON `persona` FOR EACH ROW BEGIN
  IF EXISTS(SELECT 1 FROM persona WHERE correo = NEW.correo) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo ya existe.';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `fechaVencimiento` date DEFAULT NULL,
  `urlImg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `nombre`, `precio`, `stock`, `fechaVencimiento`, `urlImg`) VALUES
(1, 'Cerveza Artesanal', 9680, 50, '2025-12-31', 'cerveza.jpg'),
(2, 'Salchipapa', 12000, 40, '2025-12-31', 'salchipapa.jpg'),
(3, 'Picada', 25000, 30, '2025-12-31', 'picada.jpg'),
(4, 'Empanadas x5', 7000, 60, '2025-12-31', 'empanadas.png'),
(5, 'Refresco', 2500, 100, '2025-12-31', 'refrescos.jpg'),
(6, 'Aguardiente Antioqueño', 35000, 25, '2025-12-31', 'aguardiente.jpg');

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `nombre_producto_mayusculas` BEFORE INSERT ON `producto` FOR EACH ROW BEGIN
  SET NEW.nombre = UPPER(NEW.nombre);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `validar_precio_producto` BEFORE INSERT ON `producto` FOR EACH ROW BEGIN
  IF NEW.precio < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio no puede ser negativo.';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `torneo`
--

CREATE TABLE `torneo` (
  `idPartido` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `equipo1` int(11) DEFAULT NULL,
  `equipo2` int(11) DEFAULT NULL,
  `cancha` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `torneo`
--

INSERT INTO `torneo` (`idPartido`, `fecha`, `equipo1`, `equipo2`, `cancha`) VALUES
(1, '2025-07-24 10:00:00', 1, 2, 1),
(2, '2025-07-24 10:00:00', 2, 3, 2),
(3, '2025-06-25 08:00:00', 3, 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `apartados`
--
ALTER TABLE `apartados`
  ADD PRIMARY KEY (`idApartado`),
  ADD KEY `idPersona` (`idPersona`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `cancha`
--
ALTER TABLE `cancha`
  ADD PRIMARY KEY (`idCancha`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `idJugador` (`idJugador`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`idEquipo`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`idPersona`);

--
-- Indices de la tabla `jugador_equipo`
--
ALTER TABLE `jugador_equipo`
  ADD PRIMARY KEY (`idJugador`,`idEquipo`),
  ADD KEY `idEquipo` (`idEquipo`);

--
-- Indices de la tabla `partido`
--
ALTER TABLE `partido`
  ADD PRIMARY KEY (`idPartido`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `torneo`
--
ALTER TABLE `torneo`
  ADD PRIMARY KEY (`idPartido`),
  ADD KEY `equipo1` (`equipo1`),
  ADD KEY `equipo2` (`equipo2`),
  ADD KEY `cancha` (`cancha`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `apartados`
--
ALTER TABLE `apartados`
  MODIFY `idApartado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cancha`
--
ALTER TABLE `cancha`
  MODIFY `idCancha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `idCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `idEquipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `partido`
--
ALTER TABLE `partido`
  MODIFY `idPartido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `torneo`
--
ALTER TABLE `torneo`
  MODIFY `idPartido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `apartados`
--
ALTER TABLE `apartados`
  ADD CONSTRAINT `apartados_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE CASCADE,
  ADD CONSTRAINT `apartados_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`idJugador`) REFERENCES `jugador` (`idPersona`);

--
-- Filtros para la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD CONSTRAINT `jugador_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `jugador_equipo`
--
ALTER TABLE `jugador_equipo`
  ADD CONSTRAINT `jugador_equipo_ibfk_1` FOREIGN KEY (`idJugador`) REFERENCES `jugador` (`idPersona`),
  ADD CONSTRAINT `jugador_equipo_ibfk_2` FOREIGN KEY (`idEquipo`) REFERENCES `equipo` (`idEquipo`);

--
-- Filtros para la tabla `torneo`
--
ALTER TABLE `torneo`
  ADD CONSTRAINT `torneo_ibfk_1` FOREIGN KEY (`equipo1`) REFERENCES `equipo` (`idEquipo`),
  ADD CONSTRAINT `torneo_ibfk_2` FOREIGN KEY (`equipo2`) REFERENCES `equipo` (`idEquipo`),
  ADD CONSTRAINT `torneo_ibfk_3` FOREIGN KEY (`cancha`) REFERENCES `cancha` (`idCancha`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
