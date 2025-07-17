<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    $('#loginBtn').click(function() {
  		const username = $('#username').val();
  		const password = $('#password').val();

     	if(!username  ||  !password){
     		alert('아이디와 비밀번호를 모두 입력해주세요.');
     		return;
     	}
   		

      $.ajax({
        url: '/loginAction',
        type: 'POST',
        data: {
          username: username,
          password: password
        },
        success: function(response) {
          // 서버에서 redirectUrl 넘겨줬을 경우
          window.location.href = response.redirectUrl;
        },
        error: function(xhr) {
          if (xhr.responseJSON && xhr.responseJSON.message) {
            alert('로그인 실패: ' + xhr.responseJSON.message);
          } 
        }
      });
    });
  });
</script>

<title>Kurly Login Page</title>
<style>
body {font-family: 'Noto Sans KR', sans-serif; background-color: #ffffff; margin: 0; padding: 0;}
header {background-color: #6b00b6; padding: 8px 16px; color: #fff; display: flex; align-items: center; justify-content: space-between;}
header .logo {font-size: 20px; font-weight: bold;}
.container {max-width: 360px; margin: 60px auto; padding: 30px; text-align: center;}
h2 {font-size: 19px; margin-bottom: 20px;}
input[type="text"], input[type="password"] {width: 100%; padding: 12px; margin-bottom: 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px;}
.find-links {font-size: 13px; color: #555; margin-bottom: 30px;}
.find-links a {color: #6b00b6; text-decoration: none; margin: 0 5px;}
button.login-button {width: 100%; padding: 14px; background-color: #6b00b6; color: #fff; font-size: 15px; border: none; border-radius: 6px; cursor: pointer; margin-bottom: 12px;}
button.signup-button {width: 100%; padding: 14px; background-color: #fff; color: #6b00b6; font-size: 15px; border: 1px solid #6b00b6; border-radius: 6px; cursor: pointer; margin-bottom: 30px;}
.social-login {display: flex; flex-direction: column; gap: 12px; margin-top: 20px;}
button.naver-button {background-color: #03c75a; color: #fff; border: none; padding: 14px; font-size: 15px; border-radius: 6px; cursor: pointer;}
button.kakao-button {background-color: #fee500; color: #000; border: none; padding: 14px; font-size: 15px; border-radius: 6px; cursor: pointer;}
footer {text-align: center; font-size: 12px; color: #888; padding: 18px;}
</style>
</head>
<body>
<header>
  <div class="logo">Kurly</div>
</header>
<div class="container">
  <h2>로그인</h2>
  <input type="text" id="username" placeholder="아이디를 입력해주세요">
  <input type="password" id="password" placeholder="비밀번호를 입력해주세요">
  <div class="find-links">
    <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
  </div>
  <button class="login-button" id="loginBtn">로그인</button>
  <button class="signup-button">회원가입</button>
  <div class="social-login">
    <button class="naver-button">네이버로 계속하기</button>
    <button class="kakao-button">카카오로 계속하기</button>
  </div>
</div>
<footer>
  고객센터 1644-1107 | 월-토 오전 7시~오후 6시<br>
  © Kurly Corp. All Rights Reserved.
</footer>
</body>
</html>

