package org.codebone.generator;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.codebone.generator.connector.Column;
import org.codebone.generator.connector.DatabaseConfiguration;
import org.codebone.generator.connector.DatabaseConnector;
import org.codebone.generator.connector.DatabaseType;
import org.codebone.generator.connector.MySQLDatabaseConnector;
import org.codebone.generator.connector.TableHelper;
import org.junit.Test;

public class TestGenerator {
	
	private List<Column> columns;
	
	@Test
	public void generate() throws SQLException {
		String teamplatePath = "template/";
		String generatePath = "test/";
		String tableName = "user";
		String packageName = "kr.io";
		String uri = "test";
		String siteTitle = "title";
		loadData(tableName);
		
		Generator generator = new Generator();
		generator.setSiteTitle(siteTitle);
		generator.setTeamplatePath(teamplatePath);
		generator.setGeneratePath(generatePath);
		generator.setColumns(columns);
		generator.setTableName(tableName);
		generator.setPackageName(packageName);
		generator.setUri(uri);
		generator.generate();
	}
	
	public void loadData(String tableName) throws SQLException {
		DatabaseConfiguration databaseConfiguration = new DatabaseConfiguration(DatabaseType.MYSQL, Define.host, Define.port, Define.database, Define.id, Define.password);
		Connection connection = null;
		DatabaseConnector databaseConnector = new MySQLDatabaseConnector(databaseConfiguration);
		connection = databaseConnector.getConnection();
		columns = TableHelper.getColumns(databaseConnector,tableName);
		connection.close();
	}
}