@PetStore
Feature: Tienda de mascotas

  Background:
    Given url 'https://petstore.swagger.io'

  @S_caso01
  Scenario: realizar consulta de una mascota registrada
    * path 'v2/pet', 70
    * header accept = 'application/json'
    When method get
    Then status 200
    * print 'Respuesta: ', response
    * match response.id == 70
    * match response.category.id == 40
    * match response.name == 'Solovino'
    * match response.status == '#string'


  @S_caso02
  Scenario: realizar consulta de una mascota registrada
    * path 'v2/pet', 12
    * header accept = 'application/json'
    When method get
    Then status 200
    * print 'Respuesta: ', response
    * match response.id == 12
    * match response.category.id == 1
    * match response.name == 'doggie'
    * match response.status == '#string'

  @S_caso03
  Scenario Outline: realizar consulta de una mascota registrada
    * path 'v2/pet', <idPet>
    * header accept = 'application/json'
    When method get
    Then status 200
    * print 'Respuesta: ', response
    * match response.id == <idPet>
    * match response.category.id == '#number'
    * match response.status == '#string'

    Examples:
      | idPet |
      | 70    |
      | 12    |
      | 5     |
      | 8     |

  @S_caso04
  Scenario Outline: Registrar una mascota
    * path 'v2/pet'
    * headers { 'accept':'application/json', 'Content-Type': 'application/json'}
    * def bodyPet = read('classpath:features/petStore/bodyRequest/bodyPetSotre.json')
    * set bodyPet.id = <id>
    * set bodyPet.category.id = <categoryId>
    * set bodyPet.name = '<name>'
    * request bodyPet
    When method post
    Then status 200
    * print 'Respuesta: ', response

    Examples:
      | id | categoryId | name  |
      | 50 | 10         | pepe  |
      | 20 | 30         | Lucho |
      | 41 | 60         | Rambo |