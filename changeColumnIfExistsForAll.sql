DROP PROCEDURE IF EXISTS `changeColumnIfExistsForAll`;
CREATE PROCEDURE `changeColumnIfExistsForAll`(
	IN schemaName tinytext,
	IN fieldName tinytext,
	IN fieldDef text)
BEGIN
	DECLARE tableName varchar(75) default '';
	DECLARE done INT DEFAULT 0;  
  DECLARE curl CURSOR FOR SELECT table_name FROM information_schema.tables where table_schema=schemaName AND table_name NOT LIKE 'xref_%';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;  
	OPEN curl;  
	REPEAT  
		FETCH curl INTO tableName;  
		IF not done THEN  
			 CALL changeColumnIfExists(tableName,fieldName,fieldDef);
		END IF;  
	UNTIL done END REPEAT;  
	CLOSE curl;
END