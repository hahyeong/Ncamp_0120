package kr.bit.controller;

import kr.bit.bean.Student;
import kr.bit.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
@RequestMapping("/")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @PostMapping("insert_proc")
    public String insert_proc(@Valid @ModelAttribute("insertProcBean") Student insertProcBean, BindingResult bindingResult, Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("insertProcBean", insertProcBean);
            return "redirect:/index";
        }

        studentService.insertStudent(insertProcBean);
        return "redirect:/index";
    }

}
