
package com.example.shoppingmall.controller;
 
 
 import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; import
 org.springframework.web.bind.annotation.GetMapping; import
 org.springframework.web.bind.annotation.RestController;

 import jakarta.servlet.http.HttpSession;
 
 @Controller 
 
 public class MainPageController {

 @GetMapping({"/mainPage","/"}) 
 public String mainPage(HttpSession session, Model model) {
  
  model.addAttribute("roleNo", session.getAttribute("roleNo"));
  model.addAttribute("name", session.getAttribute("name"));
 
  return "mainPage"; } }
