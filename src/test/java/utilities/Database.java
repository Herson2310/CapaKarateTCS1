package utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    private static String connectionUrl = "jdbc:mysql://localhost:3306/capacitacion?user=root&password=";

    public static void add(String dni, String nombre, String apellido, String servicio, double deuda) {

        try (Connection connect = DriverManager.getConnection(connectionUrl)) {

            connect.createStatement().execute("INSERT INTO clientes (dni,nombre,apellidos,servicio,deuda) VALUES ('" + dni + "','" + nombre + "','" + apellido + "','" + servicio + "', " + deuda + ")");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }
}
