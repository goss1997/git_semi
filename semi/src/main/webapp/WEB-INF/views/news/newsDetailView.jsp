<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>뉴스 상세 조회</title>
    <style>
        #heart {
        }

        #heart.active {
            fill: red;

        }
    </style>
</head>
<body>

<jsp:include page="../mainpage/mainPage.jsp"/>

<br><br><br><br><br><br><br><br>

    <div>뉴스 idx : ${vo.news_idx}</div>
    <div>뉴스 제목 : ${vo.news_title}</div>
    <div>기자 : ${vo.mem_name}</div>
    <div>뉴스 썸네일 : <img src="${vo.news_thumbnail_image}"></div>
    <div>뉴스 내용 : ${vo.news_content}</div>
    <div>조회 수 : ${vo.news_count}</div>
    <div>뉴스 작성일 : <c:out value="${vo.news_updateAt}" default="${vo.news_createAt}"/></div>
    <div>카테고리 : ${vo.category_name}</div>
    <div>
        <svg style="cursor:pointer" xmlns="http://www.w3.org/2000/svg" id="heart" width="1.5em" height="1em" fill="white" stroke="red"
             stroke-width="50" viewBox="0 0 512 512">
            <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
        </svg>
        : <span id="newsLikeCount"></span>
    </div>
    <br>
</div>
<script>

    // 화면 로딩 시 실행 될 함수
    $(function () {
        checkMemberLike();
        newsLikeCount();
    });

    // 뉴스 좋아요 개수 조회하는 함수
    function newsLikeCount() {
        $.ajax({
            url : "news_like_count.do",
            data : {"news_idx" : ${vo.news_idx} },
            success : function (data) {
                $("#newsLikeCount").html(data);
            }
        })
    }

    // 좋아요 클릭 시 실행 될 함수
    $("#heart").click(function () {
        // 좋아요 통합 구현. 좋아요 <--> 좋아요 취소
        // 하트 색깔 변수로 할당.
        let heartColor = $(this).attr('fill');

        // 좋아요/취소 요청하는 ajax.
        $.ajax({
            url : "news_like_on_off.do",
            data : {
                "heartColor" : heartColor,
                "mem_idx" : 1, // TODO : 로그인한 사용자 고유값으로 변경할 것.
                "news_idx" : ${vo.news_idx}
            },
            success : function (data) {
                if(data > 0) {
                    newsLikeCount();
                    checkMemberLike();
                }
            },
            error : function () {
                alert("좋아요/취소 ajax 요청 실패");
            }
        });

    });

    // 회원이 좋아요한 뉴스인지 체크하는 함수.
    function checkMemberLike() {

        $.ajax({
            url: "check_member_isLike_news.do",
            data: {
                "mem_idx": 1, // TODO : 로그인한 사용자 고유값으로 변경할 것.
                "news_idx": ${vo.news_idx}
            },
            dataType: "json",
            success: function (data) {
                // 상세 조회한 사용자가 해당 뉴스를 좋아요 눌렀을 경우
                if (data == true) {
                    $("#heart").attr('fill', 'red');
                } else {
                    $("#heart").attr('fill', 'white');
                }
            },
            error: function () {
                alert("좋아요 ajax 요청 실패");
            }
        });

    }



</script>


</body>
</html>
