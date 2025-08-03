@loginUser
Feature: login user

  Background:
    Given url urlDummyJson
    * def token2 = call read('classpath:features/auth/generarToken.feature')

  @log001
  Scenario: loguearme con credenciales validas
    * path 'auth/me'
    # * def token2 = call read('classpath:features/auth/generarToken.feature')
    * header Authorization = token2.token
    When method get
    Then status 200
    * print 'Respuesta: ', response

  @log002
  Scenario: loguearme con credenciales validas
    * path 'auth/me'
    # * def token2 = call read('classpath:features/auth/generarToken.feature')
    * header Authorization = token2.token
    When method get
    Then status 200
    * print 'Respuesta: ', response


  @log003
  Scenario: loguearme con credenciales validas
    * path 'auth/me'
    # * def token2 = call read('classpath:features/auth/generarToken.feature')
    * header Authorization = token2.token
    When method get
    Then status 200
    * print 'Respuesta: ', response


  @log004
  Scenario: loguearme con credenciales validas
    * path 'auth/me'
    # * def token2 = call read('classpath:features/auth/generarToken.feature')
    * header Authorization = token2.token
    When method get
    Then status 200
    * print 'Respuesta: ', response



  @log005
  Scenario: loguearme con credenciales validas
    * path 'auth/me'
    #  * def token2 = call read('classpath:features/auth/generarToken.feature')
    * header Authorization = token2.token
    When method get
    Then status 200
    * print 'Respuesta: ', response


  @log006
  Scenario: loguearme con credenciales validas
    * path 'auth/me'
    # * def token2 = call read('classpath:features/auth/generarToken.feature')
    * header Authorization = token2.token
    When method get
    Then status 200
    * print 'Respuesta: ', response