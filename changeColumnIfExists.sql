DROP PROCEDURE IF EXISTS `changeColumnIfExists`;
CREATE PROCEDURE `changeColumnIfExists`(
	IN tableName tinytext,
	IN fieldName tinytext,
	IN newFieldName tinytext,
	IN fieldDef text)
BEGIN
	IF EXISTS (
		SELECT * FROM information_schema.COLUMNS
		WHERE column_name=fieldName
		AND table_name=tableName
		AND table_schema=schema()
		)
	THEN
		SET @sql=CONCAT('ALTER TABLE ', schema(), '.', tableName,
			' CHANGE COLUMN ', fieldName, ' ', newFieldName, ' ', fieldDef);
		PREPARE stmt from @sql;
		EXECUTE stmt;
	END IF;
END
