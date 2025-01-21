package kr.bit.mapper;

import kr.bit.bean.Student;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface StudentMapper {

    @Select("select stu_id, stu_name from student_info where stu_name=#{stu_name}")
    public List<Student> getNames(String stu_name);

    @Select("select * from student_info where stu_id=#{stu_id}")
    public Student getStudent(int stu_id);

    @Insert("insert into student_info values(null, #{stu_name}, #{stu_live}, #{stu_school}, #{stu_major})")
    void insertStudent(Student insertProcBean);

    // 뭔가 student_name의 존재 이유가 이게 아닐 것 같은데.. 일단 간단하게 구현만
    @Insert("insert into student_name values(null, #{stu_name})")
    void insertStudentName(Student insertProcBean);

    @Select("select * from student_info where stu_id=#{stu_id}")
    Student getStudentInfoById(int stu_id);

    @Update("update student_info set stu_name=#{stu_name}, stu_live=#{stu_live}, stu_school=#{stu_school}, stu_major=#{stu_major} where stu_id=#{stu_id}")
    void updateUser(Student studentBean);

    @Delete("delete from student_info where stu_id=#{stu_id}")
    void deleteUser(int stu_id);

    @Delete("delete from student_name where stu_id=#{stu_id}")
    void delUser(int stu_id);

}
