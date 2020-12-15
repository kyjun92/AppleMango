<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 카카오톡 아이디 연동해서 로그인 -->
<script src = "//developers.kakao.com/sdk/js/kakao.min.js"></script>
<a id="kakao-login-btn"></a>
<a href="http://developers.kakao.com/logout"></a>
<script type='text/javascript'>
Kakao.init('d73e8fb1376ba24961f9614b831082b4'); //아까 카카오개발자홈페이지에서 발급받은 자바스크립트 키를 입력함

//카카오 로그인 버튼을 생성합니다. 
 
Kakao.Auth.createLoginButton({ 
    container: '#kakao-login-btn', 
    success: function(authObj) { 
           Kakao.API.request({
 
               url: '/v2/user/me',
 
               success: function(res) {
 
                     //console.log(res.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)
 
                     //console.log(res.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)
 
                     //console.log(res.properties['nickname']);//<---- 콘솔 로그에 닉네임 출력(properties에 있는 nickname 접근 
          //var kakaonickname = res.properties.nickname//으로도 접근 가능 
                    //console.log(kakaonickname)           
          
                     console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
          
          //var kakao_id = res.id;    //카카오톡 닉네임을 변수에 저장
          //var kakao_email = res.kaccount_email;    //카카오톡 이메일을 변수에 저장함
         
          var kakao_token = authObj.access_token;
 
          //window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/MarketBarly/index.jsp?kakao_id="+kakao_id+"&kakao_email="+kakao_email);
          //window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/MarketBarly/index.jsp?kakao_id="+kakao_id+"&kakaonickname="+kakaonickname);
          //id만 url에서 확인
          //window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/MarketBarly/kakaoLogin.jsp?kakao_id="+kakao_id);
          ///token만 url에서 확인
         // window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/MarketBarly/kakaoLogin.jsp?kakao_token="+kakao_token);
         window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/main.html"+kakao_token);
      
                   }
                 })
               },
               fail: function(error) {
                 alert(JSON.stringify(error));
               }
             });
</script>
</head>
<body>

</body>
</html>