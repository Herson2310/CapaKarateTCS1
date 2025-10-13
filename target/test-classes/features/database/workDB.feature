Feature: validar base de datos

  Background: connect to db
    * def db = Java.type('utilities.Database')

  @db_001
  Scenario: insertar nuevo registro tabla cliente
    * eval db.agregarCliente("74174174","Liz","Lobaton Klug", "Gas", 63.50)

  @db_002
  Scenario Outline: insertar registros tabla cliente
    * eval db.agregarCliente("<dni>","<nombre>","<apellidos>", "<servicio>", <deuda>)

    Examples:
      | dni      | nombre  | apellidos      | servicio | deuda  |
      | 56565656 | Julieta | Lascano Ugarte | Telefono | 15.23  |
      | 57575757 | Tito    | Lara Smith     | Cable    | 168.10 |

  @db_003
  Scenario: Obtener campos de un registro por el dni
    * def cliente = db.obtenerRegistro("57575757")
    * print 'DNI: ', cliente.DNI
    * print 'Nombre: ', cliente.NOMBRE
    * print 'Apellidos: ', cliente.APELLIDOS
    * print 'Servicio: ', cliente.SERVICIO
    * print 'Deuda: ', cliente.DEUDA
    * match cliente.NOMBRE == 'Tito'
