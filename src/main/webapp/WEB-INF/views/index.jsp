<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}/"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생 검색 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        .slide-modal {
            position: fixed;
            top: 0;
            right: -100%;
            width: 400px;
            height: 100%;
            background: white;
            transition: right 0.3s ease-in-out;
            box-shadow: -2px 0 5px rgba(0,0,0,0.2);
            z-index: 1060;
            padding: 20px;
        }

        .slide-modal.show {
            right: 0;
        }

        .student-row {
            cursor: pointer;
        }

        .student-row:hover {
            background-color: #f5f5f5;
        }


    </style>
</head>
<body>
<!-- 검색바 (폼 방식으로 변경) -->
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="${root}names" method="get">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" name="stu_name" placeholder="이름을 입력하세요...">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">검색</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- 검색 결과 테이블 -->
<div class="container">
    <div class="card">
        <div class="card-body">
            <h3 class="card-title">검색 결과</h3>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th class="d-md-table-cell">이름</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="student" items="${student_name}">
                    <tr class="student-row" onclick="showUserDetail(${student.stu_id})">
                        <td class="d-md-table-cell">${student.stu_id}번${student.stu_name}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty student_name}">
                    <tr>
                        <td class="text-center">검색 결과가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>


<!-- 슬라이드 모달 -->
<div class="slide-modal" id="userDetailModal">
    <div class="p-4">
        <button type="button" class="btn-close float-end" onclick="closeSlideModal()"></button>
        <h4 class="mb-4">학생 상세 정보</h4>
        <div id="userDetailContent"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 검색 버튼 클릭 이벤트
    document.getElementById('searchButton').addEventListener('click', performSearch);

    // 엔터키 이벤트
    document.getElementById('searchInput').addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            performSearch();
        }
    });

    // 검색 수행 함수
    function performSearch() {
        const searchTerm = document.getElementById('searchInput').value;


        if (searchTerm.length > 0) {
            $.ajax({
                url: '${root}names',
                type: 'GET',
                data: { stu_name: searchTerm},
                success: function(students) {
                    displaySearchResults(students);
                },
                error: function(xhr, status, error) {
                    alert('검색 결과가 없습니다.');

                }
            });
        }
    }

    // 검색 결과 표시
    function displaySearchResults(results) {
        const searchResults = document.getElementById('searchResults');

        // results가 배열인지 확인
        console.log("displaySearchResults 함수:", results);

        if (Array.isArray(results) && results.length > 0) {
            let htmlContent = '';
            // 각 학생의 이름을 테이블에 출력
            results.forEach(student => {
                console.log("학생 객체:", student); // student 객체가 올바른지 확인
                console.log("학생 이름:", student.stu_name); // stu_name 값 확인
                htmlContent += `
                <tr class="student-row" onclick="showUserDetail(${student.stu_id})">
                    <td class="d-md-table-cell">${student.stu_name}</td>
                </tr>
            `;
            });
            searchResults.innerHTML = htmlContent;
        } else {
            searchResults.innerHTML = `
            <tr>
                <td class="text-center">검색 결과가 없습니다.</td>
            </tr>
        `;
        }
    }

    // 학생 상세 정보 표시
    function showUserDetail(stu_id) {
        console.log("클릭된 학생 ID:", stu_id);
        $.ajax({
            url: '${root}student/' + stu_id,
            type: 'GET',
            success: function(student) {
                console.log("응답 데이터:", student); // 데이터 출력
                console.log(student.stu_name);
                console.log(student.stu_school);
                const userDetailContent = document.getElementById('userDetailContent');
                userDetailContent.innerHTML =
                    "<div class='mb-3'>" +
                    "<strong>이름:</strong> " + student.stu_name +
                    "</div>" +
                    "<div class='mb-3'>" +
                    "<strong>학교:</strong> " + student.stu_school +
                    "</div>" +
                    "<div class='mb-3'>" +
                    "<strong>전공:</strong> " + student.stu_major +
                    "</div>" +
                    "<div class='mb-3'>" +
                    "<strong>거주지:</strong> " + student.stu_live +
                    "</div>";

                // 모달 열기
                const modal = document.getElementById('userDetailModal');
                modal.classList.add('show');
                modal.style.right = '0';
            },
            error: function(xhr, status, error) {
                console.error("응답 내용:", xhr.responseText);
                console.error("AJAX 요청 실패:", xhr.status, error);
                alert('학생 정보를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }

    // 슬라이드 모달 닫기
    function closeSlideModal() {
        const modal = document.getElementById('userDetailModal');
        modal.classList.remove('show');
        modal.style.right = '-100%';
    }

</script>
</body>
</html>