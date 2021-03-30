package com.dlt.sys.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/sys")
public class SystemController {


    @GetMapping("/lockScreen")
    public String index(){
        return "/sys/lock_screen";
    }

    @GetMapping("/userInfo")
    public String userInfo(){
        return "/sys/userInfo";
    }

    @GetMapping("/resetPassword")
    public String resetPassword(){
        return "/sys/resetPassword";
    }

}
