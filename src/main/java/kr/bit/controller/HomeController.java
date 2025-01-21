package kr.bit.controller;

import kr.bit.bean.Student;
import kr.bit.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

    @Autowired
    private StudentService studentService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(@ModelAttribute("insertProcBean")Student insertProcBean, Model model) {
        model.addAttribute("insertProcBean", insertProcBean);

        return "index";
    }

    @GetMapping("index")
    public String index(Model model) {
        return "index";
    }
}
