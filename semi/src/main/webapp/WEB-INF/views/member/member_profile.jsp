<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>

<link rel="stylesheet" href="../resources/member/css/member_profile.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	

	$(document).ready(function() {

		//showMessage();
		setTimeout(showMessage, 100);//0.1초후에 메시지 띄워라

	});

	function showMessage() {

		// /member/login_form.do?reason=session_timeout
		if ("${ param.reason == 'session_timeout'}" == "true") {
			alert("로그아웃되었습니다\n로그인을 다시 해주세요");
		}

		if ("${ param.reason == 'no_idx' }" == "true"){
			alert("비정상적인 접근입니다.")
		}
		
		
	}

	function btn_change() {

		// 토글 할 버튼 선택 (btn)

		const btn_change = document.getElementById('btn_change');
		const img_update = document.getElementById('img_update');
		const photo_upload = document.getElementById('photo_upload');

		// btn 숨기기 (display: none)

		if (btn_change.style.display !== 'none') {

			btn_change.style.display = 'none';

			img_update.style.display = 'block';

			photo_upload.style.display = 'block';
		}

	}//end:btn_change()


	function update_photo() {

		let image = $('#photo_upload')[0].files[0];

		var formData = new FormData();

		formData.append('image', image);

		console.log("수정할 이미지 : " + image);

		$.ajax({

			type : "POST",
			url : "member_img_update.do",
			enctype : 'multipart/form-data',
			data : formData,
			processData : false,
			contentType : false,
			success : function(res_data) {
				
				if (res_data == '1') {
					alert("이미지가 수정되었습니다!");
					location.href="profile.do?mem_idx=" + "${ vo.mem_idx }"
				}
			},
			error : function(err) {
				alert("사진을 선택해 주세요")
			}

		});

	}//end:update_photo()

	function del() {

		let image = $('#photo_upload')[0].files[0];

		if (confirm("정말 탈퇴 하시겟습니까?\n확인을 누르면 탈퇴가 진행됩니다") == false) {
			return;
		}

		alert("탈퇴 되었습니다.")

		location.href = "member_delete.do?mem_idx=" + ${vo.mem_idx} + "&image=" + image

	}//end:del()
	
	
	function update_profile(f) {

			let mem_idx		 = f.mem_idx.value;
			let mem_id		 = f.mem_id.value.trim();
			let mem_name	 = f.mem_name.value.trim();
		 	let mem_nickname = f.mem_nickname.value.trim();
			let mem_phone    = f.mem_phone.value;
			let mem_pwd 	 = f.mem_pwd.value.trim();
			let mem_birth	 = f.mem_birth.value.trim();
			let mem_zipcode  = f.mem_zipcode.value.trim();
			let mem_addr 	 = f.mem_addr.value.trim();
			let mem_grade	 = f.mem_grade.value.trim();

			
			f.method="POST";
			f.action="profile_update_form.do";
			f.submit();
			
			

	}//end:update_profile(f)
	
	
</script>


</head>
<body>

<jsp:include page="../common/menubar.jsp"/>
<br><br><br>
<div id="content-wrap-area">


	<div class="memp_box">
		<div class="memp_main">
			<span class="memp_page">기본정보</span>
			<div class="memp_member">
					<div class="memp_img_box">
						<img class="memp_img" id="profile_img_get" src="${ vo.mem_img_url }">
					</div>
					<div class="memp_nickname_box">
						<span class="memp_nickname"> ${ vo.mem_nickname } </span>
					</div>
			</div>
					<div class="memp_img_update_box">
						<input type="file" class="img_preview" id="photo_upload" name="image" 
						 value="사진선택" onchange="get_photo();">
						<input class="memp_img_update1" type="button" value="사진선택"
							id="btn_change" onclick="btn_change()">
						<input class="memp_img_update" type="button" value="사진수정"
							id="img_update" onclick="update_photo()">
					</div>
			<div class="memp_profile_box">
			<form>
			<input type="hidden" name="mem_idx" value="${ vo.mem_idx }">
			<input type="hidden" name="mem_id" value="${ vo.mem_id }">
			<input type="hidden" name="mem_name" value="${ vo.mem_name }">
			<input type="hidden" name="mem_nickname" value="${ vo.mem_nickname }">
			<input type="hidden" name="mem_pwd" value="${ vo.mem_pwd }">
			<input type="hidden" name="mem_phone" value="${ vo.mem_phone }">
			<input type="hidden" name="mem_birth" value="${ vo.mem_birth }">
			<input type="hidden" name="mem_zipcode" value="${ vo.mem_zipcode }">
			<input type="hidden" name="mem_addr" value="${ vo.mem_addr }">
			<input type="hidden" name="mem_grade" value="${ vo.mem_grade }">
				<div class="memp_profile">
					<span class="s_profile">Name.</span><span class="memp_profile_name">${ vo.mem_name }</span>
				</div>
				<hr>
				<div class="memp_profile">
					<span class="s_profile">Nickname.</span><span
						class="memp_profile_nickname">${ vo.mem_nickname }</span>
				</div>
				<hr>
				<div class="memp_profile">
					<span class="s_profile">Member.</span><span class="memp_profile_member">${ vo.mem_grade }</span>
				</div>
				<hr>
				<div class="memp_profile">
					<span class="s_profile">Cell.</span><span
						class="memp_profile_phone">${ vo.mem_phone }</span>
				</div>
				<hr>
				<div class="memp_profile">
					<span class="s_profile">zipcode.</span><span
						class="memp_profile_zipcode">${ vo.mem_zipcode }</span>
				</div>
				<hr>
				<div class="memp_profile">
					<span class="s_profile">addr.</span><span class="memp_profile_addr">${ vo.mem_addr }</span>
				</div>
				<hr>
				<div class="memp_profile">
					<span class="s_profile">Birth.</span><span
						class="memp_profile_birth">${ vo.mem_birth }</span>
				</div>
				<hr>
				<div class="memp_profile">
					<span class="s_profile">가입일.</span><span
						class="memp_profile_regdate">${ fn:substring(vo.mem_regdate,0,16) }</span>
				</div>
				<hr>

				<%-- <c:if test="${ vo.mem_grade eq '기자' }">
					<div class="memp_profile">
						<span class="s_profile">작성한 기사 수.</span><span class="memp_profile_news">5 건</span>
					</div>
				</c:if> --%>
				
					<div class="memp_button_box">
						<input class="memp_update" type="button" value="회원정보 수정"
							onclick="update_profile(this.form)"> <input
							class="memp_delete" type="button" value="회원 탈퇴" onclick="del();">
					</div>
				</form>

			</div>


		</div>

	</div>
	
	<script>
	// 이미지 미리보기 메소드
	function get_photo() {
		
		let my_photo = $("#photo_upload")[0].files;
		
		// 이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(my_photo[0]);
		
		reader.onload = function() {
			$("#profile_img_get").attr('src', reader.result);
		}
		
	}
	</script>
	
	</div>
<!-- TODO : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>