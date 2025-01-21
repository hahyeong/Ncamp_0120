package kr.bit.mapper;

import kr.bit.bean.Student;
import org.apache.ibatis.annotations.Insert;

public interface StudentMapper {

    @Insert("insert into student_info values(null, #{name}, #{live}, #{school}, #{major})")
    void insertStudent(Student insertProcBean);
}
