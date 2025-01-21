package kr.bit.controller;

import kr.bit.bean.Student;
import kr.bit.mapper.StudentMapper;
import kr.bit.service.StudentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;


@Controller
public class StudentController {

    @Autowired
    private StudentService studentService;

    // 이름으로 학생 검색
    @GetMapping("/names")
    public String getNames(@RequestParam(value = "stu_name", required = false) String stu_name, Model model) {
        if (stu_name != null && !stu_name.isEmpty()) {
            List<Student> student_name = studentService.getNames(stu_name);
            model.addAttribute("student_name", student_name);
        }
        return "index";
    }

    // 특정 학생 정보 조회
    @GetMapping("/student/{stu_id}")
    @ResponseBody
    public Student getStudent(@PathVariable("stu_id") int stu_id) {
        return studentService.getStudent(stu_id);
    }

    @PostMapping("/insert_proc")
    public String insert_proc(@Valid @ModelAttribute("insertProcBean") Student insertProcBean, BindingResult bindingResult, Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("insertProcBean", insertProcBean);
            return "redirect:/index";
        }

        studentService.insertStudent(insertProcBean);
//        studentService.insertStudentName(insertProcBean);
        return "redirect:/index";
    }

    @GetMapping("/update")
    public String updateUser(@RequestParam("stu_id") int stu_id, Model model) {

        Student student = studentService.getStudentInfoById(stu_id);

        model.addAttribute("studentInfo", student);
        return "index";
    }

    @PostMapping("/update")
    public String updateUser(@ModelAttribute Student student,@RequestParam("stu_id") int stu_id, Model model) {
        studentService.updateUser(student);
        return "redirect:/index";
    }

    @GetMapping("/delete")
    public String deleteUser(@RequestParam("stu_id") int stu_id){
        studentService.delUser(stu_id);
        studentService.deleteUser(stu_id);
        return "redirect:/index";
    }
}
