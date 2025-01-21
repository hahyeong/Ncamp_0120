package kr.bit.dao;


import kr.bit.bean.Student;
import kr.bit.mapper.StudentMapper;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class StudentoDao {

    @Autowired
    private StudentMapper studentMapper;

    public List<Student> getNames(String stu_name) {
        return studentMapper.getNames(stu_name);
    }

    public Student getStudent(int stu_id) {
        return studentMapper.getStudent(stu_id);
    }
}
