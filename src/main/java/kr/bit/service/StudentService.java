package kr.bit.service;

import kr.bit.bean.Student;
import kr.bit.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    private StudentMapper studentMapper;

    public void insertStudent(Student student) {
        studentMapper.insertStudent(student);
    }
}
