@products
Feature: products

  Background:
    Given url 'https://dummyjson.com'

  @p_Caso01 @regresion
  Scenario: Obtener un producto mediante el id
    # Given url 'https://dummyjson.com'
    And path 'products',2
    When method get
    Then status 200
    * print 'Respuesta: ', response
    * match response.title == 'Eyeshadow Palette with Mirror'
    * match response.title == '#string'
    * match response.dimensions.width == 9.26
    * match response.brand contains 'Beauty'
    #Validar una parte del response
    * match response contains deep { "id": 2, "price": 19.99, "sku": "BEA-GLA-EYE-002", "tags": ["beauty","eyeshadow"] }

  @p_Caso02
  Scenario: busqueda de productos
    # Given url 'https://dummyjson.com'
    * path 'products/search'
    * param q = 'phone'
    When method get
    Then status 200
    * print 'Respuesta: ', response
    * match response.products[0].tags[1] == 'over-ear headphones'

  @p_Caso03
  Scenario: busqueda de productos mediante parametros
    #  Given url 'https://dummyjson.com'
    * path 'products'
    * param sortBy = 'title'
    * param order = 'asc'
    When method get
    Then status 200
    * print 'Respuesta: ', response
  #* match response.products[0].tags[1] == 'over-ear headphones'

  @@p_Caso04 @regresion
  Scenario: busqueda de productos mediante parametros 2
    #  Given url 'https://dummyjson.com'
    * path 'products'
    * params {sortBy : 'title', order: 'asc'}
    When method get
    Then status 200
    * print 'Respuesta: ', response

  @p_Caso05 @regresion
  Scenario: eliminar un producto por el id
    # Given url 'https://dummyjson.com'
    * path 'products',2
    When method delete
    Then status 200
    * print 'Respuesta: ', response

  @p_Caso06
  Scenario: Agregar un producto
    # Given url 'https://dummyjson.com'
    * path 'products/add'
    * header Content-Type = 'application/json'
    * request
      """
      {
        "title": "play 8"

      }

      """
    When method post
    Then status 201
    * print 'Respuesta: ', response
    * match response.title == 'play 8'
    * match response.title == '#string'

  @p_Caso07
  Scenario: Agregar un producto mediante un archivo json
    #  Given url 'https://dummyjson.com'
    * path 'products/add'
    * header Content-Type = 'application/json'
    * def bodyProduct = read('classpath:features/products/bodyRequest/product.json')
    * request bodyProduct
    When method post
    Then status 201
    * print 'Respuesta: ', response
    * match response.title == 'play 8'
    * match response.title == '#string'

  @p_Caso08
  Scenario Outline: Agregar un producto mediante un archivo json aplicando parametrización
    #  Given url 'https://dummyjson.com'
    * path 'products/add'
    * header Content-Type = 'application/json'
    * def bodyProduct = read('classpath:features/products/bodyRequest/product.json')
    * set bodyProduct.title = '<titulo>'
    * request bodyProduct
    When method post
    Then status 201
    * print 'Respuesta: ', response
    * match response.title == '#string'

    Examples:
      | titulo        |
      | samsung S25   |
      | nintendo      |
      | teclado       |
      | laptop Lenovo |

  @p_Caso09
  Scenario Outline: Agregar un producto mediante un archivo json aplicando parametrización
    #  Given url 'https://dummyjson.com'
    * path 'products/add'
    * header Content-Type = 'application/json'
    * def bodyProduct = read('classpath:features/products/bodyRequest/product.json')
    * set bodyProduct.title = '<titulo>'
    * request bodyProduct
    When method post
    Then status 201
    * print 'Respuesta: ', response
    * match response.title == '#string'

    Examples:
      | read('classpath:features/products/data/dataProducts.csv') |