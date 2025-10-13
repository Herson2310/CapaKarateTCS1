package utilities;

import net.minidev.json.JSONObject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database {

    private static String connectionUrl = "jdbc:mysql://localhost:3306/capacitacion?user=root&password=";

    public static void agregarCliente(String dni, String nombre, String apellido, String servicio, double deuda) {

        try (Connection connect = DriverManager.getConnection(connectionUrl)) {

            connect.createStatement().execute("INSERT INTO clientes (dni,nombre,apellidos,servicio,deuda) VALUES ('" + dni + "','" + nombre + "','" + apellido + "','" + servicio + "', " + deuda + ")");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }

    public static JSONObject obtenerRegistro(String dni) {

        JSONObject json = new JSONObject();

        try (Connection connect = DriverManager.getConnection(connectionUrl)) {

            ResultSet rs = connect.createStatement().executeQuery("SELECT * FROM clientes WHERE dni='" + dni + "'");
            rs.next();

            json.put("DNI", rs.getString("dni"));
            json.put("NOMBRE", rs.getString("nombre"));
            json.put("APELLIDOS", rs.getString("apellidos"));
            json.put("SERVICIO", rs.getString("servicio"));
            json.put("DEUDA", rs.getString("deuda"));

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return json;
    }

}
