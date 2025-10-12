Feature: validar tablas en la base de datos

  Background: connect to db
    * def db = Java.type('utilities.Database')

  @db_001
  Scenario: insertar nuevo registro tabla cliente
    * eval db.add("85285285","Dina","Paucar Gonzales", "Agua", 140.20)