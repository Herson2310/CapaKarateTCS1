package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.concurrent.duration._
import scala.language.postfixOps


class PerfTest extends Simulation {

  val protocol = karateProtocol(

    "/products/{id}" -> Nil
  )

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  protocol.runner.karateEnv("perf")

  val consultarProducts = scenario("Consultar products").exec(karateFeature("classpath:performance/consultarProducts.feature"))


  setUp(
    consultarProducts.inject(
      //atOnceUsers(1),
      //nothingFor(4 seconds),
      constantUsersPerSec(1) during (10 seconds),
      constantUsersPerSec(5) during (10 seconds),
      //rampUsersPerSec(2) to 10 during (20 seconds),
      //nothingFor(5 seconds),
      //constantUsersPerSec(1) during (5 seconds)
    ).protocols(protocol)

  )

}