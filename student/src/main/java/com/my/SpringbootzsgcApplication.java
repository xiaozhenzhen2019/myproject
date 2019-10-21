package com.my;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"com.my.*"})
@MapperScan("com.my.dao")
public class SpringbootzsgcApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootzsgcApplication.class, args);
    }

}
