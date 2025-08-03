Feature: Objects

  Background:
    * url 'https://api.restful-api.dev'

  @ob_Caso001
  Scenario Outline: Agregar y consultar un objeto por el id
    Given path "objects"
    * def requestAdd = read('classpath:features/restful/agregar.json')
    * set requestAdd.name = '<name>'
    * set requestAdd.data.year = <year>
    * set requestAdd.data.price = <price>
    * request requestAdd
    When method post
    Then status 200
    * print 'Respuesta: ', response

    Examples:
      | name          | year | price |
      | iphone 16 pro | 2025 | 5400  |
