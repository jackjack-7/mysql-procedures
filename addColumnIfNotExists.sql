DROP PROCEDURE IF EXISTS `addColumnIfNotExists`;
CREATE PROCEDURE `addColumnIfNotExists`(
	IN tableName tinytext,
	IN fieldName tinytext,
	IN fieldDef text)
BEGIN
	IF NOT EXISTS (
		SELECT * FROM information_schema.COLUMNS
		WHERE column_name=fieldName
		AND table_name=tableName
		AND table_schema=schema()
		)
	THEN
		SET @sql=CONCAT('ALTER TABLE ', schema(), '.', tableName,
			' ADD COLUMN ', fieldName, ' ', fieldDef);
		PREPARE stmt from @sql;
		EXECUTE stmt;
	END IF;
END
