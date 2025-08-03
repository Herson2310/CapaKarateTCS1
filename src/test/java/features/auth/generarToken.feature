@token
Feature: Generar token

  @getToken
  Scenario: Obtener access_token
    Given url 'https://dummyjson.com'
    * path 'auth/login'
    * header Content-Type = 'application/json'
    * def bodyRequest = read('classpath:features/auth/bodyToken/requestToken.json')
    * request bodyRequest
    When method post
    Then status 200
    * print 'Token: ', response
    * def token = response.accessToken
    * print 'access_token: ', token




