package org.csu.wutheringwaves.controller;

import org.csu.wutheringwaves.dto.UserReadResult;
import org.csu.wutheringwaves.service.UserService;
import org.springframework.context.annotation.Profile;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Profile("dev")
public class UserDemoController {

    private final UserService userService;

    public UserDemoController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping(value = "/demo/user", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<UserReadResult> findUserByUsername(
            @RequestParam(defaultValue = "hzx") String username
    ) {
        return userService.findByUsername(username)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }
}