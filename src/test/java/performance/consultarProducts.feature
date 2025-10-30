@productsPerformance
Feature: products

  Background:
    Given url 'https://dummyjson.com'
    * karate.pause(3000)

  @perf_Caso01
  Scenario Outline: Obtener un producto mediante el id
    # Given url 'https://dummyjson.com'
    And path 'products',<id>
    When method get
    Then status 200
    * print 'Respuesta: ', response

    Examples:
      | id |
      | 2  |
      | 3  |
      | 4  |