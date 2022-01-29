SET FOREIGN_KEY_CHECKS=0;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE `ACCOUNT_` (
  `NickName` varchar(40) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Domanda` char(120) NOT NULL,
  `Risposta` char(120) NOT NULL,
  `CF` varchar(30) NOT NULL,
  PRIMARY KEY (`NickName`),
  KEY `fk_ACCOUNT_UTENTE1_idx` (`CF`),
  CONSTRAINT `fk_ACCOUNT_UTENTE1` FOREIGN KEY (`CF`) REFERENCES `UTENTE` (`CodFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `ANALITYCS` (
  `Guasto` int NOT NULL,
  `Unita` int NOT NULL,
  `Rimedio` int NOT NULL,
  `Punteggio` double DEFAULT NULL,
  `Prodotto` varchar(45) NOT NULL,
  `E_p` double DEFAULT NULL,
  PRIMARY KEY (`Guasto`,`Unita`,`Rimedio`,`Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `AREA` (
  `CodArea` int NOT NULL,
  `Magazzino` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`CodArea`),
  KEY `fk_AREA_MAGAZZINO1_idx` (`Magazzino`),
  KEY `fk_AREA_PRODOTTO1_idx` (`Prodotto`),
  CONSTRAINT `fk_AREA_MAGAZZINO1` FOREIGN KEY (`Magazzino`) REFERENCES `MAGAZZINO` (`CodMagazzino`),
  CONSTRAINT `fk_AREA_PRODOTTO1` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `AVANZAMENTO` (
  `Spedizione` varchar(30) NOT NULL,
  `Citta` varchar(30) NOT NULL,
  `DataArrivo` datetime NOT NULL,
  PRIMARY KEY (`Spedizione`,`Citta`),
  KEY `fk_SPEDIZIONE_has_CITTA_CITTA1_idx` (`Citta`),
  KEY `fk_SPEDIZIONE_has_CITTA_SPEDIZIONE1_idx` (`Spedizione`),
  CONSTRAINT `fk_SPEDIZIONE_has_CITTA_CITTA1` FOREIGN KEY (`Citta`) REFERENCES `CITTA` (`CodCitta`),
  CONSTRAINT `fk_SPEDIZIONE_has_CITTA_SPEDIZIONE1` FOREIGN KEY (`Spedizione`) REFERENCES `SPEDIZIONE` (`CodSpedizione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `CARATTERISTICA` (
  `CodCaratteristica` int NOT NULL,
  `UnitaMisura` char(40) DEFAULT NULL,
  `Descrizione` char(40) DEFAULT NULL,
  PRIMARY KEY (`CodCaratteristica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `CARATTERIZZAZIONE` (
  `Caratteristica` int NOT NULL,
  `Giunzione` int NOT NULL,
  `Valore` int DEFAULT NULL,
  PRIMARY KEY (`Caratteristica`,`Giunzione`),
  KEY `fk_CARATTERISTICA_has_GIUNZIONE_GIUNZIONE1_idx` (`Giunzione`),
  KEY `fk_CARATTERISTICA_has_GIUNZIONE_CARATTERISTICA1_idx` (`Caratteristica`),
  CONSTRAINT `fk_CARATTERISTICA_has_GIUNZIONE_CARATTERISTICA1` FOREIGN KEY (`Caratteristica`) REFERENCES `CARATTERISTICA` (`CodCaratteristica`),
  CONSTRAINT `fk_CARATTERISTICA_has_GIUNZIONE_GIUNZIONE1` FOREIGN KEY (`Giunzione`) REFERENCES `GIUNZIONE` (`CodGiunzione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `CITTA` (
  `CodCitta` varchar(30) NOT NULL,
  `Nome` char(40) NOT NULL,
  `CAP` varchar(5) NOT NULL,
  `Importanza` int DEFAULT '0',
  PRIMARY KEY (`CodCitta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `CLASSE_GUASTO` (
  `CodClasse` int NOT NULL,
  `Nome` char(40) DEFAULT NULL,
  PRIMARY KEY (`CodClasse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `COD_ERRORE_RIMEDIO` (
  `Errore` varchar(30) NOT NULL,
  `Prodotto` int NOT NULL,
  `Guasto` int NOT NULL,
  `Rimedio` int NOT NULL,
  PRIMARY KEY (`Errore`,`Prodotto`,`Guasto`,`Rimedio`),
  KEY `fk_CODICE_ERRORE_has_RIMEDIO_RIMEDIO1_idx` (`Rimedio`),
  KEY `fk_CODICE_ERRORE_has_RIMEDIO_CODICE_ERRORE1_idx` (`Errore`,`Prodotto`,`Guasto`),
  CONSTRAINT `fk_CODICE_ERRORE_has_RIMEDIO_CODICE_ERRORE1` FOREIGN KEY (`Errore`, `Prodotto`, `Guasto`) REFERENCES `CODICE_ERRORE` (`CodErrore`, `Prodotto`, `Guasto`),
  CONSTRAINT `fk_CODICE_ERRORE_has_RIMEDIO_RIMEDIO1` FOREIGN KEY (`Rimedio`) REFERENCES `RIMEDIO` (`CodRimedio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `CODICE_ERRORE` (
  `CodErrore` varchar(30) NOT NULL,
  `Prodotto` int NOT NULL,
  `Guasto` int NOT NULL,
  PRIMARY KEY (`CodErrore`,`Prodotto`,`Guasto`),
  KEY `fk_CODICE_ERRORE_PRODOTTO1_idx` (`Prodotto`),
  KEY `fk_CODICE_ERRORE_GUASTO1_idx` (`Guasto`),
  CONSTRAINT `fk_CODICE_ERRORE_GUASTO1` FOREIGN KEY (`Guasto`) REFERENCES `GUASTO` (`CodGuasto`),
  CONSTRAINT `fk_CODICE_ERRORE_PRODOTTO1` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `COMPOSIZIONE` (
  `Materiale` int NOT NULL,
  `Parte` int NOT NULL,
  `Quantità` double DEFAULT NULL,
  PRIMARY KEY (`Materiale`,`Parte`),
  KEY `fk_MATERIALE_has_PARTE_PARTE1_idx` (`Parte`),
  KEY `fk_MATERIALE_has_PARTE_MATERIALE1_idx` (`Materiale`),
  CONSTRAINT `fk_MATERIALE_has_PARTE_MATERIALE1` FOREIGN KEY (`Materiale`) REFERENCES `MATERIALE` (`CodMateriale`),
  CONSTRAINT `fk_MATERIALE_has_PARTE_PARTE1` FOREIGN KEY (`Parte`) REFERENCES `PARTE` (`CodParte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `COPERTURA` (
  `ClasseGuasto` int NOT NULL,
  `Estensione` int NOT NULL,
  PRIMARY KEY (`ClasseGuasto`,`Estensione`),
  KEY `fk_CLASSE_GUASTO_has_ESTENSIONE_ESTENSIONE1_idx` (`Estensione`),
  KEY `fk_CLASSE_GUASTO_has_ESTENSIONE_CLASSE_GUASTO1_idx` (`ClasseGuasto`),
  CONSTRAINT `fk_CLASSE_GUASTO_has_ESTENSIONE_CLASSE_GUASTO1` FOREIGN KEY (`ClasseGuasto`) REFERENCES `CLASSE_GUASTO` (`CodClasse`),
  CONSTRAINT `fk_CLASSE_GUASTO_has_ESTENSIONE_ESTENSIONE1` FOREIGN KEY (`Estensione`) REFERENCES `ESTENSIONE` (`CodEstensione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `CRITERIO` (
  `CodCriterio` varchar(30) NOT NULL,
  `Nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CodCriterio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `DETTAGLIO` (
  `Unita` int NOT NULL,
  `Prodotto` int NOT NULL,
  `Ordine` varchar(20) NOT NULL,
  `Recensione` varchar(30) NOT NULL,
  PRIMARY KEY (`Unita`,`Prodotto`,`Ordine`,`Recensione`),
  KEY `fk_DETTAGLIO_ORDINE1_idx` (`Ordine`),
  KEY `fk_DETTAGLIO_RECENSIONE1_idx` (`Recensione`),
  CONSTRAINT `fk_DETTAGLIO_ORDINE1` FOREIGN KEY (`Ordine`) REFERENCES `ORDINE` (`CodOrdine`),
  CONSTRAINT `fk_DETTAGLIO_RECENSIONE1` FOREIGN KEY (`Recensione`) REFERENCES `RECENSIONE` (`CodRecensione`),
  CONSTRAINT `fk_DETTAGLIO_UNITA1` FOREIGN KEY (`Unita`, `Prodotto`) REFERENCES `UNITA` (`CodSeriale`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `DOCUMENTO` (
  `CodDocumento` int NOT NULL,
  `Tipologia` char(40) DEFAULT NULL,
  `Utente` varchar(30) NOT NULL,
  `DataScadenza` datetime DEFAULT NULL,
  `EnteRilascio` char(40) DEFAULT NULL,
  PRIMARY KEY (`CodDocumento`,`Utente`),
  KEY `fk_DOCUMENTO_UTENTE1_idx` (`Utente`),
  CONSTRAINT `fk_DOCUMENTO_UTENTE1` FOREIGN KEY (`Utente`) REFERENCES `UTENTE` (`CodFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `DOMANDA` (
  `CodDomanda` varchar(20) NOT NULL,
  `Descrizione` char(200) DEFAULT NULL,
  PRIMARY KEY (`CodDomanda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `ESTENSIONE` (
  `CodEstensione` int NOT NULL,
  `Prezzo` int DEFAULT NULL,
  PRIMARY KEY (`CodEstensione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `ESTENSIONE_PRODOTTO` (
  `Estensione` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`Estensione`,`Prodotto`),
  KEY `fk_ESTENSIONE_has_PRODOTTO_PRODOTTO1_idx` (`Prodotto`),
  KEY `fk_ESTENSIONE_has_PRODOTTO_ESTENSIONE1_idx` (`Estensione`),
  CONSTRAINT `fk_ESTENSIONE_has_PRODOTTO_ESTENSIONE1` FOREIGN KEY (`Estensione`) REFERENCES `ESTENSIONE` (`CodEstensione`),
  CONSTRAINT `fk_ESTENSIONE_has_PRODOTTO_PRODOTTO1` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `ESTENSIONE_UNITA` (
  `Estensione` int NOT NULL,
  `Unità` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`Estensione`,`Unità`,`Prodotto`),
  KEY `fk_ESTENSIONE_has_UNITA_UNITA1_idx` (`Unità`,`Prodotto`),
  KEY `fk_ESTENSIONE_has_UNITA_ESTENSIONE1_idx` (`Estensione`),
  CONSTRAINT `fk_ESTENSIONE_has_UNITA_ESTENSIONE1` FOREIGN KEY (`Estensione`) REFERENCES `ESTENSIONE` (`CodEstensione`),
  CONSTRAINT `fk_ESTENSIONE_has_UNITA_UNITA1` FOREIGN KEY (`Unità`, `Prodotto`) REFERENCES `UNITA` (`CodSeriale`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `FACCIA` (
  `CodFaccia` int NOT NULL,
  `Nome` char(40) DEFAULT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`CodFaccia`,`Prodotto`),
  KEY `fk_FACCIA_PRODOTTO1_idx` (`Prodotto`),
  CONSTRAINT `fk_FACCIA_PRODOTTO1` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `FISSAGGIO` (
  `DaFissare` int NOT NULL,
  `SiFissaA` int NOT NULL,
  PRIMARY KEY (`DaFissare`,`SiFissaA`),
  KEY `fk_PARTE_has_PARTE_PARTE1_idx` (`SiFissaA`),
  KEY `fk_PARTE_has_PARTE_PARTE_idx` (`DaFissare`),
  CONSTRAINT `fk_PARTE_has_PARTE_PARTE` FOREIGN KEY (`DaFissare`) REFERENCES `PARTE` (`CodParte`),
  CONSTRAINT `fk_PARTE_has_PARTE_PARTE1` FOREIGN KEY (`SiFissaA`) REFERENCES `PARTE` (`CodParte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `GIUNZIONE` (
  `CodGiunzione` int NOT NULL,
  `Tipo` char(40) DEFAULT NULL,
  `Nome` char(40) DEFAULT NULL,
  PRIMARY KEY (`CodGiunzione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `GUASTO` (
  `CodGuasto` int NOT NULL,
  `Descrizione` char(200) NOT NULL,
  `DomandaIniziale` varchar(20) NOT NULL,
  `Classe` int NOT NULL,
  PRIMARY KEY (`CodGuasto`),
  KEY `fk_GUASTO_DOMANDA1_idx` (`DomandaIniziale`),
  KEY `fk_GUASTO_CLASSE_GUASTO1_idx` (`Classe`),
  CONSTRAINT `fk_GUASTO_CLASSE_GUASTO1` FOREIGN KEY (`Classe`) REFERENCES `CLASSE_GUASTO` (`CodClasse`),
  CONSTRAINT `fk_GUASTO_DOMANDA1` FOREIGN KEY (`DomandaIniziale`) REFERENCES `DOMANDA` (`CodDomanda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `INDIRIZZO` (
  `Via` char(30) NOT NULL,
  `Civico` char(1) NOT NULL,
  `Citta` varchar(30) NOT NULL,
  PRIMARY KEY (`Via`,`Civico`,`Citta`),
  KEY `fk_INDIRIZZO_CITTA1_idx` (`Citta`),
  CONSTRAINT `fk_INDIRIZZO_CITTA1` FOREIGN KEY (`Citta`) REFERENCES `CITTA` (`CodCitta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `ITER` (
  `Precedente` varchar(20) NOT NULL,
  `Successiva` varchar(20) NOT NULL,
  PRIMARY KEY (`Precedente`,`Successiva`),
  KEY `fk_ITER_DOMANDA2_idx` (`Successiva`),
  CONSTRAINT `fk_ITER_DOMANDA1` FOREIGN KEY (`Precedente`) REFERENCES `DOMANDA` (`CodDomanda`),
  CONSTRAINT `fk_ITER_DOMANDA2` FOREIGN KEY (`Successiva`) REFERENCES `DOMANDA` (`CodDomanda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `LINEA` (
  `CodLinea` int NOT NULL,
  `TempoMax` int NOT NULL,
  `Sequenza` int NOT NULL,
  `Prodotto` int NOT NULL,
  `Sede` varchar(30) NOT NULL,
  PRIMARY KEY (`CodLinea`,`Sede`),
  KEY `fk_LINEA_SEQUENZA1_idx` (`Sequenza`,`Prodotto`),
  KEY `fk_LINEA_SEDE_PRODUZIONE1_idx` (`Sede`),
  CONSTRAINT `fk_LINEA_SEDE_PRODUZIONE1` FOREIGN KEY (`Sede`) REFERENCES `SEDE_PRODUZIONE` (`CodSede`),
  CONSTRAINT `fk_LINEA_SEQUENZA1` FOREIGN KEY (`Sequenza`, `Prodotto`) REFERENCES `SEQUENZA` (`CodSequenza`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `LOTTO` (
  `CodLotto` int NOT NULL,
  `DataInizio` datetime NOT NULL,
  `DataFineEffettiva` datetime DEFAULT NULL,
  `DataFineStimata` datetime NOT NULL,
  `Sequenza` int NOT NULL,
  `Area` int NOT NULL,
  PRIMARY KEY (`CodLotto`),
  KEY `fk_LOTTO_SEQUENZA1_idx` (`Sequenza`),
  KEY `fk_LOTTO_AREA1_idx` (`Area`),
  CONSTRAINT `fk_LOTTO_AREA1` FOREIGN KEY (`Area`) REFERENCES `AREA` (`CodArea`),
  CONSTRAINT `fk_LOTTO_SEQUENZA1` FOREIGN KEY (`Sequenza`) REFERENCES `SEQUENZA` (`CodSequenza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `MAGAZZINO` (
  `CodMagazzino` int NOT NULL,
  `Sede` varchar(30) NOT NULL,
  `Citta` varchar(30) NOT NULL,
  `Capienza` int DEFAULT NULL,
  PRIMARY KEY (`CodMagazzino`),
  KEY `fk_MAGAZZINO_SEDE_PRODUZIONE1_idx` (`Sede`,`Citta`),
  CONSTRAINT `fk_MAGAZZINO_SEDE_PRODUZIONE1` FOREIGN KEY (`Sede`, `Citta`) REFERENCES `SEDE_PRODUZIONE` (`CodSede`, `Citta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `MALFUNZIONAMENTO` (
  `Guasto` int NOT NULL,
  `Data` datetime NOT NULL,
  `Unita` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`Guasto`,`Data`,`Unita`,`Prodotto`),
  KEY `Prodotto_idx` (`Prodotto`),
  KEY `da` (`Data`),
  KEY `fk_MALFUNZIONAMENTO_UNITA1_idx` (`Unita`),
  CONSTRAINT `fk_MALFUNZIONAMENTO_GUASTO1` FOREIGN KEY (`Guasto`) REFERENCES `GUASTO` (`CodGuasto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `MANSIONI_PRECEDENTI` (
  `Operatore` int NOT NULL,
  `Stazione` int NOT NULL,
  `DataInizio` datetime NOT NULL,
  `DataFine` datetime NOT NULL,
  PRIMARY KEY (`Operatore`,`Stazione`),
  KEY `fk_OPERATORE_has_STAZIONE_STAZIONE1_idx` (`Stazione`),
  KEY `fk_OPERATORE_has_STAZIONE_OPERATORE1_idx` (`Operatore`),
  CONSTRAINT `fk_OPERATORE_has_STAZIONE_OPERATORE1` FOREIGN KEY (`Operatore`) REFERENCES `OPERATORE` (`CodOperatore`),
  CONSTRAINT `fk_OPERATORE_has_STAZIONE_STAZIONE1` FOREIGN KEY (`Stazione`) REFERENCES `STAZIONE` (`CodStazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `MATERIALE` (
  `CodMateriale` int NOT NULL,
  `Nome` char(40) DEFAULT NULL,
  `Valore` double DEFAULT NULL,
  `CoefficienteSvalutazione` double DEFAULT NULL,
  PRIMARY KEY (`CodMateriale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `MOTIVAZIONE` (
  `CodMotivazione` varchar(30) NOT NULL,
  `Descrizione` char(120) DEFAULT NULL,
  `Richiesta` int NOT NULL,
  PRIMARY KEY (`CodMotivazione`),
  KEY `fk_MOTIVAZIONE_RICHIESTA RESO1_idx` (`Richiesta`),
  CONSTRAINT `fk_MOTIVAZIONE_RICHIESTA RESO1` FOREIGN KEY (`Richiesta`) REFERENCES `RICHIESTA` (`CodRichiesta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `MV_REPORT_VENDITE` (
  `Codice` int NOT NULL,
  `Modello` char(40) DEFAULT NULL,
  `Nome` char(40) DEFAULT NULL,
  `Venduti` int DEFAULT NULL,
  `Pendenti` int DEFAULT NULL,
  `CoefficienteProduzione` double DEFAULT NULL,
  PRIMARY KEY (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `OPERATORE` (
  `CodOperatore` int NOT NULL,
  `StazioneAttuale` int NOT NULL,
  `InizioMansione` datetime NOT NULL,
  `Varianza` double DEFAULT NULL,
  `Media` double DEFAULT NULL,
  `CF` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`CodOperatore`),
  KEY `fk_OPERATORE_STAZIONE1_idx` (`StazioneAttuale`),
  KEY `fk_UTENTE_idx` (`CF`),
  CONSTRAINT `fk_OPERATORE_STAZIONE1` FOREIGN KEY (`StazioneAttuale`) REFERENCES `STAZIONE` (`CodStazione`),
  CONSTRAINT `fk_UTENTE` FOREIGN KEY (`CF`) REFERENCES `UTENTE` (`CodFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `OPERAZIONE` (
  `CodOperazione` int NOT NULL,
  `Descrizione` char(120) DEFAULT NULL,
  `Faccia` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`CodOperazione`),
  KEY `fk_OPERAZIONE_FACCIA1_idx` (`Faccia`,`Prodotto`),
  CONSTRAINT `fk_OPERAZIONE_FACCIA1` FOREIGN KEY (`Faccia`, `Prodotto`) REFERENCES `FACCIA` (`CodFaccia`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `OPERAZIONE_SEQUENZA` (
  `Sequenza` int NOT NULL,
  `Operazione` int NOT NULL,
  `IndiceOrdinamento` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`Sequenza`,`Operazione`,`Prodotto`),
  KEY `fk_SEQUENZA_has_OPERAZIONE_OPERAZIONE1_idx` (`Operazione`),
  KEY `fk_SEQUENZA_has_OPERAZIONE_SEQUENZA1_idx` (`Sequenza`),
  KEY `fk_SEQUENZA_has_OP_idx` (`Prodotto`),
  CONSTRAINT `fk_SEQUENZA_has_OP` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`),
  CONSTRAINT `fk_SEQUENZA_has_OPERAZIONE_OPERAZIONE1` FOREIGN KEY (`Operazione`) REFERENCES `OPERAZIONE` (`CodOperazione`),
  CONSTRAINT `fk_SEQUENZA_has_OPERAZIONE_SEQUENZA1` FOREIGN KEY (`Sequenza`) REFERENCES `SEQUENZA` (`CodSequenza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `ORDINE` (
  `CodOrdine` varchar(20) NOT NULL,
  `Stato` char(20) NOT NULL,
  `DataOrdine` datetime NOT NULL,
  `Account` varchar(40) NOT NULL,
  PRIMARY KEY (`CodOrdine`),
  KEY `fk_ORDINE_ACCOUNT1_idx` (`Account`),
  CONSTRAINT `fk_ORDINE_ACCOUNT1` FOREIGN KEY (`Account`) REFERENCES `ACCOUNT_` (`NickName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE `PARTE` (
  `CodParte` int NOT NULL,
  `Nome` char(40) DEFAULT NULL,
  `Peso` double DEFAULT NULL,
  `Prodotto` int NOT NULL,
  `Giunzione` int NOT NULL,
  `Operazione` int NOT NULL,
  PRIMARY KEY (`CodParte`),
  KEY `fk_PARTE_PRODOTTO1_idx` (`Prodotto`),
  KEY `fk_PARTE_GIUNZIONE1_idx` (`Giunzione`),
  KEY `fk_PARTE_OPERAZIONE1_idx` (`Operazione`),
  CONSTRAINT `fk_PARTE_GIUNZIONE1` FOREIGN KEY (`Giunzione`) REFERENCES `GIUNZIONE` (`CodGiunzione`),
  CONSTRAINT `fk_PARTE_OPERAZIONE1` FOREIGN KEY (`Operazione`) REFERENCES `OPERAZIONE` (`CodOperazione`),
  CONSTRAINT `fk_PARTE_PRODOTTO1` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `PERSONALIZZAZIONE` (
  `Variante` int NOT NULL,
  `Unità` int NOT NULL,
  `Prodotto` int NOT NULL,
  `AttributoVar` char(40) NOT NULL,
  `TipoVariante` char(40) NOT NULL,
  PRIMARY KEY (`TipoVariante`,`AttributoVar`,`Prodotto`,`Unità`,`Variante`),
  KEY `fk_VARIANTE_has_UNITA_UNITA1_idx` (`Unità`,`Prodotto`),
  KEY `PRIMARY1_idx` (`Variante`),
  CONSTRAINT `a` FOREIGN KEY (`Variante`) REFERENCES `VARIANTE` (`CodVariante`),
  CONSTRAINT `fk_VARIANTE_has_UNITA_UNITA1` FOREIGN KEY (`Unità`, `Prodotto`) REFERENCES `UNITA` (`CodSeriale`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `POSSIBILI_RIMEDI` (
  `Rimedio` int NOT NULL,
  `Domanda` varchar(20) NOT NULL,
  PRIMARY KEY (`Rimedio`,`Domanda`),
  KEY `fk_RIMEDIO_has_DOMANDA_DOMANDA1_idx` (`Domanda`),
  KEY `fk_RIMEDIO_has_DOMANDA_RIMEDIO1_idx` (`Rimedio`),
  CONSTRAINT `fk_RIMEDIO_has_DOMANDA_DOMANDA1` FOREIGN KEY (`Domanda`) REFERENCES `DOMANDA` (`CodDomanda`),
  CONSTRAINT `fk_RIMEDIO_has_DOMANDA_RIMEDIO1` FOREIGN KEY (`Rimedio`) REFERENCES `RIMEDIO` (`CodRimedio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `PRESTAZIONE` (
  `Operatore` int NOT NULL,
  `Operazione` int NOT NULL,
  `TempoEsecuzione` double NOT NULL,
  PRIMARY KEY (`Operatore`,`Operazione`),
  KEY `fk_OPERATORE_has_OPERAZIONE_OPERAZIONE1_idx` (`Operazione`),
  KEY `fk_OPERATORE_has_OPERAZIONE_OPERATORE1_idx` (`Operatore`),
  CONSTRAINT `fk_OPERATORE_has_OPERAZIONE_OPERATORE1` FOREIGN KEY (`Operatore`) REFERENCES `OPERATORE` (`CodOperatore`),
  CONSTRAINT `fk_OPERATORE_has_OPERAZIONE_OPERAZIONE1` FOREIGN KEY (`Operazione`) REFERENCES `OPERAZIONE` (`CodOperazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `PRODOTTO` (
  `CodProdotto` int NOT NULL,
  `Modello` char(40) DEFAULT NULL,
  `AnnoProduzione` int DEFAULT NULL,
  `MeseProduzione` int DEFAULT NULL,
  `Categoria` char(40) DEFAULT NULL,
  `Prezzo` double DEFAULT NULL,
  `Tentativi` int DEFAULT '0',
  `Nome` char(40) DEFAULT NULL,
  PRIMARY KEY (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `PRODUZIONE` (
  `Tempo` double NOT NULL,
  `TimeStamp` datetime NOT NULL,
  `Operazione` int NOT NULL,
  `Unita` int NOT NULL,
  `Prodotto` int NOT NULL,
  `Stazione` int NOT NULL,
  PRIMARY KEY (`Operazione`,`Unita`,`Prodotto`,`Stazione`),
  KEY `fk_PRODUZIONE_OPERAZIONE1_idx` (`Operazione`),
  KEY `fk_PRODUZIONE_UNITA1_idx` (`Unita`,`Prodotto`),
  KEY `fk_PRODUZIONE_STAZIONE1_idx` (`Stazione`),
  CONSTRAINT `fk_PRODUZIONE_OPERAZIONE1` FOREIGN KEY (`Operazione`) REFERENCES `OPERAZIONE` (`CodOperazione`),
  CONSTRAINT `fk_PRODUZIONE_STAZIONE1` FOREIGN KEY (`Stazione`) REFERENCES `STAZIONE` (`CodStazione`),
  CONSTRAINT `fk_PRODUZIONE_UNITA1` FOREIGN KEY (`Unita`, `Prodotto`) REFERENCES `UNITA` (`CodSeriale`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `RECENSIONE` (
  `CodRecensione` varchar(30) NOT NULL,
  `Descrizione` char(200) DEFAULT NULL,
  PRIMARY KEY (`CodRecensione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `RICHIESTA` (
  `CodRichiesta` int NOT NULL,
  `Account` varchar(40) NOT NULL,
  `StatoRichiesta` char(20) NOT NULL,
  `DataRichiesta` datetime NOT NULL,
  `DataApprovazione` datetime DEFAULT NULL,
  PRIMARY KEY (`CodRichiesta`),
  KEY `fk_RICHIESTA RESO_ACCOUNT1_idx` (`Account`),
  CONSTRAINT `fk_RICHIESTA RESO_ACCOUNT1` FOREIGN KEY (`Account`) REFERENCES `ACCOUNT_` (`NickName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `RICHIESTA RESO` (
  `CodRichiesta` int NOT NULL,
  `Account` varchar(40) NOT NULL,
  `StatoRichiesta` char(20) NOT NULL,
  `DataRichiesta` datetime NOT NULL,
  `DataApprovazione` datetime DEFAULT NULL,
  PRIMARY KEY (`CodRichiesta`),
  KEY `fk_RICHIESTA RESO_ACCOUNT_1_idx` (`Account`),
  CONSTRAINT `fk_RICHIESTA RESO_ACCOUNT_1` FOREIGN KEY (`Account`) REFERENCES `ACCOUNT_` (`NickName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `RIMEDIO` (
  `CodRimedio` int NOT NULL,
  `Descrizione` char(140) NOT NULL,
  PRIMARY KEY (`CodRimedio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `SEDE_PRODUZIONE` (
  `CodSede` varchar(30) NOT NULL,
  `Citta` varchar(30) NOT NULL,
  PRIMARY KEY (`CodSede`,`Citta`),
  KEY `fk_SEDE_PRODUZIONE_CITTA1_idx` (`Citta`),
  CONSTRAINT `fk_SEDE_PRODUZIONE_CITTA1` FOREIGN KEY (`Citta`) REFERENCES `CITTA` (`CodCitta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `SEQUENZA` (
  `CodSequenza` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`CodSequenza`,`Prodotto`),
  KEY `fk_SEQUENZA_PRODOTTO1_idx` (`Prodotto`),
  CONSTRAINT `fk_SEQUENZA_PRODOTTO1` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `SINTOMATOLOGIA` (
  `Unita` int NOT NULL,
  `Sintomo` int NOT NULL,
  `Prodotto` int NOT NULL,
  `Guasto` int NOT NULL,
  `Data` datetime NOT NULL,
  PRIMARY KEY (`Unita`,`Sintomo`,`Prodotto`,`Guasto`,`Data`),
  KEY `si_idx` (`Sintomo`),
  KEY `pr_idx` (`Prodotto`),
  KEY `gu_idx` (`Guasto`),
  KEY `da_dx` (`Data`),
  CONSTRAINT ` Unita` FOREIGN KEY (`Unita`) REFERENCES `MALFUNZIONAMENTO` (`Unita`),
  CONSTRAINT `da` FOREIGN KEY (`Data`) REFERENCES `MALFUNZIONAMENTO` (`Data`),
  CONSTRAINT `gu` FOREIGN KEY (`Guasto`) REFERENCES `MALFUNZIONAMENTO` (`Guasto`),
  CONSTRAINT `pr` FOREIGN KEY (`Prodotto`) REFERENCES `MALFUNZIONAMENTO` (`Prodotto`),
  CONSTRAINT `si` FOREIGN KEY (`Sintomo`) REFERENCES `Sintomo` (`CodSintomo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `Sintomo` (
  `CodSintomo` int NOT NULL,
  `Descrizione` char(144) DEFAULT NULL,
  PRIMARY KEY (`CodSintomo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `SINTOMO_GUASTO` (
  `Sintomo` int NOT NULL,
  `Guasto` int NOT NULL,
  PRIMARY KEY (`Sintomo`,`Guasto`),
  KEY `Guasto_idx` (`Guasto`),
  CONSTRAINT `Guasto` FOREIGN KEY (`Guasto`) REFERENCES `GUASTO` (`CodGuasto`),
  CONSTRAINT `Sintomo` FOREIGN KEY (`Sintomo`) REFERENCES `SINTOMO` (`CodSintomo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `SOTTOINSIEME_OPERAZIONI` (
  `Stazione` int NOT NULL,
  `Operazione` int NOT NULL,
  `IndiceOrdinamento` int NOT NULL,
  PRIMARY KEY (`Stazione`,`Operazione`),
  KEY `fk_STAZIONE_has_OPERAZIONE_OPERAZIONE1_idx` (`Operazione`),
  KEY `fk_STAZIONE_has_OPERAZIONE_STAZIONE1_idx` (`Stazione`),
  CONSTRAINT `fk_STAZIONE_has_OPERAZIONE_OPERAZIONE1` FOREIGN KEY (`Operazione`) REFERENCES `OPERAZIONE` (`CodOperazione`),
  CONSTRAINT `fk_STAZIONE_has_OPERAZIONE_STAZIONE1` FOREIGN KEY (`Stazione`) REFERENCES `STAZIONE` (`CodStazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `SPEDIZIONE` (
  `CodSpedizione` varchar(30) NOT NULL,
  `Ordine` varchar(20) NOT NULL,
  `CittaArrivo` varchar(30) NOT NULL,
  PRIMARY KEY (`CodSpedizione`),
  KEY `fk_SPEDIZIONE_ORDINE1_idx` (`Ordine`),
  KEY `fk_SPEDIZIONE_CITTA1_idx` (`CittaArrivo`),
  CONSTRAINT `fk_SPEDIZIONE_CITTA1` FOREIGN KEY (`CittaArrivo`) REFERENCES `CITTA` (`CodCitta`),
  CONSTRAINT `fk_SPEDIZIONE_ORDINE1` FOREIGN KEY (`Ordine`) REFERENCES `ORDINE` (`CodOrdine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `STAZIONE` (
  `CodStazione` int NOT NULL,
  `Linea` int NOT NULL,
  `Ordinamento` int NOT NULL,
  `Faccia` int NOT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`CodStazione`),
  KEY `fk_STAZIONE_LINEA1_idx` (`Linea`),
  KEY `fk_STAZIONE_FACCIA1_idx` (`Faccia`,`Prodotto`),
  CONSTRAINT `fk_STAZIONE_FACCIA1` FOREIGN KEY (`Faccia`, `Prodotto`) REFERENCES `FACCIA` (`CodFaccia`, `Prodotto`),
  CONSTRAINT `fk_STAZIONE_LINEA1` FOREIGN KEY (`Linea`) REFERENCES `LINEA` (`CodLinea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `STOCCAGGIO` (
  `DataArrivo` datetime NOT NULL,
  `Area` int NOT NULL,
  `Unita` int NOT NULL,
  `Prodotto` int NOT NULL,
  `DataPartenza` datetime NOT NULL,
  PRIMARY KEY (`DataArrivo`,`Area`,`Unita`,`Prodotto`),
  KEY `fk_STOCAGGIO_AREA1_idx` (`Area`),
  KEY `fk_STOCAGGIO_UNITA1_idx` (`Unita`,`Prodotto`),
  CONSTRAINT `fk_STOCAGGIO_UNITA1` FOREIGN KEY (`Unita`, `Prodotto`) REFERENCES `UNITA` (`CodSeriale`, `Prodotto`),
  CONSTRAINT `fk_STOCCAGGIO_AREA1` FOREIGN KEY (`Area`) REFERENCES `AREA` (`CodArea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `TENTATIVO` (
  `Guasto` int NOT NULL,
  `Data` datetime NOT NULL,
  `Unita` int NOT NULL,
  `Prodotto` int NOT NULL,
  `Rimedio` int NOT NULL,
  `Risolto` tinyint NOT NULL,
  PRIMARY KEY (`Guasto`,`Data`,`Unita`,`Prodotto`,`Rimedio`),
  KEY `fk_MALFUNZIONAMENTO_has_RIMEDIO_RIMEDIO1_idx` (`Rimedio`),
  KEY `fk_MALFUNZIONAMENTO_has_RIMEDIO_MALFUNZIONAMENTO1_idx` (`Guasto`,`Data`,`Unita`,`Prodotto`),
  CONSTRAINT `fk_MALFUNZIONAMENTO_has_RIMEDIO_MALFUNZIONAMENTO1` FOREIGN KEY (`Guasto`, `Data`, `Unita`, `Prodotto`) REFERENCES `MALFUNZIONAMENTO` (`Guasto`, `Data`, `Unita`, `Prodotto`),
  CONSTRAINT `fk_MALFUNZIONAMENTO_has_RIMEDIO_RIMEDIO1` FOREIGN KEY (`Rimedio`) REFERENCES `RIMEDIO` (`CodRimedio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




CREATE TABLE `UNITA` (
  `CodSeriale` int NOT NULL,
  `Prodotto` int NOT NULL,
  `StatoProduzione` char(40) NOT NULL,
  `Lotto` int NOT NULL,
  PRIMARY KEY (`CodSeriale`,`Prodotto`),
  KEY `fk_UNITA_PRODOTTO1_idx` (`Prodotto`),
  KEY `fk_UNITA_LOTTO1_idx` (`Lotto`),
  CONSTRAINT `fk_UNITA_LOTTO1` FOREIGN KEY (`Lotto`) REFERENCES `LOTTO` (`CodLotto`),
  CONSTRAINT `fk_UNITA_PRODOTTO1` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `UNITA_INCOMPLETA` (
  `Unita` int NOT NULL,
  `Prodotto` int NOT NULL,
  `TimeStamp` datetime NOT NULL,
  `Operazione` int NOT NULL,
  `Stazione` int NOT NULL,
  PRIMARY KEY (`Unita`,`Prodotto`,`TimeStamp`),
  KEY `fk_UNITA_INCOMPLETA_OPERAZIONE1_idx` (`Operazione`),
  KEY `fk_UNITA_INCOMPLETA_STAZIONE1_idx` (`Stazione`),
  CONSTRAINT `fk_UNITA_INCOMPLETA_OPERAZIONE1` FOREIGN KEY (`Operazione`) REFERENCES `OPERAZIONE` (`CodOperazione`),
  CONSTRAINT `fk_UNITA_INCOMPLETA_STAZIONE1` FOREIGN KEY (`Stazione`) REFERENCES `STAZIONE` (`CodStazione`),
  CONSTRAINT `fk_UNITA_INCOMPLETA_UNITA1` FOREIGN KEY (`Unita`, `Prodotto`) REFERENCES `UNITA` (`CodSeriale`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `UNITA_RESA` (
  `Unita` int NOT NULL,
  `Prodotto` int NOT NULL,
  `Richiesta` int NOT NULL,
  PRIMARY KEY (`Unita`,`Prodotto`,`Richiesta`),
  KEY `fk_UNITA_RESA_RICHIESTA RESO1_idx` (`Richiesta`),
  CONSTRAINT `fk_UNITA_RESA_RICHIESTA RESO1` FOREIGN KEY (`Richiesta`) REFERENCES `RICHIESTA` (`CodRichiesta`),
  CONSTRAINT `fk_UNITA_RESA_UNITA1` FOREIGN KEY (`Unita`, `Prodotto`) REFERENCES `UNITA` (`CodSeriale`, `Prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `UTENSILE` (
  `CodUtensile` int NOT NULL,
  `Nome` char(40) DEFAULT NULL,
  PRIMARY KEY (`CodUtensile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `UTENTE` (
  `CodFiscale` varchar(30) NOT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `Nome` char(40) DEFAULT NULL,
  `Cognome` char(40) DEFAULT NULL,
  `Via` char(30) NOT NULL,
  `Civico` char(1) NOT NULL,
  `Citta` varchar(30) NOT NULL,
  PRIMARY KEY (`CodFiscale`,`Via`,`Civico`,`Citta`),
  KEY `fk_UTENTE_INDIRIZZO1_idx` (`Via`,`Civico`,`Citta`),
  CONSTRAINT `fk_UTENTE_INDIRIZZO1` FOREIGN KEY (`Via`, `Civico`, `Citta`) REFERENCES `INDIRIZZO` (`Via`, `Civico`, `Citta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `UTILIZZO` (
  `Operazione` int NOT NULL,
  `Utensile` int NOT NULL,
  PRIMARY KEY (`Operazione`,`Utensile`),
  KEY `fk_UTENSILE_has_OPERAZIONE_OPERAZIONE1_idx` (`Utensile`),
  KEY `fk_UTENSILE_has_OPERAZIONE_UTENSILE1_idx` (`Operazione`),
  CONSTRAINT `fk_UTENSILE_has_OPERAZIONE_OPERAZIONE1` FOREIGN KEY (`Utensile`) REFERENCES `OPERAZIONE` (`CodOperazione`),
  CONSTRAINT `fk_UTENSILE_has_OPERAZIONE_UTENSILE1` FOREIGN KEY (`Operazione`) REFERENCES `UTENSILE` (`CodUtensile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `VALUTAZIONE` (
  `Criterio` varchar(30) NOT NULL,
  `Recensione` varchar(30) NOT NULL,
  `Valutazione` double NOT NULL,
  PRIMARY KEY (`Criterio`,`Recensione`),
  KEY `fk_CRITERIO_has_RECENSIONE_RECENSIONE1_idx` (`Recensione`),
  KEY `fk_CRITERIO_has_RECENSIONE_CRITERIO1_idx` (`Criterio`),
  CONSTRAINT `fk_CRITERIO_has_RECENSIONE_CRITERIO1` FOREIGN KEY (`Criterio`) REFERENCES `CRITERIO` (`CodCriterio`),
  CONSTRAINT `fk_CRITERIO_has_RECENSIONE_RECENSIONE1` FOREIGN KEY (`Recensione`) REFERENCES `RECENSIONE` (`CodRecensione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `VARIANTE` (
  `CodVariante` int NOT NULL,
  `TipoVariante` char(40) NOT NULL,
  `AttributoVariante` char(40) NOT NULL,
  `Prezzo` double DEFAULT NULL,
  `Prodotto` int NOT NULL,
  PRIMARY KEY (`CodVariante`,`TipoVariante`,`AttributoVariante`),
  KEY `PRIMARY1` (`CodVariante`),
  KEY `b` (`AttributoVariante`),
  KEY `f_idx` (`Prodotto`),
  CONSTRAINT `f` FOREIGN KEY (`Prodotto`) REFERENCES `PRODOTTO` (`CodProdotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `VINCOLO` (
  `Richiede` int NOT NULL,
  `Richiesta` int NOT NULL,
  PRIMARY KEY (`Richiede`,`Richiesta`),
  KEY `fk_OPERAZIONE_has_OPERAZIONE_OPERAZIONE2_idx` (`Richiesta`),
  KEY `fk_OPERAZIONE_has_OPERAZIONE_OPERAZIONE1_idx` (`Richiede`),
  CONSTRAINT `fk_OPERAZIONE_has_OPERAZIONE_OPERAZIONE1` FOREIGN KEY (`Richiede`) REFERENCES `OPERAZIONE` (`CodOperazione`),
  CONSTRAINT `fk_OPERAZIONE_has_OPERAZIONE_OPERAZIONE2` FOREIGN KEY (`Richiesta`) REFERENCES `OPERAZIONE` (`CodOperazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE1`(IN CodFiscale_ VARCHAR(30))
BEGIN

	/*
		Prendo tutti i prodotti ordinati da un cliente 
        joinando le tuple in ORDINE e DETTAGLIO 
        per poi prendere il codice dell'unita acquistata in DETTAGLIO e 
        joinarla con UNITA 	
	*/
	
    
    SELECT U.* FROM UTENTE UT
    INNER JOIN ACCOUNT_ AC ON AC.CF = UT.CodFiscale
    INNER JOIN ORDINE O ON AC.NickName = O.Account
    INNER JOIN DETTAGLIO DE ON DE.Ordine = O.CodOrdine
    INNER JOIN UNITA U ON U.CodSeriale = DE.Unita
    WHERE UT.CodFiscale = CodFiscale_;
    
    

END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE2`(IN CodProdotto_ INT,OUT Media_ DOUBLE )
BEGIN
		DECLARE Somma INTEGER DEFAULT 0;
		DECLARE Valutazione_i DOUBLE DEFAULT 0;
        DECLARE NumValutazioni INTEGER DEFAULT 0;
        DECLARE Finito INTEGER DEFAULT 0; 
        
        /*
        Il cursore punta ad un result set dove vengono elencati in generale tutte le 
        valutazioni lasciate dai clienti nelle recensioni dei loro ordini su un determinato prodotto
        passato in ingresso 
        */ 
        
        DECLARE CURSORE CURSOR FOR 
        SELECT VA.Valutazione FROM PRODOTTO P
        INNER JOIN UNITA U ON U.Prodotto = P.CodProdotto
        INNER JOIN DETTAGLIO DE ON DE.Unita = U.CodSeriale 
        INNER JOIN RECENSIONE RE ON DE.Recensione = RE.CodRecensione 
        INNER JOIN VALUTAZIONE VA ON VA.Recensione = RE.CodRecensione
		WHERE P.CodProdotto = CodProdotto_;
    
    
		/*
        Dichiaro l'handler per la fine del result set ed apro il cursore
        */
    
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET Finito = 1; 
    
		OPEN CURSORE;
        
        PRELEVA : LOOP
        
			FETCH CURSORE INTO Valutazione_i;
            
            IF Finito = 1 THEN
				LEAVE PRELEVA;
			END IF;
        
        
        /*
        Calcolo la media tramite somma delle valutazioni ed un counter dentro il LOOP
        */
            SET Somma = Somma + Valutazione_i; 
            SET NumValutazioni = NumValutazioni + 1;
    
		END LOOP PRELEVA; 
        
        SET Media_ = Somma / NumValutazioni; 
        

END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE3`(IN Nome CHAR(40), OUT NumCitta INTEGER)
BEGIN 

		/*
        Prendo tutte le occorenze in AVANZAMENTO con Codice della stessa città
        passata in ingresso 
		*/
		
        SET NumCitta = (
        SELECT COUNT(*) FROM AVANZAMENTO AV
        INNER JOIN CITTA C ON C.CodCitta = AV.Citta
        WHERE C.Nome = Nome_
        );
        
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE4`( IN Modello_ VARCHAR(40) , OUT Media DOUBLE)
BEGIN 

		DECLARE Somma_i DOUBLE DEFAULT 0;
        DECLARE Counter INTEGER DEFAULT 1; 
        DECLARE Finito INTEGER DEFAULT 0;
        DECLARE CURSORE CURSOR FOR
        
        /*	Dichiaro il cursore per i tempi presenti in PRODUZIONE 
			per il modello del prodotto pasasto in ingresso         
		*/
        SELECT PR.Tempo FROM PRODOTTO P 
			INNER JOIN UNITA U ON U.Prodotto = P.CodProdotto
			INNER JOIN PRODUZIONE PR ON PR.Unita = U.CodSeriale 
			WHERE P.Modello = Modello_;
			
        /*	Dichiarazione del LOOP dell' handler e calcolo della media 
        */
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND 
			SET Finito = 1 ; 
            
            
		OPEN CURSORE; 
        
			
		PRELEVA : LOOP 
			FETCH CURSORE INTO Somma_i; 
            
            IF Finito = 1 THEN 
				LEAVE PRELEVA; 
            END IF;
            
			SET Media = Media + Somma_i;
            SET Counter = Counter + 1;
		
        END LOOP PRELEVA;
		
			SET Media = Media / Counter;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE5`(IN CodProdotto_ INT, OUT Totale INTEGER)
BEGIN


		DECLARE Valore_i INTEGER DEFAULT 0;
		DECLARE Quantita_i INTEGER DEFAULT 0;
		DECLARE Somma INTEGER DEFAULT 0;
        DECLARE Finito INTEGER DEFAULT 0;
        
        
        /*		Dichiaro il cursore per la coppia {valore,quantità} in modo da calcolare il valore complessivo
				delle parti del prodotto passato in ingresso 
        */
        DECLARE CURSORE CURSOR FOR 
        SELECT MA.Valore, CO.Quantità FROM PARTE PA
        INNER JOIN COMPOSIZIONE CO ON CO.Parte = PA.CodParte
        INNER JOIN MATERIALE MA ON MA.CodMateriale = CO.Materiale
        WHERE PA.Prodotto = CodProdotto_; 

		/* 		Dichiaro Handler, apro il cursore e calcolo il valore delle parti
        */
		DECLARE CONTINUE HANDLER FOR NOT FOUND 
			SET Finito = 1; 
            
        OPEN CURSORE ;
        
		PRELEVA : LOOP
			
			FETCH CURSORE INTO Valore_i,Quantita_i;
            
            IF Finito = 1 THEN
				LEAVE PRELEVA ;
			END IF; 
            
            SET Somma = Somma + (Valore_i * Quantita_i);
        
        END LOOP PRELEVA;

		SET  Totale = Somma;



END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE6`(IN Modello_ CHAR(40) )
BEGIN

	/*		Prendo tutti i rimedi joinando le chiavi presenti in PRODOTTO da CODICE_ERRORE
			per poi prendere le descrizioni dei rimedi tramite CODICE_ERRORE_RIMEDIO 
	*/
	SELECT RI.* FROM PRODOTTO P
    INNER JOIN CODICE_ERRORE CE ON CE.Prodotto = P.CodProdotto
    INNER JOIN COD_ERRORE_RIMEDIO CER ON CER.Errore = CE.CodErrore
    INNER JOIN RIMEDIO RI ON RI.CodRimedio = CER.Rimedio
    WHERE P.Modello = Modello_ ;

END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE7`(
IN CodFiscale_ VARCHAR(30), 
IN telefono_ VARCHAR(10), 
IN Nome_ CHAR(40), 
IN Cognome_ CHAR(40), 
IN Via_ CHAR(30), 
IN Civico_ CHAR(1), 
IN Citta_ VARCHAR(30),
IN NomeCitta_ CHAR(40), 
IN Cap_ VARCHAR (5),
IN NickName_ VARCHAR(40), 
IN Password_ VARCHAR(45), 
IN  Domanda_ CHAR(120), 
IN Risposta_ CHAR(120) 
)
BEGIN 

		
		INSERT INTO UTENTE (CodFiscale, Telefono, Nome, Cognome, Via, Civico, Citta) VALUES (CodFiscale_, telefono_ , Nome_ ,Cognome_, Via_, Civico_, Citta_);
        INSERT INTO INDIRIZZO (Via, Civico, Citta) VALUES (Via_, Civico_, Citta_);
        INSERT INTO CITTA (CodCitta, Nome, CAP) VALUES (Citta_,NomeCitta_,Cap_);
        INSERT INTO ACCOUNT_ (NickName, Password, Domanda, Risposta,CF) VALUES (NickName_, Password_, Domanda_, Risposta_, CodFiscale_);
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE8`(IN Modello_ CHAR(30))
BEGIN 		 

		
        /*		Joino le chiavi delle unità presenti UNITA_INCOMPLETA e quelle presenti 
				in PRODUZIONE
        */

		SELECT PR.Tempo, PR.Timestamp FROM PRODOTTO P 
        INNER JOIN UNITA_INCOMPLETA UT ON UT.Prodotto = P.CodProdotto        
        INNER JOIN PRODUZIONE PR ON (UT.TimeStamp = PR.TimeStamp AND PR.Prodotto = UT.Prodotto AND UT.Unita = PR.Unita)
        WHERE P.Modello = Modello_;
        

END$$
DELIMITER ;



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OPERAZIONE9`(IN Modello INTEGER, OUT Num_malfunzionamenti INT)
BEGIN 
		
	/*
    Prendo i codici dei prodotti joinando con il malfunzionamento 
    e vedento i tentativi totali sui modelli di prodotto passati in ingresso
	*/
	SET Num_malfunzionamenti = (	
		SELECT COUNT(*) FROM PRODOTTO P
        INNER JOIN MALFUNZIONAMENTO MA ON MA.Prodotto = CodProdotto
		NATURAL JOIN TENTATIVO TE 
		WHERE P.Modello = Modello 
    );
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PUNTEGGIO`(IN Guasto_ INTEGER, IN Unita_ INTEGER, IN Prodotto_ INTEGER, IN Data_ DATETIME, IN Sintomo1_ CHAR(144), IN Sintomo2_ CHAR(144), IN Sintomo3_ CHAR(144), IN Sintomo4_ CHAR(144), IN Sintomo5_ CHAR(144),IN Categoria_ CHAR(40), OUT Punteggio DOUBLE , OUT E_p DOUBLE)
BEGIN 
	
		DECLARE Categoria CHAR(40) DEFAULT ''; 
		DECLARE Punteggio DOUBLE DEFAULT 0;
        DECLARE Sintomo_i CHAR (144) DEFAULT '' ;  
        DECLARE Finito INTEGER DEFAULT 0;
        
        -- Dichiaro un cursore per tutti i sintomi del malfunzionamento passato in ingresso 
        DECLARE CURSORE CURSOR FOR 
			SELECT S.Descrizione FROM MALFUNZIONAMENTO MA
            NATURAL JOIN SINTOMATOLOGIA SI 
            INNER JOIN SINTOMO S ON S.CodSintomo = SI.Sintomo
            WHERE MA.Guasto = Guasto_ 
			AND MA.Unita = Unita_
            AND MA.Prodotto = Prodotto_ 
            AND MA.Data = Data_; 

		DECLARE CONTINUE HANDLER FOR NOT FOUND 
			SET Finito = 1; 
            
        
	

		-- Prendo la categoria del prodotto passato in ingresso

		SET Categoria = (
			SELECT P.Categoria FROM PRODOTTO P 
            WHERE P.CodProdotto = Prodotto_ 
		);
		

		OPEN CURSORE; 
        
        PRELEVA : LOOP 
        
			FETCH CURSORE INTO Sintomo_i; 
				
                IF Finito = 1 THEN 
					LEAVE PRELEVA ;
				END IF; 
                
				-- Calcolo il punteggio del malfunzionamento passato in ingresso 
                IF (Sintomo_i = Sintomo1 OR Sintomo_i = Sintomo2 OR Sintomo_i = Sintomo3 OR Sintomo_i = Sintomo4 OR Sintomo_i = Sintomo5 ) THEN 
					SET Punteggio = Punteggio + 0.30; 
				END IF; 
                
			END LOOP ; 		
                
		IF (Categoria = Categoria_ ) THEN
			SET Punteggio = Punteggio + 1 ;
		END IF; 
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `RANKING`(IN Sintomo1 CHAR(144), IN Sintomo2 CHAR(144), IN Sintomo3 CHAR(144), IN Sintomo4 CHAR(144), IN Sintomo5 CHAR(144) )
BEGIN 

	DECLARE E_p DOUBLE DEFAULT 0;
	DECLARE Somma_Guasto INTEGER DEFAULT 0;
	DECLARE Somma_Rimedio INTEGER DEFAULT 0;
	DECLARE Punteggio_i DOUBLE DEFAULT 0; 
    DECLARE Guasto_i INTEGER DEFAULT 0; 
    DECLARE Unita_i INTEGER DEFAULT 0; 
    DECLARE Prodotto_i INTEGER DEFAULT 0; 
    DECLARE Data_i DATETIME DEFAULT NULL; 
    DECLARE Rimedio_i INT DEFAULT NULL;
    
	DECLARE Finito INTEGER DEFAULT 0; 
    
    /* Dichiaro un cursore per tutti i malfunzionamenti associati a tentativi di rimedio che hanno avuto successo 
    */
    
    DECLARE CURSORE CURSOR FOR 
		SELECT MA.Guasto,MA.Unita,MA.Prodotto,MA.Data,TE.Rimedio FROM MALFUNZIONAMENTO MA
		NATURAL JOIN SINTOMATOLOGIA SI
		NATURAL JOIN TENTATIVO TE 
		WHERE TE.Risolto = TRUE; 
        
	
    
    
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET Finito = 1 ; 
    

    TRUNCATE ANALITYCS; 
    
    OPEN CURSORE ; 
    
    PRELEVA : LOOP 
    
		FETCH CURSORE INTO Guasto_i, Unita_i,Prodotto_i,Data_i,Rimedio_i ; 
	
		IF Finito = 1 THEN 
			LEAVE PRELEVA; 
		END IF;

		/* Per ogni tentativo di rimedio calcolo il 'punteggio' tramite la Procedure omonima 
        */


		 SET Somma_Guasto = (
			SELECT COUNT(*) FROM MALFUNZIONAMENTO MA 
            WHERE MA.Guasto = Guasto_i
							); 
                            
         SET Somma_Rimedio = (
			SELECT COUNT(* ) FROM TENTATIVO TE
            WHERE TE.Guasto = Guasto_ AND TE.Rimedio = Rimedio_i AND TE.Risolto = TRUE
    );                   

		SET E_p = Somma_Rimedio / Somma_Guasto; 

		CALL Punteggio(Guasto_i, Unita_i, Prodotto_i, Data_i, Sintomo1, Sintomo2, Sintomo3, Sintomo4, Sintomo5, Punteggio_i,E_p) ;  
        
        


		-- Inserisco la tupla del malfunzionamento associato al punteggio nella tabella ANALITYCS 
		INSERT INTO ANALITYCS (Guasto,Unita,Rimedio,Punteggio,Prodotto) VALUES (Guasto_i,Unita_i,Rimedio_i,Punteggio_i,Prodotto_i);  
		
	END LOOP PRELEVA; 


	SELECT N.Guasto,N.Unita,N.Rimedio, RANK() OVER  ( ORDER BY N.Punteggio ) FROM ANALITYCS N ;


	TRUNCATE ANALITYCS; 


END$$
DELIMITER ;
DELIMITER $$




DROP TABLE IF EXISTS MV_REPORT_VENDITE; 
CREATE TABLE MV_REPORT_VENDITE (
    Codice INT NOT NULL,
    Modello CHAR(40) DEFAULT NULL,
    Nome CHAR(40) DEFAULT NULL,
    Venduti INT DEFAULT NULL,
    Pendenti INT DEFAULT NULL,
	CoefficienteProduzione DOUBLE DEFAULT NULL,
PRIMARY KEY (Codice) 
)ENGINE = InnoDB; 




CREATE DEFINER=`root`@`localhost` PROCEDURE `REPORT_`()
BEGIN 

		DECLARE Codice_i INTEGER ; 
        DECLARE Modello_i CHAR(40) DEFAULT '';
        DECLARE Nome_i CHAR(40) DEFAULT '';
        DECLARE Venduti_i INT DEFAULT NULL;
        DECLARE Pendenti_i INT DEFAULT NULL;
        DECLARE CoefficienteProduzione DOUBLE DEFAULT NULL;
        DECLARE Finito INTEGER DEFAULT 0;
        
        DECLARE CURSORE CURSOR FOR 
			SELECT 	P.CodProdotto,
					P.Modello,
                    P.Nome,
                    (COUNT(*) - Pendenti) AS Venduti,
                    (	
                    SELECT COUNT(*) FROM DETTAGLIO DE1 
                    INNER JOIN ORDINE O1 ON O1.CodOrdine = DE1.Ordine
                    WHERE O1.Stato = 'Pendente' AND DE1.Prodotto = P.CodProdotto
                    ) AS Pendenti
            FROM PRODOTTO P 
            INNER JOIN DETTAGLIO DE ON P.CodProdotto = DE.Prodotto
            INNER JOIN ORDINE O ON O.CodOrdine = DE.Ordine 
            WHERE O.DataOrdine > CURRENT_DATE() - INTERVAL 7 DAY 
			GROUP BY P.CodProdotto;
					
            DECLARE CONTINUE HANDLER FOR NOT FOUND 
				SET Finito = 1;
                
           TRUNCATE TABLE MV_REPORT_VENDITE;     
                
                
           OPEN CURSORE ;
           
           
           PRELEVA : LOOP 
				FETCH CURSORE INTO Codice_i, Modello_i, Nome_i, Venduti_i, Pendenti_i ; 
                
					IF Finito = 1 THEN 
						LEAVE PRELEVA;
					END IF ; 
                
                INSERT INTO MV_REPORT_VENDITE(Codice,Modello,Nome,Venduti,Pendenti,CoefficienteProduzione) VALUES (Codice_i, Modello_i, Nome_i, Venduti_i, Pendenti_i,CoefficienteProduzione);
			END LOOP PRELEVA; 
            
END
$$ DELIMITER ;

DROP EVENT IF EXISTS AGGIORNA_MV_REPORT_VENDITE; 
delimiter $$ 
CREATE EVENT AGGIORNA_MV_REPORT_VENDITE
ON SCHEDULE EVERY 1 WEEK 
STARTS '2021-04-19 00:00:00' 
DO
BEGIN

	-- Elimino il contenuto precedente della MV
	TRUNCATE MV_REPORT_VENTITE; 
    -- Chiamo la procedure e calcolo il REPORT
	CALL REPORT_(); 
END ; 
$$ delimiter ; 

/*


DROP TRIGGER IF EXISTS CheckEstensioneGaranziaUnita; 
DELIMITER $$ 
CREATE TRIGGER CheckEstensioneGaranziaUnita 
BEFORE UPDATE ON ESTENSIONE_UNITA 
FOR EACH ROW 
BEGIN 

		DECLARE Controllo INTEGER DEFAULT 0; 
		
		
        
        SET Controllo = 
        (
        
			SELECT COUNT(*) FROM ESTENSIONE_PRODOTTO EP
            WHERE EP.Prodotto = NEW.Prodotto
            AND EP.Estensione = NEW.Estensione
        );

		-- Se non riesco a trovare l'estensione, lancio un rollback 
			IF (Controllo = 0) THEN 
				SELECT MESSAGE_TEXT = 'Stai associando un estensione della garanzia ad una unità il cui prodotto generico non è associato';
				ROLLBACK ; 
			END IF; 
		
END ; 

*/



DROP TRIGGER IF EXISTS CheckSottoinsiemeOperazioni;
DELIMITER $$ 
CREATE TRIGGER CheckSottoinsiemeOperazioni 
BEFORE INSERT ON SOTTOINSIEME_OPERAZIONI
FOR EACH ROW 
BEGIN 

		DECLARE Controllo INTEGER DEFAULT 0 ;
        DECLARE Sequenza INTEGER DEFAULT 0;
        
        -- Prendo la sequenza di cui la stazione esegue un sotto-insieme delle operazioni 
        
        
			SELECT S.CodSequenza INTO Sequenza
            FROM SEQUENZA S 
            INNER JOIN LINEA L ON L.Sequenza = S.CodSequenza 
			INNER JOIN STAZIONE STA ON STA.Linea = L.CodLinea 
            WHERE STA.CodStazione = NEW.Stazione
            GROUP BY  S.CodSequenza LIMIT 1 ; 
            
	
        
        
        -- Controllo se effettivamente l'operazione che sto inserendo fa parte della sequenza utilizzata dalla linea di cui la stazione fa parte
        
        SELECT COUNT(*) INTO Controllo
        FROM OPERAZIONE_SEQUENZA OS 
        WHERE OS.Sequenza = Sequenza 
        AND OS.Operazione = NEW.Operazione
        LIMIT 1 ;

		
		-- Se non ho trovato l'operazione nella sequenza, lancio un rollback
		/*
        IF (Controllo = 0) THEN 
			ROLLBACK ;
	    END IF; 
	*/
	
END ; 
$$ DELIMITER ; 

DROP TRIGGER IF EXISTS Aggiorna_Tentativi_Malfunzionamenti ; 
DELIMITER $$ 
CREATE TRIGGER Aggiorna_Tentativi_Malfunzionamenti 
AFTER INSERT ON TENTATIVO
FOR EACH ROW 
BEGIN 

		DECLARE Prodotto_ INTEGER DEFAULT 0; 
        
        /* 		Prendo il codice del prodotto su cui sto eseguendo un tentativo di rimedio
        */
        
        SET Prodotto_ = 
        (
			SELECT TE.Prodotto FROM TENTATIVO TE 
            WHERE TE.Prodotto = NEW.Prodotto
        );

		/*		Aggiorno i tentativi del prodotto 
        */
		
        
		UPDATE PRODOTTO P  
        SET P.Tentativi = P.Tentativi + 1 
        WHERE P.CodProdotto = Prodotto_;
         
END ;
$$ DELIMITER ; 



DROP TRIGGER IF EXISTS Aggiorna_Importanza; 
DELIMITER $$ 
CREATE TRIGGER Aggiorna_Importanza 
AFTER INSERT ON AVANZAMENTO
FOR EACH ROW 
BEGIN 

		DECLARE Citta INTEGER DEFAULT 0;
		
        -- Prendo la città interessata dall'inserimento in TENTATIVO 
        
        SET Citta = (
			SELECT AV.Citta FROM AVANZAMENTO AV
            WHERE AV.Citta = NEW.Citta
        );
        
        
        -- Aggiorno l' 'Importanza' della città 
        UPDATE CITTA  
        SET Importanza = Importanza + 1
        WHERE CodCitta = Citta;
END ; 
$$ DELIMITER ; 















-- INDIRIZZO

	INSERT INTO INDIRIZZO (Via, Civico, Citta) VALUES ('Geminiani' ,'3',0);
	INSERT INTO INDIRIZZO (Via, Civico, Citta) VALUES ('Barcellona' ,'4',0);
	INSERT INTO INDIRIZZO (Via, Civico, Citta) VALUES ('Rio Seligheddu' ,'5',0);
	INSERT INTO INDIRIZZO (Via, Civico, Citta) VALUES ('Corso Umberto' ,'6',0);


-- UTENTE

 INSERT INTO UTENTE (CodFiscale,Telefono,Nome,Cognome,Via,Civico,Citta) VALUES ('NLQPWJ60M69A658A','451-71-39','Daniel','Deiana','Geminiani' ,'3',0);
 INSERT INTO UTENTE (CodFiscale,Telefono,Nome,Cognome,Via,Civico,Citta) VALUES ('NLQPWJ60M69A658B','451-71-38','Marco','Campus','Barcellona' ,'4',0);
 INSERT INTO UTENTE (CodFiscale,Telefono,Nome,Cognome,Via,Civico,Citta) VALUES ('NLQPWJ60M69A658C','451-71-49','Lorenzo','Guidotti','Corso Umberto' ,'6',0);

-- DOCUMENTO IDENTIFICAZIONE 
	
INSERT INTO DOCUMENTO (CodDocumento,Tipologia,Utente,DataScadenza,EnteRilascio) VALUES (0428564285,'Carta di identità','NLQPWJ60M69A658A','2020-03-15','Comune');
INSERT INTO DOCUMENTO (CodDocumento,Tipologia,Utente,DataScadenza,EnteRilascio) VALUES (0428564286,'Carta di identità','NLQPWJ60M69A658B','2020-03-16','Comune');
INSERT INTO DOCUMENTO (CodDocumento,Tipologia,Utente,DataScadenza,EnteRilascio) VALUES (0428564287,'Carta di identità','NLQPWJ60M69A658C','2020-03-17','Comune');

-- ACCOUNT 

INSERT INTO ACCOUNT_ (NickName,Password,Domanda,Risposta,CF) VALUES ('MasterDani2000','ciaobello','Quando hai dato il tuo primo bacio? ', 'un giorno di novembre','NLQPWJ60M69A658A');
INSERT INTO ACCOUNT_ (NickName,Password,Domanda,Risposta,CF) VALUES ('iamcampus','ciaobella','Quando hai dato il tuo primo bacio? ', 'un giorno di Febbraio','NLQPWJ60M69A658B');
INSERT INTO ACCOUNT_ (NickName,Password,Domanda,Risposta,CF) VALUES ('Driveheights','ciaobelli','Quando hai dato il tuo primo bacio? ', 'non ricordo','NLQPWJ60M69A658C');



-- UNITA

	INSERT INTO UNITA (CodSeriale, Prodotto, StatoProduzione,Lotto) VALUES (0239924749,2,'In produzione',1);
    INSERT INTO UNITA (CodSeriale, Prodotto, StatoProduzione,Lotto) VALUES (0239924748,2,'In produzione',1);
    INSERT INTO UNITA (CodSeriale, Prodotto, StatoProduzione,Lotto) VALUES (0239924746,2,'In produzione',1);
    INSERT INTO UNITA (CodSeriale, Prodotto, StatoProduzione,Lotto) VALUES (0239924745,2,'In produzione',1);
    INSERT INTO UNITA (CodSeriale, Prodotto, StatoProduzione,Lotto) VALUES (0239924744,2,'In produzione',1);
    INSERT INTO UNITA (CodSeriale, Prodotto, StatoProduzione,Lotto) VALUES (0239924743,2,'In produzione',1);


-- FACCIA

	INSERT INTO FACCIA (CodFaccia,Nome,Prodotto) VALUES (0,'Frontale',2);
	INSERT INTO FACCIA (CodFaccia,Nome,Prodotto) VALUES (1,'Superiore',2);
	INSERT INTO FACCIA (CodFaccia,Nome,Prodotto) VALUES (2,'Laterale 1',2);
	INSERT INTO FACCIA (CodFaccia,Nome,Prodotto) VALUES (3,'Laterale 2',2);
	INSERT INTO FACCIA (CodFaccia,Nome,Prodotto) VALUES (4,'Inferiore',2);


-- OPERAZIONE 

	INSERT INTO OPERAZIONE (CodOperazione,Descrizione,Faccia,Prodotto) VALUES (0,'Montaggio parte superiore chassis',1,2);
	INSERT INTO OPERAZIONE (CodOperazione,Descrizione,Faccia,Prodotto) VALUES (1,'Montaggio parte frontale chassis',0,2);
    INSERT INTO OPERAZIONE (CodOperazione,Descrizione,Faccia,Prodotto) VALUES (2,'Montaggio parte laterale 1 chassis',2,2);
    INSERT INTO OPERAZIONE (CodOperazione,Descrizione,Faccia,Prodotto) VALUES (3,'Montaggio parte laterale 2 chassis',3,2);
    INSERT INTO OPERAZIONE (CodOperazione,Descrizione,Faccia,Prodotto) VALUES (4,'Montaggio parte inferiore chassis',4,2);
	INSERT INTO OPERAZIONE (CodOperazione,Descrizione,Faccia,Prodotto) VALUES (5,'Montaggio motore',0,2);


-- GIUNZIONE
 	INSERT INTO GIUNZIONE (CodGiunzione,Tipo,Nome) VALUES (0,'A Scatto',0);
    
-- CARATTERISTICA 


 	INSERT INTO CARATTERISTICA (CodCaratteristica,UnitaMisura,Descrizione) VALUES (0,'mm','Spessore');
	INSERT INTO CARATTERISTICA (CodCaratteristica,UnitaMisura,Descrizione) VALUES (1,'mm','Passo di filettatura');
    INSERT INTO CARATTERISTICA (CodCaratteristica,UnitaMisura,Descrizione) VALUES (2,'cm','Lunghezza');
    


-- VINCOLO PRECEDENZA 

	INSERT INTO VINCOLO (Richiede,Richiesta) VALUES (0,1);
	INSERT INTO VINCOLO (Richiede,Richiesta) VALUES (0,2);
	INSERT INTO VINCOLO (Richiede,Richiesta) VALUES (0,3);



-- PARTE 

	INSERT INTO PARTE (CodParte,Nome,Peso,Prodotto,Giunzione,Operazione) VALUES(0,'Chassis A1',0.2,2,0,0);
    INSERT INTO PARTE (CodParte,Nome,Peso,Prodotto,Giunzione,Operazione) VALUES(1,'Chassis A2',0.47,2,0,1);
    INSERT INTO PARTE (CodParte,Nome,Peso,Prodotto,Giunzione,Operazione) VALUES(2,'Chassis A3',0.3,2,0,2);
    INSERT INTO PARTE (CodParte,Nome,Peso,Prodotto,Giunzione,Operazione) VALUES(3,'Chassis A4',0.5,2,0,3);

-- ASSEMBLAGGIO


	INSERT INTO FISSAGGIO (DaFissare,SiFissaA) VALUES (0,2); 
	INSERT INTO FISSAGGIO (DaFissare,SiFissaA) VALUES (0,3); 

    
 -- SEQUENZA 
	
    INSERT INTO SEQUENZA (CodSequenza, Prodotto) VALUES (0,2);
	INSERT INTO SEQUENZA (CodSequenza, Prodotto) VALUES (1,2); 

    
-- OPERAZIONE_SEQUENZA

	INSERT INTO OPERAZIONE_SEQUENZA (Sequenza,Operazione,IndiceOrdinamento,Prodotto) VALUES (0,2,0,2);
    INSERT INTO OPERAZIONE_SEQUENZA (Sequenza,Operazione,IndiceOrdinamento,Prodotto) VALUES (0,3,1,2);


-- LINEA 

	INSERT INTO LINEA (CodLinea,TempoMax,Sequenza,Prodotto,Sede) VALUES (0,40,0,2,0); 


-- STAZIONE


	INSERT INTO STAZIONE (CodStazione,Linea,Ordinamento,Faccia,Prodotto) VALUES (0,0,0,0,2);
    
-- OPERATORE 

	INSERT INTO OPERATORE (CodOperatore,StazioneAttuale,InizioMansione,Varianza,Media) VALUES (0,0,'2014-02-24',0,0); 

 -- VARIANTE
 
	INSERT INTO VARIANTE (CodVariante,TipoVariante,AttributoVariante,Prodotto) VALUES (0,'Colore','Rosso',2); 
	INSERT INTO VARIANTE (CodVariante,TipoVariante,AttributoVariante,Prodotto) VALUES (1,'Colore','Verde',2);
    INSERT INTO VARIANTE (CodVariante,TipoVariante,AttributoVariante,Prodotto) VALUES (3,'Colore','Nero',2);

-- PERSONALIZZAZIONE 


	INSERT INTO PERSONALIZZAZIONE (Variante,Unità,Prodotto,AttributoVar,TipoVariante) VALUES (0,239924743,2,'','');
	INSERT INTO PERSONALIZZAZIONE (Variante,Unità,Prodotto,AttributoVar,TipoVariante) VALUES (1,239924744,2,'','');
    INSERT INTO PERSONALIZZAZIONE (Variante,Unità,Prodotto,AttributoVar,TipoVariante) VALUES (3,239924745,2,'','');
	

-- MATERIALE 

	
	INSERT INTO MATERIALE(CodMateriale,Nome,Valore,CoefficienteSvalutazione) VALUES (0,'Acciaio',1.6,0.85);
	INSERT INTO MATERIALE(CodMateriale,Nome,Valore,CoefficienteSvalutazione) VALUES (1,'Ferro',1.2,0.9);
    INSERT INTO MATERIALE(CodMateriale,Nome,Valore,CoefficienteSvalutazione) VALUES (2,'Plastica',0.35,1.2);
	INSERT INTO MATERIALE(CodMateriale,Nome,Valore,CoefficienteSvalutazione) VALUES (3,'Silicio',4.7,0.2);
    
    
    
-- COMPOSIZIONE 

	INSERT INTO COMPOSIZIONE(Materiale, Parte, Quantità) VALUES (2,0,0.47);
	INSERT INTO COMPOSIZIONE(Materiale, Parte, Quantità) VALUES (0,3,0.2);
    INSERT INTO COMPOSIZIONE(Materiale, Parte, Quantità) VALUES (2,3,0.3);


-- CLASSE_GUASTO 


	INSERT INTO CLASSE_GUASTO (CodClasse, Nome) VALUES (0,'Componenti Circuitali');
    INSERT INTO CLASSE_GUASTO (CodClasse, Nome) VALUES (1,'Alimentazione');
    INSERT INTO CLASSE_GUASTO (CodClasse, Nome) VALUES (2,'Motore');
    INSERT INTO CLASSE_GUASTO (CodClasse, Nome) VALUES (3,'Varia');


-- CODICE_ERRORE

	INSERT INTO CODICE_ERRORE (CodErrore,Prodotto,Guasto) VALUES ('82F01D4BB422B0F4C23A36C77C439A',2,0);
	INSERT INTO CODICE_ERRORE (CodErrore,Prodotto,Guasto) VALUES ('82F01D4BB422B0F4C23A36C77C439B',2,1);
	INSERT INTO CODICE_ERRORE (CodErrore,Prodotto,Guasto) VALUES ('82F01D4BB422B0F4C23A36C77C439C',2,2);

-- GUASTO 

	INSERT INTO GUASTO (CodGuasto,Descrizione,DomandaIniziale,Classe) VALUES (0,'Anomalia sistema di alimentazione','9C2CB73253C06D56BF69',0);
	INSERT INTO GUASTO (CodGuasto,Descrizione,DomandaIniziale,Classe) VALUES (1,'Anomalia sistema meccanico','9C2CB73253C06D56BF68',3);
	INSERT INTO GUASTO (CodGuasto,Descrizione,DomandaIniziale,Classe) VALUES (2,'Anomalia circuito integrato','9C2CB73253C06D56BF67',0);


-- DOMANDA 

	INSERT INTO DOMANDA (CodDomanda,Descrizione) VALUES ('9C2CB73253C06D56BF69','Collegato il dispositivo all alimentazione?');
	INSERT INTO DOMANDA (CodDomanda,Descrizione) VALUES ('9C2CB73253C06D56BF68','Lasciato spegnere il meccanismo?');
	INSERT INTO DOMANDA (CodDomanda,Descrizione) VALUES ('9C2CB73253C06D56BF67','Inserito il cavo di alimentazione?');

    
   -- ESTENSIONE GARANZIA
   
   INSERT INTO ESTENSIONE (CodEstensione,Prezzo) VALUES(0,30);
   INSERT INTO ESTENSIONE (CodEstensione,Prezzo) VALUES(1,40);
   
   -- COPERTURA
   
	
	INSERT INTO COPERTURA (ClasseGuasto,Estensione) VALUES (0,0);
	INSERT INTO COPERTURA (ClasseGuasto,Estensione) VALUES (1,0);
	INSERT INTO COPERTURA (ClasseGuasto,Estensione) VALUES (0,1);
	INSERT INTO COPERTURA (ClasseGuasto,Estensione) VALUES (1,1);
	INSERT INTO COPERTURA (ClasseGuasto,Estensione) VALUES (2,1);

    
	-- ORDINE
    
    
    INSERT INTO ORDINE (CodOrdine,Stato,DataOrdine,Account) VALUES ('56F8EB91CBD78BB9D5FE','In Processazione','2016-03-13','MasterDani2000');
    INSERT INTO ORDINE (CodOrdine,Stato,DataOrdine,Account) VALUES ('56F8EB91CBD78BB9D5FF','In Processazione','2016-02-15','iamcampus');
    
    
	
    -- RECENSIONE 
    
    INSERT INTO RECENSIONE (CodRecensione,Descrizione) VALUES ('0CAB4D499DFD2A0F0522A3D7716EA3','');
    INSERT INTO RECENSIONE (CodRecensione,Descrizione) VALUES ('0CAB4D499DFD2A0F0522A3D7716EA4','');
    
	-- CRITERIO
    
    
    INSERT INTO CRITERIO (CodCriterio,Nome) VALUES ('9A833C2E71AC9D34C2B4EB72E76D19','Durevolezza'); 
    INSERT INTO CRITERIO (CodCriterio,Nome) VALUES ('9A833C2E71AC9D34C2B4EB72E76D18','Estetica');
    INSERT INTO CRITERIO (CodCriterio,Nome) VALUES ('9A833C2E71AC9D34C2B4EB72E76D17','Durata Batteria'); 
	
    


    
    -- DETTAGLIO 
    
    INSERT INTO DETTAGLIO (Unita,Prodotto,Ordine,Recensione) VALUES (239924742,2,'56F8EB91CBD78BB9D5FE','9A833C2E71AC9D34C2B4EB72E76D19'); 
    
    
    
    
    
    -- UTENSILE
    
    INSERT INTO UTENSILE (CodUtensile,Nome) VALUES (0,'Cacciavite');
    INSERT INTO UTENSILE (CodUtensile,Nome) VALUES (1,'Tenaglia');
    INSERT INTO UTENSILE (CodUtensile,Nome) VALUES (2,'Saldatore');
    INSERT INTO UTENSILE (CodUtensile,Nome) VALUES (3,'Fiamma Ossidrica');
    INSERT INTO UTENSILE (CodUtensile,Nome) VALUES (4,'Trapano'); 
    
    
    
    -- RICHIESTA RESO
    
     INSERT INTO RICHIESTA (CodRichiesta,Account,StatoRichiesta,DataRichiesta,DataApprovazione) VALUES (0,'Driveheights','Approvata','2019-02-23','2019-02-25');
     INSERT INTO RICHIESTA (CodRichiesta,Account,StatoRichiesta,DataRichiesta,DataApprovazione) VALUES (1,'iamcampus','Approvata','2019-02-25','2019-02-26');
     INSERT INTO RICHIESTA (CodRichiesta,Account,StatoRichiesta,DataRichiesta,DataApprovazione) VALUES (2,'MasterDani3000','Approvata','2019-02-25','2019-02-28');

    
    
     -- AVANZAMENTO 
     
     INSERT INTO SPEDIZIONE (CodSpedizione, Ordine, CittaArrivo) VALUES ('UEWOSYE9WNAL8T9XGFF9','56F8EB91CBD78BB9D5FF','0');
	 INSERT INTO SPEDIZIONE (CodSpedizione, Ordine, CittaArrivo) VALUES ('UEWOSYE9WNAL8T9XGFF8','56F8EB91CBD78BB9D5FE','0');
     


		INSERT INTO CITTA (CodCitta,Nome,CAP) VALUES ('1','Barcellona',07028);
		INSERT INTO CITTA (CodCitta,Nome,CAP) VALUES ('2','Napoli',07029);
		INSERT INTO CITTA (CodCitta,Nome,CAP) VALUES ('3','Mogoro',07027);	



     INSERT INTO AVANZAMENTO (Spedizione, Citta, DataArrivo) VALUES ('UEWOSYE9WNAL8T9XGFF9','1','2019-01-01') ;
     INSERT INTO AVANZAMENTO (Spedizione, Citta, DataArrivo) VALUES ('UEWOSYE9WNAL8T9XGFF9','2','2019-01-02') ;
     INSERT INTO AVANZAMENTO (Spedizione, Citta, DataArrivo) VALUES ('UEWOSYE9WNAL8T9XGFF9','3','2019-01-03') ;
     
     
     
     
	
     
      INSERT INTO UNITA_RESA (Unita,Prodotto,Richiesta) VALUES (239924742,2,2);
     
     -- PRESTAZIONE  
      
      
      INSERT INTO STAZIONE (CodStazione,Linea,Ordinamento,Faccia,Prodotto) VALUES (1,0,1,3,2);
      INSERT INTO STAZIONE (CodStazione,Linea,Ordinamento,Faccia,Prodotto) VALUES (2,0,2,4,2);
      INSERT INTO STAZIONE (CodStazione,Linea,Ordinamento,Faccia,Prodotto) VALUES (3,0,1,3,2);
      
      
      
      
      INSERT INTO OPERATORE (CodOperatore,StazioneAttuale,InizioMansione,Varianza,Media,CF) VALUES(1,1,'2019-05-11',0,0,'NLQPWJ60M69A658B');
      INSERT INTO OPERATORE (CodOperatore,StazioneAttuale,InizioMansione,Varianza,Media,CF) VALUES(2,2,'2019-05-13',0,0,'NLQPWJ60M69A658C');
      INSERT INTO OPERATORE (CodOperatore,StazioneAttuale,InizioMansione,Varianza,Media,CF) VALUES(3,3,'2019-05-07',0,0,'NLQPWJ60M69A658N');
      
      
      
      
	-- INSERT INTO PRESTAZIONE (Operatore,Operazione,TempoEsecuzione) VALUES (0,0,2.24) ;
    
		INSERT INTO PRESTAZIONE (Operatore,Operazione,TempoEsecuzione) VALUES (0,1,3.42) ;
		INSERT INTO PRESTAZIONE (Operatore,Operazione,TempoEsecuzione) VALUES (0,3,5.6) ;
		INSERT INTO PRESTAZIONE (Operatore,Operazione,TempoEsecuzione) VALUES (0,4,4.43) ;
		INSERT INTO PRESTAZIONE (Operatore,Operazione,TempoEsecuzione) VALUES (0,5,1.3) ;
		
    
   --  INSERT INTO MANSIONI_PRECEDENTI (Operatore,Stazione,DataInizio,DataFine) VALUES (1,0,'2018-03-21','2019-05-09') ; 
    
    
    -- MOTIVAZIONE 
		INSERT INTO MOTIVAZIONE (CodMotivazione,Descrizione,Richiesta) VALUES ('VQYRJXPZVUERF6KYTSL6','Prodotto arrivato già ammaccato',0);
    
    -- STOCCAGGIO 

    
		-- CODICE ERRORE

		INSERT INTO DOMANDA (CodDomanda,Descrizione) VALUES ('9C2CB73253C06D56BF66','La testina è montata correttamente?') ; 
		INSERT INTO DOMANDA (CodDomanda,Descrizione) VALUES ('9C2CB73253C06D56BF65','I connettori sono stati ripuliti? ') ; 



		
		INSERT INTO VALUTAZIONE (Criterio,Recensione,Valutazione) VALUES ('9A833C2E71AC9D34C2B4EB72E76D17','0CAB4D499DFD2A0F0522A3D7716EA3',5) ; 
		INSERT INTO VALUTAZIONE (Criterio,Recensione,Valutazione) VALUES ('9A833C2E71AC9D34C2B4EB72E76D18','0CAB4D499DFD2A0F0522A3D7716EA3',2) ; 
 

			

		

	
		INSERT INTO SOTTOINSIEME_OPERAZIONI (Stazione,Operazione,IndiceOrdinamento) VALUES (0,1,0); 
		INSERT INTO SOTTOINSIEME_OPERAZIONI (Stazione,Operazione,IndiceOrdinamento) VALUES (0,2,1);
		INSERT INTO SOTTOINSIEME_OPERAZIONI (Stazione,Operazione,IndiceOrdinamento) VALUES (0,3,2); 
	
		
		INSERT INTO COD_ERRORE_RIMEDIO (Errore,Prodotto,Guasto,Rimedio) VALUES ('82F01D4BB422B0F4C23A36C77C439A',2,0,0);
		INSERT INTO COD_ERRORE_RIMEDIO (Errore,Prodotto,Guasto,Rimedio) VALUES ('82F01D4BB422B0F4C23A36C77C439A',2,1,1);
		INSERT INTO COD_ERRORE_RIMEDIO (Errore,Prodotto,Guasto,Rimedio) VALUES ('82F01D4BB422B0F4C23A36C77C439A',2,2,2);
	

	
		INSERT INTO SINTOMO (CodSintomo,Descrizione) VALUES (0,'Lo schermo lampeggia'); 
		INSERT INTO SINTOMO (CodSintomo,Descrizione) VALUES (1,'Suono intermittente'); 
		INSERT INTO SINTOMO (CodSintomo,Descrizione) VALUES (2,'Riavvio continuo del motore'); 
		INSERT INTO SINTOMO (CodSintomo,Descrizione) VALUES (3,'Malfunzionamento all accensione periodico'); 
		INSERT INTO SINTOMO (CodSintomo,Descrizione) VALUES (4,'comandi non rispondono'); 
	


		INSERT INTO MALFUNZIONAMENTO (Guasto,Data,Unita,Prodotto) VALUES (1,'2019-03-17',0,2) ; 
		INSERT INTO MALFUNZIONAMENTO (Guasto,Data,Unita,Prodotto) VALUES (0,'2019-04-15',88559744,2);
		INSERT INTO MALFUNZIONAMENTO (Guasto,Data,Unita,Prodotto) VALUES (2,'2019-04-16',44945966,2);
	
	 
		INSERT INTO SINTOMATOLOGIA(Unita, Sintomo, Prodotto, Guasto, Data) VALUES(239924742,1,2,1,'2019-03-17');  
		INSERT INTO SINTOMATOLOGIA(Unita, Sintomo, Prodotto, Guasto, Data) VALUES(239924742,2,2,1,'2019-03-17');  
     
		INSERT INTO SINTOMATOLOGIA(Unita, Sintomo, Prodotto, Guasto, Data) VALUES(88559744,2,2,0,'2019-04-15');  
		INSERT INTO SINTOMATOLOGIA(Unita, Sintomo, Prodotto, Guasto, Data) VALUES(44945966,2,2,2,'2019-04-16');  
     
		/*
		INSERT INTO TENTATIVO (Guasto,Data,Unita,Prodotto,Rimedio,Risolto) VALUES (1,'2019-03-17',239924742,2,2,'1'); 
		INSERT INTO TENTATIVO (Guasto,Data,Unita,Prodotto,Rimedio,Risolto) VALUES (1,'2019-03-17',239924742,2,0,'0'); 
		INSERT INTO TENTATIVO (Guasto,Data,Unita,Prodotto,Rimedio,Risolto) VALUES (1,'2019-03-17',239924742,2,1,'0'); 
		INSERT INTO TENTATIVO (Guasto,Data,Unita,Prodotto,Rimedio,Risolto) VALUES (1,'2019-03-17',239924742,2,3,'0'); 
		INSERT INTO TENTATIVO (Guasto,Data,Unita,Prodotto,Rimedio,Risolto) VALUES (1,'2019-03-17',239924742,2,4,'0');  
		*/
     
     
     
		INSERT INTO SINTOMO_GUASTO (Sintomo,Guasto) VALUES (1,1) ;
		INSERT INTO SINTOMO_GUASTO (Sintomo,Guasto) VALUES (2,2) ;  
     
     
     
		INSERT INTO PRODUZIONE (Tempo,TimeStamp,Operazione,Unita,Prodotto,Stazione) VALUES (2.3,'2019-04-24',0,0,2,0); 
		INSERT INTO PRODUZIONE (Tempo,TimeStamp,Operazione,Unita,Prodotto,Stazione) VALUES (2.6,'2019-04-24',1,0,2,0);
		INSERT INTO PRODUZIONE (Tempo,TimeStamp,Operazione,Unita,Prodotto,Stazione) VALUES (1.5,'2019-04-24',2,0,2,0); 
		INSERT INTO PRODUZIONE (Tempo,TimeStamp,Operazione,Unita,Prodotto,Stazione) VALUES (1.9,'2019-04-24',3,0,2,0); 
     
     
     
	
		INSERT INTO DETTAGLIO (Unita,Prodotto,Ordine,Recensione) VALUES (239924742,2,'56F8EB91CBD78BB9D5FE','0CAB4D499DFD2A0F0522A3D7716EA3') ;
        
		INSERT INTO UNITA (CodSeriale,Prodotto,StatoProduzione,Lotto) VALUES ('88559744',2,'Produzione Finita',0);  
		INSERT INTO UNITA (CodSeriale,Prodotto,StatoProduzione,Lotto) VALUES ('44945964',2,'Produzione Finita',0);
		INSERT INTO UNITA (CodSeriale,Prodotto,StatoProduzione,Lotto) VALUES ('44945966',2,'Produzione Finita',0);
     
     
     
		INSERT INTO UNITA_INCOMPLETA (Unita,Prodotto,TimeStamp,Operazione,Stazione) VALUES (88559744,2,'2019-03-26',0,2);
   
