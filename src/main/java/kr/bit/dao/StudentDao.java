package kr.bit.dao;

import kr.bit.bean.Student;
import kr.bit.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDao {

    @Autowired
    private StudentMapper studentMapper;

    public void insertStudent(Student student) {
        studentMapper.insertStudent(student);
    }
}
