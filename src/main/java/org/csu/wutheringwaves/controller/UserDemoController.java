package org.csu.wutheringwaves.controller;

import org.csu.wutheringwaves.dto.UserReadResult;
import org.csu.wutheringwaves.service.UserService;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

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

    @GetMapping("/demo/user/page")
    public String showUserPage(
            @RequestParam(defaultValue = "alice") String username,
            Model model
    ) {
        UserReadResult user = userService.findByUsername(username)
                .orElseThrow(() ->
                        new ResponseStatusException(HttpStatus.NOT_FOUND));

        model.addAttribute("message", "Thymeleaf 初始化成功！");
        model.addAttribute("user", user);

        return "demo/user";
    }
}