package utilities;

import com.github.javafaker.Faker;

public class DataGenerator {

    public static String getRandomName() {

        Faker faker = new Faker();
        String name = faker.name().firstName();

        return name;
    }
}
