package kr.bit.service;

import kr.bit.bean.Student;
import kr.bit.dao.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentDao studentDao;

    public List<Student> getNames(String stu_name) {
        return studentDao.getNames(stu_name);
    }

    public Student getStudent(int stu_id) {
        return studentDao.getStudent(stu_id);
    }

    public void insertStudent(Student student) {
        studentDao.insertStudent(student);
    }
}
