package kr.bit.mapper;

import kr.bit.bean.Student;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface StudentMapper {

    @Select("select stu_id, stu_name from student_info where stu_name=#{stu_name}")
    public List<Student> getNames(String stu_name);

    @Select("select * from student_info where stu_id=#{stu_id}")
    public Student getStudent(int stu_id);

    @Insert("insert into student_info values(null, #{stu_name}, #{stu_live}, #{stu_school}, #{stu_major})")
    void insertStudent(Student insertProcBean);
}
