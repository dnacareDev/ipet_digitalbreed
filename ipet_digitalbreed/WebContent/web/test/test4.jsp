<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap.min.css"> 
<!--  
<link rel="stylesheet" type="text/css" href="../../css/app-assets/css/mdb.min.css">
-->
</head>
<style>
	.container {
	  display: flex;
	  align-items: center;
	  justify-content: center;
	}
	
	.box {
	  width: 100px;
	  height: 100px;
	  background-color: lightblue;
	  border: 1px solid black;
	  margin: 0;
	}
	
	.line {
	  height: 1px;
	  width: 50%;
	  background-color: black;
	  margin: 0 0;
	}

</style>
<body>

<div class="container">
	<div class="row">
		<div class="box"></div>
		<div class="line"></div>
		<div>totally another</div>
		<div class="box"></div>
	</div>
</div>
<div class="row">

</div>


<script src="../../css/app-assets/js/scripts/mdb5/mdb.min.js"></script>
<script>
	const choiceArray = document.querySelectorAll(".choice")
	
	choiceArray.forEach((card) => {
	    card.addEventListener("click", () => {
	        choiceArray.forEach((element) => {
	            element.classList.remove("expand", "unset")
	            element.classList.add('small')
	        })
	        card.classList.remove("small")
	        card.classList.add('expand')
	    });
	});
</script>
</body>
</html>