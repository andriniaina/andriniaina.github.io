---
layout: post
categories: EN MSSQL
title: "A challenge a day: How to partially import data from one MsSql database to another, using DTS/SSIS"
---

**The challenge at my job**: insert and replace the data from table `[A]` from one environment (e.g. PROD) to another (e.g. UAT). However, data in table `[B]` reference the data in table `[A]`.
Do this for N tables in a bloated database with hundreds of tables each cross-referencing each other.

# The solution

```sql
-- BEFORE importing the data
-- Disable all constraints
--     This prevents the foreign keys constraints in `[B]` to block the import
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- Delete the data the table to be copied
--      TRUNCATE is not allowed even if the constraints are disabled.
delete from [A] -- do this for each table to be imported
delete from [X] 
delete from [Y] 
delete from [Z] 



```
Now, Import the data with SQL Server Import and Export Wizard, or SSIS, or whatever.


With the SQL Server Import and Export Wizard, no need to backup the data in a csv and import from it.
It's faster to use the [SQL Server Import and Export Wizard](http://dynamicsgpblogster.wordpress.com/category/sql-server/page/3/)
and select the tables to be exported.

In the mapping properties, make sure to select only the [option 'enable identity insert'](http://bergdaniel.se/wp-content/upload/legacy/enable%20identity%20insert.png).
**DO NOT** select 'Delete rows in existing destination tables' because it will send a `TRUNCATE` command, which is not allowed.

```sql



-- AFTER importing the data:

-- Clean the database
--       **This is the challenging part**
--       Now that the data is imported, your database is a mess:
--       rows in table  `[B]` reference rows that do not exist anymore in table `[A]` !
--
--       Fix it with this script generator:
--       Warning: This works only if you don't have any composite keys,
--        which is most of the time the case.
SELECT ' DELETE FROM [' + OBJECT_NAME(f.parent_object_id) +
	'] WHERE ' + COL_NAME(fc.parent_object_id, fc.parent_column_id) + ' not in '+
	' (select ' + COL_NAME(fc.referenced_object_id, fc.referenced_column_id) +
	' from [' + OBJECT_NAME(f.referenced_object_id) + '])' AS Scripts
FROM.sys.foreign_keys AS f
INNER JOIN.sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id

-- Re-enable all constraints
EXEC sp_msforeachtable 
	@command1="print '?'",
	@command2="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"

-- if some of the tables have identity columns we may want to reseed them
EXEC sp_msforeachtable "DBCC CHECKIDENT ( '?', RESEED)" 
```

Done!
