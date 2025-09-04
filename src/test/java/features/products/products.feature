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
    #Validar que el campo reviews sea de tipo array
    * match response.reviews == '#array'
    * match response.dimensions.width == 9.26
    #Validar que el campo dimensions width no sea igual al valor
    * match response.dimensions.width != 90.90
    #Validar que el campo brand contenga ese valor
    * match response.brand contains 'Beauty'
    #Validar que el campo sku no contenga ese valor
    * match response.sku !contains 'VENT'
    #Validar que contenga una parte del response
    * match response contains deep { "id": 2, "price": 19.99, "sku": "BEA-GLA-EYE-002", "tags": ["beauty","eyeshadow"] }
    #Validar que el campo tags contenga alguno de los valores de una lista
    * match response.tags contains any ["beauty", "valox"]
    #Validar que el campo tags si o si contenga los valores indicados
    * match response.tags contains only ["beauty", "eyeshadow"]


  @p_Caso02
  Scenario: Obtener todos los productos
    And path 'products'
    When method get
    Then status 200
    * print 'Respuesta: ', response
    #Validar que el array obtenido debe contener al menos un valor que cumpla con la expectativa
    * match response.products[*].price contains '#number'
    #Validar que cada precio del campo price sea numerico
    * match each response.products[*].price == '#number'
    #devuelve todos los price en cualquier profundidad y valida que en esa lista haya al menos un número
    * match response..price contains '#number'
    #Validar que los valores del campo rating contenga este valor
    * match response..rating contains 4.64

  @p_Caso03
  Scenario: Obtener todos los productos y validar por schema
    * def timeValidator = read('classpath:jscript/timeValidator.js')
    And path 'products'
    When method get
    Then status 200
    * print 'Respuesta: ', response
    And match each response.products ==
      """
      {
        "id": '#number',
        "title": '#string',
        "description": '#string',
        "category": '#string',
        "price": '#number',
        "discountPercentage": '#number',
        "rating": '#number',
        "stock": '#number',
        "tags": '#array',
        "brand": '##string',
        "sku": '#string',
        "weight": '#number',
        "dimensions": {
          "width": '#number',
          "height": '#number',
          "depth": '#number'
        },
        "warrantyInformation": '#string',
        "shippingInformation": '#string',
        "availabilityStatus": '#string',
        "reviews": '#array',
        "returnPolicy": '#string',
        "minimumOrderQuantity": '#number',
        "meta": {
          "createdAt": '#? timeValidator(_)',
          "updatedAt": '#? timeValidator(_)',
          "barcode": '#string',
          "qrCode": '#string'
        },
        "images": '#array',
        "thumbnail": '#string'
      }


      """



  @p_Caso04
  Scenario: busqueda de productos
    # Given url 'https://dummyjson.com'
    * path 'products/search'
    * param q = 'phone'
    When method get
    Then status 200
    * print 'Respuesta: ', response
    * match response.products[0].tags[1] == 'over-ear headphones'

  @p_Caso05
  Scenario: busqueda de productos mediante parametros
    #  Given url 'https://dummyjson.com'
    * path 'products'
    * param sortBy = 'title'
    * param order = 'asc'
    When method get
    Then status 200
    * print 'Respuesta: ', response
  #* match response.products[0].tags[1] == 'over-ear headphones'

  @@p_Caso06 @regresion
  Scenario: busqueda de productos mediante parametros 2
    #  Given url 'https://dummyjson.com'
    * path 'products'
    * params {sortBy : 'title', order: 'asc'}
    When method get
    Then status 200
    * print 'Respuesta: ', response

  @p_Caso07 @regresion
  Scenario: eliminar un producto por el id
    # Given url 'https://dummyjson.com'
    * path 'products',2
    When method delete
    Then status 200
    * print 'Respuesta: ', response

  @p_Caso08
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

  @p_Caso09
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

  @p_Caso10
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

  @p_Caso11
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