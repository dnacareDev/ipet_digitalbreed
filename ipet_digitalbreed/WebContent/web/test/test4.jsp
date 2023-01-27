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
	.container{
	     display: flex;
	     width: 100%;
	     padding: 0;
	}
	 .choice{
	     height: 180px;
	     box-sizing: border-box;
	     padding: 0;
	     overflow: hidden;
	     float: left;
	     align-items: center;
	     transition: width 1s;
	     border-radius:3px;
	}
	 .expand{
	     width: 65%;
	}
	 .unset{
	     width: 16%;
	     color: black !important;
	     background-color: #ddd !important;
	}
	 .small{
	     width: 5%;
	     background-color: #ddd !important;
	}
	 .small>div{
	     opacity: 0;
	}
	 .unset > div > p{
	     opacity: 0;
	}
</style>
<body>

<div class="container ">

  <div class="card choice unset bg-primary text-white mx-2">
    <div class="card-body">
      <h5 class="card-title">Card 1</h5>
      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
      <button type="button" class="btn btn-outline-light" data-mdb-ripple-color="dark">Button</button>
    </div>
  </div>

  <div class="card choice unset bg-secondary text-dark mx-2">
    <div class="card-body">
      <h5 class="card-title">Card 2</h5>
      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
      <button type="button" class="btn btn-outline-dark" data-mdb-ripple-color="dark">Button</button>
    </div>
  </div>

  <div class="card choice unset bg-success text-white mx-2">
    <div class="card-body">
      <h5 class="card-title">Card 3</h5>
      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
      <button type="button" class="btn btn-outline-light" data-mdb-ripple-color="dark">Button</button>
    </div>
  </div>

  <div class="card choice unset bg-warning text-dark mx-2">
    <div class="card-body">
      <h5 class="card-title">Card 4</h5>
      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
      <button type="button" class="btn btn-outline-dark" data-mdb-ripple-color="dark">Button</button>
    </div>
  </div>

  <div class="card choice unset bg-danger text-white mx-2">
    <div class="card-body">
      <h5 class="card-title">Card 5</h5>
      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
      <button type="button" class="btn btn-outline-light" data-mdb-ripple-color="dark">Button</button>
    </div>
  </div>

  <div class="card choice unset bg-dark text-white mx-2">
    <div class="card-body">
      <h5 class="card-title">Card 6</h5>
      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
      <button type="button" class="btn btn-outline-light" data-mdb-ripple-color="dark">Button</button>
    </div>
  </div>
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