<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<c:set var="root" value="${pageContext.request.contextPath}/"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Data</title>
    <!-- 부트스트랩 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 부트스트랩 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
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

<!-- Offcanvas (오른쪽에서 슬라이드되는 모달) -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="insertModal" aria-labelledby="insertModalLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="insertModalLabel">학생 정보 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <form id="studentForm" action="${root}insert_proc" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" name="name">
            </div>
            <div class="mb-3">
                <label for="live" class="form-label">거주 지역</label>
                <input type="text" class="form-control" id="live" name="live">
            </div>
            <div class="mb-3">
                <label for="school" class="form-label">학교</label>
                <input type="text" class="form-control" id="school" name="school">
            </div>
            <div class="mb-3">
                <label for="major" class="form-label">전공</label>
                <input type="text" class="form-control" id="major" name="major">
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
