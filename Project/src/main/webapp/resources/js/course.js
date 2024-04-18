$(document).ready(function() {
    // 강의 등록 버튼 클릭 시 유효성 검사 및 제출
    $("button[type='submit']").click(function() {
        var title = $("#title").val();
        var isValid = true;

        // 강의 제목 유효성 검사
        if (title.length === 0 || title === null || title.length > 200) {
            $("#titleInput").text("강의 제목을 입력하세요 (1자 이상, 200자 미만)").css("color", "red");
            isValid = false;
        }

        // 강의 가격 유효성 검사
        var priceValue = $("#price").val();
        if (isNaN(priceValue) || priceValue < 0 || priceValue.trim() === "") {
            $("#priceInput").text("숫자를 입력해 주세요!").css("color", "red");
            isValid = false;
        }

        // 모든 인풋 유효성 검사 와 강의 분야 선택 유효성 검사
        var selectedRadio = document.querySelector('input[name="category"]:checked');
        // 유효성 검사를 통과하지 못한 경우 경고창 띄우기
        if (!isValid || !selectedRadio) {
            alert("모든 필드를 올바르게 입력해주세요. 또는 강의분야를 선택해주세요.");
            isValid = false;
        } 

        // 유효성 검사를 통과한 경우 폼 제출
        return isValid;
    });

    // 강의 제목 유효성 검사 및 AJAX 요청
    $("#title").focusout(function() {
        var title = $("#title").val();

        if (title.length > 0 && title.length < 200) {
            $.ajax({
                url: "/Project/Courses/coursesTitleCheck",
                type: "post",
                async: true,
                data: { title: title },
                dataType: "text",
                success: function(data, textStatus) {
                    console.log(data, "");
                    if (data == 'usable') {
                        $("#titleInput").text("사용할 수 있는 강의 제목입니다.").css("color", "blue");
                        $("button[type='submit']").prop("disabled", false);
                    } else {
                        $("#titleInput").text("이미 사용 중인 강의 제목입니다.").css("color", "red");
                        $("button[type='submit']").prop("disabled", true);
                    }
                }
            });
        } else if (title.length === 0 || title === null || title.length >= 200) {
            $("#titleInput").text("강의 제목을 입력하세요 (1자 이상, 200자 미만)").css("color", "red");
            $("button[type='submit']").prop("disabled", true);
        }
    });

    // 강의 가격 유효성 검사
    $("#price").focusout(function() {
        var priceValue = $("#price").val();
        if (isNaN(priceValue) || priceValue < 0 || priceValue.trim() === "") {
            // 숫자가 아니거나 0 미만의 값이거나 빈 문자열인 경우
            $("#priceInput").text("숫자를 입력해 주세요!").css("color", "red");
            $(this).focus(); // 유효하지 않은 경우 해당 필드에 포커스를 유지합니다.
            $("button[type='submit']").prop("disabled", true);
        } else {
            // 유효한 경우
            $("#priceInput").text("올바르게 입력되었습니다.").css("color", "blue");
            $("button[type='submit']").prop("disabled", false);
        }
    });
});
