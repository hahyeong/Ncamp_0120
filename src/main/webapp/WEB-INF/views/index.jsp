<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}/"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학생 검색 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
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

        #openModalButton {
            position: fixed;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
<!-- 모달 오픈 버튼 -->
<button class="btn btn-primary" id="openModalButton" data-bs-toggle="offcanvas" data-bs-target="#insertModal"
        aria-controls="insertModal">
    학생 정보 입력
</button>

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

<!-- Offcanvas (오른쪽에서 슬라이드되는 모달) -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="insertModal" aria-labelledby="insertModalLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="insertModalLabel">학생 정보 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <form id="studentForm" action="${root}insert_proc" method="post">
            <div class="mb-3">
                <label for="stu_name" class="form-label">이름</label>
                <input type="text" class="form-control" id="stu_name" name="stu_name">
            </div>
            <div class="mb-3">
                <label for="stu_live" class="form-label">거주 지역</label>
                <input type="text" class="form-control" id="stu_live" name="stu_live">
            </div>
            <div class="mb-3">
                <label for="stu_school" class="form-label">학교</label>
                <input type="text" class="form-control" id="stu_school" name="stu_school">
            </div>
            <div class="mb-3">
                <label for="stu_major" class="form-label">전공</label>
                <input type="text" class="form-control" id="stu_major" name="stu_major">
            </div>
            <div class="d-flex justify-content-end">
                <button type="button" class="btn btn-primary me-2" onclick="validateForm()">저장</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
            </div>
        </form>
    </div>
</div>

<!-- 경고 모달 -->
<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="alertModalLabel">입력 오류</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                모든 필드를 입력해주세요.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<c:if test="${not empty studentInfo}">
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateModalLabel">정보 수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form:form action="${root}update" method="post" modelAttribute="studentInfo">
                        <form:hidden path="stu_id"/>
                        <div class="form-group">
                            <form:label path="stu_name">이름</form:label>
                            <form:input path="stu_name" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <form:label path="stu_live">주소</form:label>
                            <form:input path="stu_live" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <form:label path="stu_school">학교</form:label>
                            <form:input path="stu_school" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <form:label path="stu_major">전공</form:label>
                            <form:textarea path="stu_major" class="form-control"></form:textarea>
                        </div>
                        <div class="form-group text-right">
                            <button type="submit" class="btn btn-primary">수정완료</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('#updateModal').modal('show');
        });
    </script>
</c:if>


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
                    "</div>"+
                    "<div>" +
                    "<a href='" + ${root} + "update?stu_id=" + student.stu_id + "' class='btn btn-info'>수정</a> " +
                    "<a href='" + ${root} + "delete?stu_id=" + student.stu_id + "' class='btn btn-danger'>삭제</a>" +
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
<script>
    function validateForm() {
        const form = document.getElementById('studentForm');
        const inputs = form.querySelectorAll('input');
        let isValid = true;

        inputs.forEach(input => {
            if (input.value.trim() === '') {
                isValid = false;
            }
        });

        if (!isValid) {
            const alertModal = new bootstrap.Modal(document.getElementById('alertModal'));
            alertModal.show();
        } else {
            form.submit();
        }
    }
</script>


</body>
</html>
