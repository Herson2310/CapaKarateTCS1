@PetStore
Feature: Tienda de mascotas

  Background:
    Given url 'https://petstore.swagger.io'

  @S_caso01
  Scenario Outline: Registrar una mascota validando por schema v1
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
    * def schema =
      """
      {
        "id": '#number',
        "category": {
          "id": '#number',
          "name": '#string'
        },
        "name": '#string',
        "photoUrls": '#array',
        "tags": '#array',
        "status": '#string'
      }
      """
    * match response == schema

    Examples:
      | id | categoryId | name  |
      | 50 | 10         | pepe  |
      | 20 | 30         | Lucho |
      | 41 | 60         | Rambo |

  @S_caso02
  Scenario Outline: Registrar una mascota validando por schema v2
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
    * def schema =
      """

      {
        id: '#number',
        category: {
          id: '#number',
          name: '#string'
        },
        name: '#string',
        photoUrls: ['#string'],
        tags: [ { id: '#number', name: '#string' } ],
        status: '#string'
      }
      """
    * match response == schema

    Examples:
      | id | categoryId | name      |
      | 10 | 10         | arturo    |
      | 11 | 11         | carloncho |
      | 12 | 12         | woker     |

  @S_caso03
  Scenario Outline: Registrar una mascota utilizando nombres random con metodo java
    * def dataGenerator = Java.type('utilities.DataGenerator')
    * def randomName = dataGenerator.getRandomName()
    * path 'v2/pet'
    * headers { 'accept':'application/json', 'Content-Type': 'application/json'}
    * def bodyPet = read('classpath:features/petStore/bodyRequest/bodyPetSotre.json')
    * set bodyPet.id = <id>
    * set bodyPet.category.id = <categoryId>
    * set bodyPet.name = randomName
    * request bodyPet
    When method post
    Then status 200
    * print 'Respuesta: ', response
    * def schema =
      """

      {
        id: '#number',
        category: {
          id: '#number',
          name: '#string'
        },
        name: '#string',
        photoUrls: ['#string'],
        tags: [ { id: '#number', name: '#string' } ],
        status: '#string'
      }
      """
    * match response == schema

    Examples:
      | id | categoryId |
      | 13 | 13         |
      | 14 | 14         |
      | 15 | 15         |

  @S_caso04
  Scenario Outline: Registrar una mascota y que cuando el id sea mayor de 60 cambie el status
    * def dataGenerator = Java.type('utilities.DataGenerator')
    * def randomName = dataGenerator.getRandomName()
    * path 'v2/pet'
    * headers { 'accept':'application/json', 'Content-Type': 'application/json'}
    * def bodyPet = read('classpath:features/petStore/bodyRequest/bodyPetSotre.json')
    * set bodyPet.id = <id>
    * set bodyPet.category.id = <categoryId>
    * set bodyPet.name = randomName
    #condicional if
    * if (<id> > 60) bodyPet.status = 'sold'
    * request bodyPet
    When method post
    Then status 200
    * print 'Respuesta: ', response
    * def schema =
      """

      {
        id: '#number',
        category: {
          id: '#number',
          name: '#string'
        },
        name: '#string',
        photoUrls: ['#string'],
        tags: [ { id: '#number', name: '#string' } ],
        status: '#string'
      }
      """
    * match response == schema

    Examples:
      | id | categoryId |
      | 61 | 61         |
      | 55 | 55         |

  @S_caso05
  Scenario Outline: Registrar una mascota y que cuando el id sea mayor a 70 cambie el status a pending
    * def dataGenerator = Java.type('utilities.DataGenerator')
    * def randomName = dataGenerator.getRandomName()
    * path 'v2/pet'
    * headers { 'accept':'application/json', 'Content-Type': 'application/json'}
    * def bodyPet = read('classpath:features/petStore/bodyRequest/bodyPetSotre.json')
    * set bodyPet.id = <id>
    * set bodyPet.category.id = <categoryId>
    * set bodyPet.name = randomName
    #operador ternario
    * def status = (<id> > 70) ? 'pending' : 'sold'
    * set bodyPet.status = status
    * request bodyPet
    When method post
    Then status 200
    * print 'Respuesta: ', response
    * def schema =
      """

      {
        id: '#number',
        category: {
          id: '#number',
          name: '#string'
        },
        name: '#string',
        photoUrls: ['#string'],
        tags: [ { id: '#number', name: '#string' } ],
        status: '#string'
      }
      """
    * match response == schema

    Examples:
      | id | categoryId |
      | 64 | 64         |
      | 86 | 86         |

  @S_caso06
  Scenario: consulta la adopcion de una mascota utilizando reitentos
    * configure retry = {count: 5, interval: 3000}
    * path 'v2/pet',85
    * header accept = 'application/json'
    * retry until response.name == 'Viviana'
    When method get
    Then status 200
    * print 'Respuesta: ', response

  @S_caso07
  Scenario: consulta la adopcion de una mascota utilizando reitentos hasta que responda 201
    * configure retry = {count: 5, interval: 3000}
    * path 'v2/pet',85
    * header accept = 'application/json'
    * retry until responseStatus == 200
    When method get
    Then status 200
    * print 'Respuesta: ', response

  @S_caso08
  Scenario: consulta la adopcion de una mascota utilizando tiempo de espera
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    * path 'v2/pet',85
    * header accept = 'application/json'
    When method get
    * eval sleep(5000)
    Then status 200
    * print 'Respuesta: ', response