<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
<script type="text/javascript">
	
	fetch('./test.jsp')
	.then((response) => response.text())
	.then((data) => {
		const arr = data.split(",");
		if(arr[arr.length-1] == "") {
			arr.pop();
		}
		console.log(arr);
		for(let i=0 ; i<arr.length ; i++) {
			console.log( Math.floor(Number(arr[i])*100 / 309097251) / 100);
		}
	})
</script>
</html>