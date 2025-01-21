package kr.bit.service;

import kr.bit.bean.Student;
import kr.bit.dao.StudentoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentoDao studentoDao;

    public List<Student> getNames(String stu_name) {
        return studentoDao.getNames(stu_name);
    }

    public Student getStudent(int stu_id) {
        return studentoDao.getStudent(stu_id);
    }

}
