-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.30-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para ejercicios_procedimientos
CREATE DATABASE IF NOT EXISTS `ejercicios_procedimientos` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ejercicios_procedimientos`;

-- Volcando estructura para procedimiento ejercicios_procedimientos.actualizarCasa
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCasa`(IN `cod` INT(5), IN `desp` VARCHAR(30), IN `cost` FLOAT, IN `zon` VARCHAR(6))
begin
	update casa set descripcion=desp, costo=cost, zona=zon where codigo=cod;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.actualizarEmpleado
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEmpleado`(IN `ced` INT(10), IN `nom` VARCHAR(50), IN `ht` INT(5), IN `vh` FLOAT)
begin
	update empleado set nombre=nom, horas_trabajadas=ht, valor_hora=vh where cedula=ced;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.actualizarEmpleado2
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEmpleado2`(IN `ced` INT(10), IN `nom` VARCHAR(50), IN `sb` FLOAT)
begin
	update empleado2 set nombre=nom, salario_basico=sb where cedula=ced;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.actualizarMatricula
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarMatricula`(IN `cod` INT(10), IN `val` FLOAT, IN `pl` VARCHAR(30))
begin
	update matricula set valor=val, plan=pl where codigo=cod;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.actualizarTelevisor
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarTelevisor`(IN `cod` INT, IN `cost` FLOAT, IN `p_ganancia` FLOAT)
begin
	update televisor set costo=cost, porc_ganancia=p_ganancia where codigo=cod;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.borrarCasa
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrarCasa`(IN `cod` INT(10))
begin 
	delete from casa where codigo=cod;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.borrarEmpleado
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrarEmpleado`(
	IN `ced` INT(10)
)
begin 
	delete from empleado where cedula=ced;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.borrarEmpleado2
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrarEmpleado2`(
	IN `ced` INT(10)
)
begin 
	delete from empleado2 where cedula=ced;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.borrarMatricula
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrarMatricula`(IN `ced` INT(10))
begin 
	delete from matricula where cedula=ced;
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.borrarTelevisor
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrarTelevisor`(IN `cod` INT(10))
begin 
	delete from televisor where codigo=cod;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularBono
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularBono`(`horas_trabajadas` INT) RETURNS float
begin
declare ht float default 0;
	if horas_trabajadas >100 then
	set ht=200000;
	return ht;
	else
		if horas_trabajadas<100 then
		set ht=0;
		return ht;
		end if;
	end if;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularBonoEmpleado
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularBonoEmpleado`(`salario_basico` FLOAT) RETURNS float
begin
	declare b float default 0;
	set b= salario_basico*0.08;
	return b;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularGanancia
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularGanancia`(`costo` FLOAT, `porc_ganancia` FLOAT) RETURNS float
begin
	declare gan float default 0;
	set gan= costo * porc_ganancia/100;
	return gan;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularImpuesto
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularImpuesto`(`costo` FLOAT) RETURNS float
begin
	declare imp float default 0;
	set imp= costo*0.12;
	return imp;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularImpuestoAnualCasa
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularImpuestoAnualCasa`(`costo` FLOAT) RETURNS float
begin
	declare imp float default 0;
	set imp= costo*0.01;
	return imp;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularIva
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularIva`(`costo` FLOAT) RETURNS float
begin
	declare imp float default 0;
	set imp= costo*0.16;
	return imp;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularPension
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularPension`(`horas_trabajadas` INT(5), `valor_hora` FLOAT) RETURNS float
begin
	declare p float default 0;
	set p= calcularSalarioBruto(horas_trabajadas, valor_hora) * 0.04;
	return p;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularPensionEmpleado
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularPensionEmpleado`(`salario_basico` FLOAT) RETURNS float
begin
	declare p float default 0;
	set p= salario_basico*0.04;
	return p;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularSalarioBruto
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularSalarioBruto`(`horas_trabajadas` INT(5), `valor_hora` FLOAT) RETURNS float
begin
	declare sb float default 0;
	set sb= (horas_trabajadas * valor_hora) *30;
	return sb;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularSalarioIntegral
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularSalarioIntegral`(`salario_basico` FLOAT) RETURNS float
begin
	declare si float default 0;
	set si= salario_basico - calcularSaludEmpleado(salario_basico) - calcularPensionEmpleado(salario_basico)
				+ calcularBonoEmpleado(salario_basico) + calcularSubsidioTransporte(salario_basico);
	return si;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularSalarioNeto
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularSalarioNeto`(`horas_trabajadas` INT(5), `valor_hora` FLOAT) RETURNS float
begin
	declare sn float default 0;
	set sn= calcularSalarioBruto(horas_trabajadas, valor_hora) - calcularSalud(horas_trabajadas, valor_hora) - 
				calcularPension(horas_trabajadas, valor_hora) + calcularBono(horas_trabajadas) + 65000;
	return sn;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularSalud
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularSalud`(`horas_trabajadas` INT(5), `valor_hora` FLOAT) RETURNS float
begin
	declare p float default 0;
	set p= calcularSalarioBruto(horas_trabajadas, valor_hora) * 0.04;
	return p;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularSaludEmpleado
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularSaludEmpleado`(`salario_basico` FLOAT) RETURNS float
begin
	declare s float default 0;
	set s= salario_basico*0.04;
	return s;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularSubsidioTransporte
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularSubsidioTransporte`(`salario_basico` FLOAT) RETURNS float
begin
	declare st float default 0;
	set st= salario_basico*0.07;
	return st;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularValorRealmatricula
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularValorRealmatricula`(`valor` FLOAT, `plan` VARCHAR(20)) RETURNS float
begin
	declare vreal float default 0;
	if plan='pronto' then
	set vreal= valor - (valor*0.10);
	return vreal;
	else
		if plan='ordinaria' then
		set vreal= valor;
		return vreal;
		else
			if plan='extraordinaria' then
			set vreal= valor + (valor*0.20);
			return vreal;
			else 
				if plan='extemporanea' then
				set vreal= valor + (valor*0.25);
				return vreal;
				end if;
			end if;
		end if;
	end if;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularValorVenta
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularValorVenta`(`costo` FLOAT, `porc_ganancia` FLOAT) RETURNS float
begin
	declare vv float default 0;
	set vv= costo + calcularGanancia(costo, porc_ganancia) + calcularIva(costo);
	return vv;
end//
DELIMITER ;

-- Volcando estructura para función ejercicios_procedimientos.calcularValorVentacasa
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `calcularValorVentacasa`(`costo` FLOAT, `zona` VARCHAR(6)) RETURNS float
begin
	declare vv float default 0;
	if zona='urbana' then
	set vv=costo + (costo*0.25);
	return vv;
	else 
		if zona='rural' then
		set vv=costo + (costo*0.15);
		return vv;
	end if;
	end if;
end//
DELIMITER ;

-- Volcando estructura para tabla ejercicios_procedimientos.casa
CREATE TABLE IF NOT EXISTS `casa` (
  `codigo` int(5) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `costo` float NOT NULL,
  `zona` varchar(6) NOT NULL,
  `impuesto_anual` float NOT NULL,
  `valor_venta` float NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejercicios_procedimientos.casa: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `casa` DISABLE KEYS */;
INSERT INTO `casa` (`codigo`, `descripcion`, `costo`, `zona`, `impuesto_anual`, `valor_venta`) VALUES
	(10, 'Casa pequeÃ±a', 65000000, 'Urbana', 650000, 81250000),
	(17, 'Casa ubicada en un buen barrio residencial, cuenta', 150000000, 'Urbana', 1500000, 187500000),
	(20, 'Finca Cafetera', 200000000, 'Rural', 2000000, 230000000);
/*!40000 ALTER TABLE `casa` ENABLE KEYS */;

-- Volcando estructura para tabla ejercicios_procedimientos.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `cedula` int(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `horas_trabajadas` int(5) NOT NULL,
  `valor_hora` float NOT NULL,
  `salario_bruto` float NOT NULL,
  `salud` float NOT NULL,
  `pension` float NOT NULL,
  `bono` float NOT NULL,
  `salario_neto` float NOT NULL,
  PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejercicios_procedimientos.empleado: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` (`cedula`, `nombre`, `horas_trabajadas`, `valor_hora`, `salario_bruto`, `salud`, `pension`, `bono`, `salario_neto`) VALUES
	(3835889, 'Edilberto Ortega Vivero', 80, 2500, 6000000, 240000, 240000, 0, 5585000),
	(1005646920, 'Juan David Vital Arias', 30, 5000, 4500000, 180000, 180000, 0, 4205000),
	(1094267608, 'stefania afanador ortega', 8, 12000, 2880000, 115200, 115200, 0, 2714600);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;

-- Volcando estructura para tabla ejercicios_procedimientos.empleado2
CREATE TABLE IF NOT EXISTS `empleado2` (
  `cedula` int(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `salario_basico` float NOT NULL,
  `subsidio_transporte` float NOT NULL,
  `salud` float NOT NULL,
  `pension` float NOT NULL,
  `bono` float NOT NULL,
  `salario_integral` float NOT NULL,
  PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejercicios_procedimientos.empleado2: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `empleado2` DISABLE KEYS */;
INSERT INTO `empleado2` (`cedula`, `nombre`, `salario_basico`, `subsidio_transporte`, `salud`, `pension`, `bono`, `salario_integral`) VALUES
	(22835678, 'Maria Bernarda Ortega Vivero', 1000000, 70000, 40000, 40000, 80000, 1070000),
	(1090456638, 'Ismael Enrique Afanador', 4500000, 315000, 180000, 180000, 360000, 4815000),
	(1094267608, 'stefania afanador', 2500000, 175000, 100000, 100000, 200000, 2675000);
/*!40000 ALTER TABLE `empleado2` ENABLE KEYS */;

-- Volcando estructura para procedimiento ejercicios_procedimientos.guardarCasa
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardarCasa`(
	IN `descripcion` VARCHAR(50),
	IN `costo` FLOAT,
	IN `zona` VARCHAR(6)
)
begin 
	insert into casa (descripcion, costo, zona, impuesto_anual, valor_venta) values (descripcion, costo, zona, calcularImpuestoAnualCasa(costo), 
										calcularValorVentacasa(costo, zona));
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.guardarEmpleado
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardarEmpleado`(IN `cedula` INT(10), IN `nombre` VARCHAR(50), IN `horas_trabajadas` INT(5), IN `valor_hora` FLOAT)
begin
	insert into empleado values (cedula, nombre, horas_trabajadas, valor_hora, 
											calcularSalarioBruto(horas_trabajadas, valor_hora), 
											calcularSalud(horas_trabajadas, valor_hora),
											calcularPension(horas_trabajadas, valor_hora),
											calcularBono(horas_trabajadas),
											calcularSalarioNeto(horas_trabajadas, valor_hora));

end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.guardarEmpleado2
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardarEmpleado2`(IN `cedula` INT(10), IN `nombre` VARCHAR(50), IN `salario_basico` FLOAT)
begin
	insert into empleado2 values (cedula, nombre, salario_basico, calcularSubsidioTransporte(salario_basico),
	calcularSaludEmpleado(salario_basico), calcularPensionEmpleado(salario_basico), calcularBonoEmpleado(salario_basico),
	calcularSalarioIntegral(salario_basico));
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.guardarMatricula
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardarMatricula`(IN `codigo` INT, IN `valor` FLOAT, IN `plan` VARCHAR(20))
begin
	insert into matricula values (codigo, valor, plan, calcularValorRealmatricula(valor, plan));
end//
DELIMITER ;

-- Volcando estructura para procedimiento ejercicios_procedimientos.guardarTelevisor
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `guardarTelevisor`(
	IN `costo` FLOAT,
	IN `porc_ganancia` FLOAT

)
begin
	insert into televisor (costo, porc_ganancia, impuesto, ganancia, iva, valor_venta) values (costo, porc_ganancia, calcularImpuesto(costo), 
											calcularGanancia(costo, porc_ganancia), calcularIva(costo), 
											calcularValorVenta(costo, porc_ganancia));
end//
DELIMITER ;

-- Volcando estructura para tabla ejercicios_procedimientos.matricula
CREATE TABLE IF NOT EXISTS `matricula` (
  `codigo` int(10) NOT NULL,
  `valor` float NOT NULL,
  `plan` varchar(20) NOT NULL,
  `valor_real` float NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejercicios_procedimientos.matricula: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `matricula` DISABLE KEYS */;
INSERT INTO `matricula` (`codigo`, `valor`, `plan`, `valor_real`) VALUES
	(3835889, 1895000, 'pronto', 1705500),
	(225643321, 900000, 'extraordinaria', 1080000),
	(1005425955, 1899000, 'pronto', 1709100),
	(1005646715, 2348900, 'extemporanea', 2936120),
	(1005646729, 2459000, 'pronto', 2213100),
	(1005646739, 2459000, 'extraordinaria', 2950800),
	(1094267608, 2000000, 'ordinaria', 2000000),
	(1094267610, 2800000, 'pronto', 2520000),
	(1094267611, 1800000, 'extraordinaria', 2160000);
/*!40000 ALTER TABLE `matricula` ENABLE KEYS */;

-- Volcando estructura para tabla ejercicios_procedimientos.televisor
CREATE TABLE IF NOT EXISTS `televisor` (
  `codigo` int(5) NOT NULL AUTO_INCREMENT,
  `costo` float NOT NULL,
  `porc_ganancia` float NOT NULL,
  `impuesto` float NOT NULL,
  `ganancia` float NOT NULL,
  `iva` float NOT NULL,
  `valor_venta` float NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla ejercicios_procedimientos.televisor: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `televisor` DISABLE KEYS */;
INSERT INTO `televisor` (`codigo`, `costo`, `porc_ganancia`, `impuesto`, `ganancia`, `iva`, `valor_venta`) VALUES
	(1, 66550, 30, 7986, 19965, 10648, 97163),
	(2, 45000, 20, 5400, 9000, 7200, 61200),
	(3, 57850, 29, 6942, 16776.5, 9256, 83882.5),
	(4, 450500, 20, 54060, 90100, 72080, 612680),
	(5, 109800, 34, 13176, 37332, 17568, 164700),
	(6, 2900000, 10, 348000, 290000, 464000, 3654000),
	(7, 100000, 19, 12000, 19000, 16000, 135000),
	(8, 450000, 10, 54000, 45000, 72000, 567000);
/*!40000 ALTER TABLE `televisor` ENABLE KEYS */;

-- Volcando estructura para disparador ejercicios_procedimientos.actualizarDatosCasa
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `actualizarDatosCasa` BEFORE UPDATE ON `casa` FOR EACH ROW begin
	set new.impuesto_anual= calcularImpuestoAnualCasa(new.costo);
	set new.valor_venta= calcularValorVentacasa(new.costo, new.zona);
end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ejercicios_procedimientos.actualizarDatosEmpleado
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `actualizarDatosEmpleado` BEFORE UPDATE ON `empleado` FOR EACH ROW begin
	set new.salario_bruto= calcularSalarioBruto(new.horas_trabajadas, new.valor_hora);
	set new.salud= calcularSalud(new.horas_trabajadas, new.valor_hora);
	set new.pension= calcularPension(new.horas_trabajadas, new.valor_hora);
	set new.bono= calcularBono(new.horas_trabajadas);
	set new.salario_neto= calcularSalarioNeto(new.horas_trabajadas, new.valor_hora);
end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ejercicios_procedimientos.actualizarDatosMatricula
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `actualizarDatosMatricula` BEFORE UPDATE ON `matricula` FOR EACH ROW begin
	set new.valor_real= calcularValorRealmatricula(new.valor, new.plan);
end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ejercicios_procedimientos.actualizarDatosTelevisor
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `actualizarDatosTelevisor` BEFORE UPDATE ON `televisor` FOR EACH ROW begin 
	set new.impuesto= calcularImpuesto(new.costo);
	set new.ganancia= calcularGanancia(new.costo, new.porc_ganancia);
	set new.iva= calcularIva(new.costo); 
	set new.valor_venta= calcularValorVenta(new.costo, new.porc_ganancia);
end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ejercicios_procedimientos.actualizarEmpleado2
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `actualizarEmpleado2` BEFORE UPDATE ON `empleado2` FOR EACH ROW begin
	set new.subsidio_transporte= calcularSubsidioTransporte(new.salario_basico);
	set new.salud= calcularSaludEmpleado(new.salario_basico);
	set new.pension= calcularPensionEmpleado(new.salario_basico);
	set new.bono= calcularBonoEmpleado(new.salario_basico);
	set new.salario_integral= calcularSalarioIntegral(new.salario_basico);
end//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
