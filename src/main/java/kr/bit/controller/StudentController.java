package kr.bit.controller;

import kr.bit.bean.Student;
import kr.bit.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @PostMapping("insert_proc")
    public String insert_proc(@ModelAttribute("insertProcBean")Student insertProcBean) {
        // 유효성 검사는 일단 기능 완성부터 하고 추가할게요~
        studentService.insertStudent(insertProcBean);
        return "redirect:/index";
    }

}
