<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="resources/css/drag2.css">

    <script>
        $(function(){ //페이지가 로드 되면
        	
        	getKanbanList();//전체 일정 불러오기
            
        	action1(); //기존의 todo에 이벤트 걸기

            $(document).on('click', "#todocreate", function(){ //todo 생성 버튼 클릭할 경우
                html = "<p class='draggable' draggable='true'>" + $("#todo").val() +"<br><button id='updat' type='button' class='btn btn-success btn-sm m-2'>수정</button><button id='del' type='button' class='btn btn-success btn-sm m-2'>삭제</button></p>";

                $("#todoboard").append(html);

                document.getElementById("createboard").className += " visually-hidden";

                action1(); //todo에 이벤트 걸기
                
                insertKanban();
            });

        });
        
        //일정 추가 비동기 함수
        function insertKanban(){
        	let requestdata = {
					"k_title": $("#todo").val(), 
					"k_contain": 'todo'
				}
			let data = JSON.stringify(requestdata);
			
			$.ajax({
				type: "post",
				url: "kanban/",
				data: data,
				dataType: "text",
				contentType: "application/json; charset=utf-8",
				success: function(data){
					alert(data);
				}
			});
        }
        
        //일정 수정 비동기 함수
        function updateKanban(){
        	
        	let requestdata = {
        			"k_no": $("#hiddenk_no").val(),
					"k_title": $("#todo1").val()
				}
			let data = JSON.stringify(requestdata);
        	
			$.ajax({
				type: "put",
				url: "kanban/",
				data: data,
				dataType: "text",
				contentType: "application/json; charset=utf-8",
				success: function(data){
					alert(data);
				}
			}); 
        }
        
        //일정 삭제 비동기 함수
        function deleteKanban(k_no){
        	$.ajax({
				type: "DELETE",
				url: "kanban/"+k_no+"/",
				success: function(data){
					alert(data);
				}
			});
        }
        
        //전체 일정 비동기 함수
        function getKanbanList(){
        	$.ajax({
				type: "get",
				url: "kanban/",
				contentType: "application/json; charset=utf-8",
				success: function(data){
					
					$("#todoboard").empty();
					$("#successboard").empty();
					$("#falseboard").empty();
					let html1 = "<h3>ToDo</h3>";
					let html2 = "<h3>Success</h3>";
					let html3 = "<h3>False</h3>";
					
					$.each(data, function(){
						
						if(this.k_contain == 'ToDo'){
							
							html1 += '<p class="draggable" draggable="true">' + this.k_title + '<br>';
							html1 += '<button id="updat" type="button" class="btn btn-success btn-sm m-1" value2="' + this.k_no + '">수정</button>';
							html1 += '<button id="del" type="button" class="btn btn-success btn-sm m-1" value2="' + this.k_no + '">삭제</button>';
							html1 += '</p>';
							
						}else if(this.k_contain == 'Success'){
							
							html2 += '<p class="draggable" draggable="true">' + this.k_title + '<br>';
							html2 += '<button id="updat" type="button" class="btn btn-success btn-sm m-1" value2="' + this.k_no + '">수정</button>';
							html2 += '<button id="del" type="button" class="btn btn-success btn-sm m-1" value2="' + this.k_no + '">삭제</button>';
							html2 += '</p>';
							
						}else{
							
							html3 += '<p class="draggable" draggable="true">' + this.k_title + '<br>';
							html3 += '<button id="updat" type="button" class="btn btn-success btn-sm m-1" value2="' + this.k_no + '">수정</button>';
							html3 += '<button id="del" type="button" class="btn btn-success btn-sm m-1" value2="' + this.k_no + '">삭제</button>';
							html3 += '</p>';
							
						}
					});
					
					$("#todoboard").append(html1);
					$("#successboard").append(html2);
					$("#falseboard").append(html3);
					
					action1();
				}
			});
  
        }
 
        function action1(){
            const draggables = document.querySelectorAll(".draggable"); //nodeList 반환
            const containers = document.querySelectorAll(".container");

            draggables.forEach(draggable => {
                draggable.addEventListener("dragstart", () => {
                    draggable.classList.add("dragging");
                }); 

                draggable.addEventListener("dragend", () => {
                    draggable.classList.remove("dragging");
                    
                    let target = $(event.target);
                    let children1 = $(target).children();
                    let ch = $(children1).children().eq(0);
                    
                    let supertag = target.closest(".container");
                    let childtag = $(supertag).children();
                    
                    let arr = [];
	 		  		let num = 0;
	 		  		
	 		  		$(childtag).each(function(){
	 		  			let request4 = {
		 		  				"k_title": $(this).html().trim().split('<',1)[0],
		 		  				"k_location": num,
		 		  		};
	 		  			
	 		  			arr.push(request4);
	 		  			
	 		  			num += 1;
	 		  		});
	 		  		
	 		  		let main = arr[0].k_title;
	 		  		
	 		  		for(let i=1; i<arr.length; i++){
	 		  			
	 		  			let request5 = {
	 		  					"k_title": arr[i].k_title,
	 		  					"k_location": arr[i].k_location,
	 		  					"k_contain": main
	 		  			}
	 		  			let data = JSON.stringify(request5);
	 		  			$.ajax({
	 						type: "put",
	 						url: "kanban/updateLocation.htm",
	 						data: data,
	 						dataType: "text",
	 						contentType: "application/json; charset=utf-8",
	 						success: function(data){
	 						}
	 					});
	 		  		}
                    
                });
            });

            containers.forEach(container => {
                container.addEventListener("dragover", e => {
                    e.preventDefault();
                    const afterElement = getDragAfterElement(container, e.clientX);
                    const draggable = document.querySelector(".dragging");
                    if (afterElement === undefined) {
                        container.appendChild(draggable);
                    } else {
                        container.insertBefore(draggable, afterElement); //드래그 할수 있는 위치 중 옮겨진 위치에 삽입
                    }
                });
            });

            function getDragAfterElement(container, x) {
                const draggableElements = [
                    ...container.querySelectorAll(".draggable:not(.dragging)"),
                ];

                return draggableElements.reduce(
                    (closest, child) => {
                        const box = child.getBoundingClientRect();
                        const offset = x - box.left - box.width / 2;
                        if (offset < 0 && offset > closest.offset) {
                            return { offset: offset, element: child };
                        } else {
                            return closest;
                        }
                    },
                    { offset: Number.NEGATIVE_INFINITY },
                ).element;
            }

        } 

        //todo 블럭의 삭제를 누를 경우
        $(document).on('click', '#del', function(){
            console.log($(this).parent("p"));
            
            deleteKanban($(this).attr("value2"));
            
            $(this).parent("p").remove();
        });

        let block = "";

        //todo 블럭의 수정을 누를 경우
        $(document).on('click', '#updat', function(){

            $('#todo1').empty(); //기존 문장 지우기

            //보이게하기 숨기기
            if(document.getElementById("createboard1").classList.item(2) == null){
                document.getElementById("createboard1").className += " visually-hidden";
            }else{
                document.getElementById("createboard1").classList.remove("visually-hidden");
            }

            //선택한 todo의 문자열 가져와서 textarea에 넣기
            $('#todo1').val($(this).parent('p').html().trim().split('<',1));
            $("#hiddenk_no").val($(this).attr("value2"));

            block = $(this).parent('p');
        });

        //수정하기의 수정 버튼을 누를 경우
        $(document).on('click', '#todoupdate', function(){
            block.empty();

            html2 = $("#todo1").val() +"<br><button id='updat' type='button' class='btn btn-success btn-sm m-2'>수정</button><button id='del' type='button' class='btn btn-success btn-sm m-2'>삭제</button>"

            block.append(html2);

            document.getElementById("createboard1").className += " visually-hidden";

            action1();

            updateKanban(); //일정수정 
        });

    </script>

</head>
<body>

	<jsp:include page="/WEB-INF/views/inc/header.jsp" />

    <div class="text-center my-5 header">
        <h2>1조 Board</h2>
        <button id="create" type="button" class="btn btn-success" >todo 추가하기</button>
    </div>

    <div class="board">
        <div class="container text-center" id="todoboard">
        </div>
        <div class="container text-center" id="successboard">
        </div>
        <div class="container text-center" id="falseboard">
        </div>
    </div>

    <div id="createboard" class="text-center my-5 visually-hidden">
        <label for="exampleDataList" class="form-label">ToDo 만들기</label>
        <textarea class="form-control" id="todo" placeholder="할일을 작성해주세요"></textarea>
        <button id="todocreate" type="button" class="mt-2 btn btn-success" >추가</button>
    </div>

    <div id="createboard1" class="text-center my-5 visually-hidden">
        <label for="exampleDataList" class="form-label">ToDo 수정하기</label>
        <input type="hidden" id="hiddenk_no" value="" />
        <textarea class="form-control" id="todo1"></textarea>
        <button id="todoupdate" type="button" class="mt-2 btn btn-success">수정</button>
    </div>

    <script>
        //할일 보드 생성
        document.getElementById("create").addEventListener('click', function(){
            
            if(document.getElementById("createboard").classList.item(2) == null){
                document.getElementById("createboard").className += " visually-hidden";
            }else{
                document.getElementById("createboard").classList.remove("visually-hidden");
            }
        })

        //할일 추가
        document.getElementById("todocreate").addEventListener('click', function(){
            let todo = document.getElementById("todo").value;
            console.log(todo);
        })

        document.getElementById("todo").addEventListener('click', function(){
            let todoboard = document.getElementById("todoboard");
            let p = document.createElement("p");
        })

    </script>

</body>

</html>