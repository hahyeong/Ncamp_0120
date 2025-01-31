package kr.bit.dao;

import kr.bit.bean.Student;
import kr.bit.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class StudentDao {

    @Autowired
    private StudentMapper studentMapper;

    public List<Student> getNames(String stu_name) {
        return studentMapper.getNames(stu_name);
    }

    public Student getStudent(int stu_id) {
        return studentMapper.getStudent(stu_id);
    }

    public void insertStudent(Student student) {
        studentMapper.insertStudent(student);
    }

    public void insertStudentName(Student student) {
        studentMapper.insertStudentName(student);
    }
    public Student getStudentInfoById(int stu_id) {
        return studentMapper.getStudentInfoById(stu_id);
    }


    public void updateUser(Student studentBean) {
        studentMapper.updateUser(studentBean);
    }

    public void deleteUser(int stu_id) {
        studentMapper.deleteUser(stu_id);
    }

    public void delUser(int stu_id) {
        studentMapper.delUser(stu_id);
    }


}
