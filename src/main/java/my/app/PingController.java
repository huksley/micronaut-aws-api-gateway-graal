package my.app;

import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import io.micronaut.http.annotation.*;

@Controller("/")
public class PingController {
    private static final Logger LOG = LoggerFactory.getLogger(PingController.class); // <3>

    @Get("/ping")
    public String index() {
        return "{\"pong\":true, \"graal\": true}";
    }
}
