function fn() {
  var env = karate.env; // get system property 'karate.env'
  var urlDummyJson = ''

  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  if (env == 'dev') {

    urlDummyJson = 'https://dummyjsondev.com'

  } else if (env == 'cert') {

    urlDummyJson = 'https://dummyjson.com'

  }

   var config = {

      env: env,
      urlDummyJson: urlDummyJson,
      myVarName: 'someValue'

    }

  return config;
}